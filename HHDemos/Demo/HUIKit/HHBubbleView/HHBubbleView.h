//
//  HHBubbleView.h
//  HHDemos
//
//  Created by 胡文(金服银行科技中心网点赋能开发团队平台组)(HUWEN824) on 2023/11/3.
//  Copyright © 2023 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHBubbleView : UIView

+ (instancetype)bubbleView;
- (void)show:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
