//
//  HHCustomTransitionAnimator.m
//  HHDemos
//
//  Created by 胡文(平安银行金融科技部零售研发中心基础零售研发团队口袋平台iOS) on 2025/3/5.
//  Copyright © 2025 Evan. All rights reserved.
//

#import "PhotoTransitionAnimator.h"



@implementation PhotoTransitionAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    
    if (self.transitionType == TransitionTypePresent) {
        // Present 动画
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIImageView *transitionImageView = [[UIImageView alloc] initWithImage:self.sourceImageView.image];
        transitionImageView.contentMode = UIViewContentModeScaleAspectFill;
        transitionImageView.clipsToBounds = YES;
        transitionImageView.frame = self.startFrame;
        
        [containerView addSubview:toVC.view];
        [containerView addSubview:transitionImageView];
        
        toVC.view.alpha = 0;
        self.sourceImageView.alpha = 0;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            transitionImageView.frame = [self finalFrameForImage:toVC.view];
            toVC.view.alpha = 1;
        } completion:^(BOOL finished) {
            [transitionImageView removeFromSuperview];
            self.sourceImageView.alpha = 1;
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
        
    } else {
        // Dismiss 动画
        UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        
        UIImageView *transitionImageView = [[UIImageView alloc] initWithImage:self.sourceImageView.image];
        transitionImageView.contentMode = UIViewContentModeScaleAspectFill;
        transitionImageView.clipsToBounds = YES;
        transitionImageView.frame = [self finalFrameForImage:fromVC.view];
        
        [containerView addSubview:transitionImageView];
        [containerView bringSubviewToFront:transitionImageView];
        
        fromVC.view.alpha = 1;
        self.sourceImageView.alpha = 0;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            transitionImageView.frame = self.startFrame;
            fromVC.view.alpha = 0;
        } completion:^(BOOL finished) {
            [transitionImageView removeFromSuperview];
            self.sourceImageView.alpha = 1;
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    }
}

- (CGRect)finalFrameForImage:(UIView *)view {
    UIImage *image = self.sourceImageView.image;
    if (!image) return view.bounds;
    
    CGFloat width = view.frame.size.width;
    CGFloat height = width * image.size.height / image.size.width;
    CGFloat y = (view.frame.size.height - height) / 2;
    return CGRectMake(0, y, width, height);
}


@end
