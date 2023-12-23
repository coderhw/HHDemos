//
//  HHModelInteractiveAnimatedTranstition.m
//  HHDemos
//
//  Created by Huwen on 2023/12/23.
//  Copyright © 2023 Evan. All rights reserved.
//

#import "HHModelInteractiveAnimatedTranstition.h"

#import "HHModelInteractivePresentAnimator.h"
#import "HHModelInteractivePopAnimator.h"
#import "HHModelPercentDrivenInteractiveTransition.h"

@interface HHModelInteractiveAnimatedTranstition ()

@property (nonatomic, strong) HHModelInteractivePresentAnimator     *customPresent;

@property (nonatomic, strong) HHModelInteractivePopAnimator         *customPop;

@property (nonatomic, strong) HHModelPercentDrivenInteractiveTransition *percentIntractive;

@end

@implementation HHModelInteractiveAnimatedTranstition

/** 转场过渡的图片 */
- (void)setTransitionImgView:(UIImageView *)transitionImgView{
    self.customPresent.transitionImgView = transitionImgView;
    self.customPop.transitionImgView = transitionImgView;
}

/** 转场前的图片frame */
- (void)setTransitionBeforeImgFrame:(CGRect)frame{
    self.customPop.transitionBeforeImgFrame = frame;
    self.customPresent.transitionBeforeImgFrame = frame;
    self.percentIntractive.beforeImageViewFrame = frame;
}

/** 转场后的图片frame */
- (void)setTransitionAfterImgFrame:(CGRect)frame{
    self.customPresent.transitionAfterImgFrame = frame;
    self.customPop.transitionAfterImgFrame = frame;
}

-(void)setBeforeImageViewFrame:(CGRect)beforeImageViewFrame{
    _beforeImageViewFrame = beforeImageViewFrame;
    self.percentIntractive.beforeImageViewFrame = beforeImageViewFrame;
}
- (void)setCurrentImageViewFrame:(CGRect)currentImageViewFrame{
    _currentImageViewFrame = currentImageViewFrame;
    self.percentIntractive.currentImageViewFrame = currentImageViewFrame;
}
- (void)setCurrentImageView:(UIImageView *)currentImageView{
    _currentImageView = currentImageView;
    self.percentIntractive.currentImageView = currentImageView;
}


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    //动画执行者和 nav中一样,故此处不再重写，直接调用之前navigation中的创建好的类
    return self.customPresent;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    //动画执行者和 nav中一样,故此处不再重写，直接调用之前navigation中的创建好的类
    return self.customPop;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    if (self.gestureRecognizer)
        return self.percentIntractive;
    else
        return nil;
}

- (void)setGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer{
    _gestureRecognizer = gestureRecognizer;
}

- (HHModelInteractivePresentAnimator *)customPresent{
    if (_customPresent == nil) {
        _customPresent = [[HHModelInteractivePresentAnimator alloc]init];
    }
    return _customPresent;
}
- (HHModelInteractivePopAnimator *)customPop{
    if (!_customPop) {
        _customPop = [[HHModelInteractivePopAnimator alloc] init];
    }
    return _customPop;
}
- (HHModelPercentDrivenInteractiveTransition *)percentIntractive{
    if (!_percentIntractive) {
        _percentIntractive = [[HHModelPercentDrivenInteractiveTransition alloc] initWithGestureRecognizer:self.gestureRecognizer];
    }
    return _percentIntractive;
    
}
@end
