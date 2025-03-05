//
//  ImageViewerTransitionAnimator.m
//  HHDemos
//
//  Created by Huwen on 2025/3/5.
//  Copyright © 2025 Evan. All rights reserved.
//

#import "ImageViewerTransitionAnimator.h"
#import "ImageBrowserViewController.h"

@implementation ImageViewerTransitionAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)context {
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)context {
    if (self.isPresenting) {
        [self animatePresentation:context];
    } else {
        [self animateDismissal:context];
    }
}

- (void)animatePresentation:(id<UIViewControllerContextTransitioning>)context {
    ImageBrowserViewController *toVC = (ImageBrowserViewController *)[context viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [context containerView];
    
    UIImageView *transitionView = [[UIImageView alloc] initWithFrame:toVC.originFrame];
    transitionView.image = toVC.imageArray[toVC.currentIndex];
    transitionView.contentMode = UIViewContentModeScaleAspectFill;
    transitionView.clipsToBounds = YES;
    
    [container addSubview:toVC.view];
    toVC.view.alpha = 0;
    [container addSubview:transitionView];
    
    [UIView animateWithDuration:[self transitionDuration:context] animations:^{
        transitionView.frame = [self finalFrameForImage:transitionView.image];
    } completion:^(BOOL finished) {
        [transitionView removeFromSuperview];
        toVC.view.alpha = 1;
        [context completeTransition:YES];
    }];
}

- (void)animateDismissal:(id<UIViewControllerContextTransitioning>)context {
    ImageBrowserViewController *fromVC = (ImageBrowserViewController *)[context viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *container = [context containerView];
    
    UIImageView *transitionView = [[UIImageView alloc] initWithFrame:[self currentImageFrame:fromVC]];
    transitionView.image = fromVC.imageArray[fromVC.currentIndex];
    transitionView.contentMode = UIViewContentModeScaleAspectFill;
    transitionView.clipsToBounds = YES;
    
    [fromVC.view removeFromSuperview];
    [container addSubview:transitionView];
    
    [UIView animateWithDuration:[self transitionDuration:context] animations:^{
        transitionView.frame = fromVC.originFrame;
    } completion:^(BOOL finished) {
        [transitionView removeFromSuperview];
        [context completeTransition:YES];
    }];
}

- (CGRect)finalFrameForImage:(UIImage *)image {
    // 计算图片居中后的frame
    CGSize imageSize = image.size;
    CGFloat aspectRatio = imageSize.width / imageSize.height;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat height = screenWidth / aspectRatio;
    if (height > screenHeight) height = screenHeight;
    
    return CGRectMake(0, (screenHeight - height)/2, screenWidth, height);
}

- (CGRect)currentImageFrame:(ImageBrowserViewController *)vc {
    UIScrollView *scrollView = [vc currentScrollView];
    UIImageView *imageView = scrollView.subviews.firstObject;
    return [imageView convertRect:imageView.bounds toView:nil];
}

@end
