//
//  HHFirstViewController.m
//  HHDemos
//
//  Created by Huwen on 2023/12/23.
//  Copyright © 2023 Evan. All rights reserved.
//

#import "HHFirstViewController.h"
#import "HHSecondViewController.h"
#import "HHModelInteractiveAnimatedTranstition.h"

@interface HHFirstViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) HHModelInteractiveAnimatedTranstition *animationTranstition;


@end

@implementation HHFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
    _imageView.center = self.view.center;
    _imageView.image = [UIImage imageNamed:@"avator.png"];
    [self.view addSubview:_imageView];
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
    [_imageView addGestureRecognizer:tapGesture];
    _imageView.userInteractionEnabled = YES;

}

- (void)tapGesture {
    NSLog(@"tapGesture");
    
    self.animationTranstition = nil;
    
    [self.animationTranstition setTransitionImgView:_imageView];
    [self.animationTranstition setTransitionBeforeImgFrame:_imageView.frame];
    [self.animationTranstition setTransitionAfterImgFrame:[self backScreenImageViewRectWithImage:_imageView.image]];

    
    HHSecondViewController *secondViewController = [[HHSecondViewController alloc] init];
    //1.设置代理
    secondViewController.transitioningDelegate = self.animationTranstition;
    secondViewController.beforeImageViewFrame = _imageView.frame;
    //2.Presend 跳转
    [self presentViewController:secondViewController animated:YES completion:nil];
}


- (HHModelInteractiveAnimatedTranstition *)animationTranstition {
    
    if(!_animationTranstition) {
        _animationTranstition = [[HHModelInteractiveAnimatedTranstition alloc] init];
    }
    return _animationTranstition;
}

//返回imageView在window上全屏显示时的frame
- (CGRect)backScreenImageViewRectWithImage:(UIImage *)image{
    
    CGSize size = image.size;
    CGSize newSize;
    newSize.width = kScreenWidth;
    newSize.height = newSize.width / size.width * size.height;
    CGFloat imageY = (kScreenHeight - newSize.height) * 0.5;
    if (imageY < 0) {
        imageY = 0;
    }
    CGRect rect =  CGRectMake(0, imageY, newSize.width, newSize.height);
    return rect;
}


@end
