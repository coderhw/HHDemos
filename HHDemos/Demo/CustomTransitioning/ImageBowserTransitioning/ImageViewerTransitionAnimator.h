//
//  ImageViewerTransitionAnimator.h
//  HHDemos
//
//  Created by Huwen on 2025/3/5.
//  Copyright © 2025 Evan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 转场动画实现
@interface ImageViewerTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) BOOL isPresenting;
@end

NS_ASSUME_NONNULL_END
