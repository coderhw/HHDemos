//
//  HHSourceViewController.m
//  HHDemos
//
//  Created by Huwen on 2023/12/23.
//  Copyright © 2023 Evan. All rights reserved.
//

#import "HHSourceViewController.h"
#import "PhotoViewController.h"


#import "PhotoTransitionAnimator.h"

@interface HHSourceViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation HHSourceViewController


- (UIImageView *)imageViewForTransition {
    return self.imageView;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
    _imageView.center = self.view.center;
    _imageView.image = [UIImage imageNamed:@"avator.png"];
    [self.view addSubview:_imageView];
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped)];
    [_imageView addGestureRecognizer:tapGesture];
    _imageView.userInteractionEnabled = YES;
    
}

// 点击事件处理
- (void)imageTapped {
    // 转换frame到window坐标系
    CGRect sourceFrame = [_imageView convertRect:_imageView.bounds toView:nil];
        
    PhotoViewController *vc = [PhotoViewController new];
    vc.image = _imageView.image;
    vc.sourceFrame = sourceFrame;
    vc.sourceImageView = _imageView;
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    vc.transitioningDelegate = vc;
    
    [self presentViewController:vc animated:YES completion:nil];
}



@end
