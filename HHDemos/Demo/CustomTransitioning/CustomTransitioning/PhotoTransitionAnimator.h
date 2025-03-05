//
//  HHCustomTransitionAnimator.h
//  HHDemos
//
//  Created by 胡文(平安银行金融科技部零售研发中心基础零售研发团队口袋平台iOS) on 2025/3/5.
//  Copyright © 2025 Evan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TransitionType) {
    TransitionTypePresent,
    TransitionTypeDismiss
};

NS_ASSUME_NONNULL_BEGIN

@interface PhotoTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) TransitionType transitionType;
@property (nonatomic, assign) CGRect startFrame;
@property (nonatomic, weak) UIImageView *sourceImageView;

@end



NS_ASSUME_NONNULL_END
