//
//  HHSecondViewController.m
//  HHDemos
//
//  Created by Huwen on 2023/12/23.
//  Copyright © 2023 Evan. All rights reserved.
//

#import "HHSecondViewController.h"
#import "HHModelInteractiveAnimatedTranstition.h"

@interface HHSecondViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGPoint transitionImgViewCenter;

@property (nonatomic, strong) HHModelInteractiveAnimatedTranstition *animatedTransition;
@end

@implementation HHSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 

    UIImage *image = [UIImage imageNamed:@"avator"];
    CGSize size = [self backImageSize:image];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (kScreenHeight - size.height) * 0.5, size.width, size.height)];
    _imageView.image = image;
    _imageView.userInteractionEnabled = YES;
    [self.view addSubview:_imageView];

    self.transitionImgViewCenter = _imageView.center;
    UIPanGestureRecognizer *interactiveTransitionRecognizer;
    interactiveTransitionRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(interactiveTransitionRecognizerAction:)];
    [self.view addGestureRecognizer:interactiveTransitionRecognizer];
}

- (CGSize)backImageSize:(UIImage *)image {
    
    CGSize size = image.size;
    CGSize newSize;
    newSize.width = kScreenWidth;
    newSize.height = newSize.width / size.width * size.height;
    return newSize;
}

- (void)interactiveTransitionRecognizerAction:(UIPanGestureRecognizer *)gestureRecognizer {
    
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    CGFloat scale = 1 - fabs(translation.y / kScreenHeight);
    scale = scale < 0 ? 0 : scale;
    
    NSLog(@"second = %f", scale);
    __weak typeof(self) weakSelf = self;
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStatePossible:
            break;
        case UIGestureRecognizerStateBegan:{
            
            //1. 设置代理
            self.animatedTransition = nil;
            self.transitioningDelegate = self.animatedTransition;
            self.animatedTransition.gestureRecognizer = gestureRecognizer;
                        //3.dismiss
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case UIGestureRecognizerStateChanged: {
            
            _imageView.center = CGPointMake(self.transitionImgViewCenter.x + translation.x * scale, self.transitionImgViewCenter.y + translation.y);
            _imageView.transform = CGAffineTransformMakeScale(scale, scale);
            self.animatedTransition.beforeImageViewFrame = self.beforeImageViewFrame;
        }
            break;
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            
            if (scale > 0.95f) {
                [UIView animateWithDuration:0.2 animations:^{
                    
                    weakSelf.imageView.center = self.transitionImgViewCenter;
                    weakSelf.imageView.transform = CGAffineTransformMakeScale(1, 1);
                } completion:^(BOOL finished) {
                    
                    weakSelf.imageView.transform = CGAffineTransformIdentity;
                }];
            }else{
                
            }
            self.animatedTransition.currentImageView = _imageView;
            self.animatedTransition.currentImageViewFrame = _imageView.frame;
            self.animatedTransition.gestureRecognizer = nil;
        }
    }
}

- (HHModelInteractiveAnimatedTranstition *)animatedTransition{
    if (!_animatedTransition) {
        _animatedTransition = [[HHModelInteractiveAnimatedTranstition alloc] init];
    }
    return _animatedTransition;
}

@end
