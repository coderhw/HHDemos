
//
//  Created by Evan on 14-8-21.
//  Copyright (c) 2014年 XXXX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (ContentSize)

/**
 *  计算文字的高度
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 *
 *  @return 文字高度
 */
- (CGFloat)paba_heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;

/**
 *  计算文字的宽度
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 *
 *  @return 文字宽度
 */
- (CGFloat)paba_widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

@end
