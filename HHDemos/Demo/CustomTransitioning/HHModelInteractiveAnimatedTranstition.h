//
//  HHModelInteractiveAnimatedTranstition.h
//  HHDemos
//
//  Created by Huwen on 2023/12/23.
//  Copyright © 2023 Evan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHModelInteractiveAnimatedTranstition : NSObject<UIViewControllerTransitioningDelegate>


@property (nonatomic, assign) CGRect            beforeImageViewFrame;    //图片的frame
@property (nonatomic, assign) CGRect            currentImageViewFrame;   //当前图片的frame
@property (nonatomic, strong) UIImageView      *currentImageView;        //当前图片


@property (nonatomic, strong) UIPanGestureRecognizer *gestureRecognizer;


/** 转场过渡的图片 */
- (void)setTransitionImgView:(UIImageView *)transitionImgView;

/** 转场前的图片frame */
- (void)setTransitionBeforeImgFrame:(CGRect)frame;

/** 转场后的图片frame */
- (void)setTransitionAfterImgFrame:(CGRect)frame;


@end

NS_ASSUME_NONNULL_END
