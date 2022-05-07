//
//  HHDrawBoard.h
//  HHDemos
//
//  Created by xx on 2020/7/7.
//  Copyright © 2020 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHDrawBoard : UIView

@end



@interface HHDrawPath : NSObject
/// 画笔颜色
@property (nonatomic, strong) UIColor       *pathColor;
/// 线宽
@property (nonatomic, assign) CGFloat       lineWidth;
/// 橡皮擦
@property (nonatomic, assign) BOOL          isEraser;
/// 贝塞尔路径
@property (nonatomic, strong) UIBezierPath  *bezierPath;

+ (instancetype)pathToPoint:(CGPoint)beginPoint pathWidth:(CGFloat)pathWidth isEraser:(BOOL)isEraser;

@end

@interface HHDrawPoint : NSObject

@property (nonatomic, strong) NSNumber *x;
@property (nonatomic, strong) NSNumber *y;

+ (instancetype)drawPoint:(CGPoint)point;

@end


NS_ASSUME_NONNULL_END
