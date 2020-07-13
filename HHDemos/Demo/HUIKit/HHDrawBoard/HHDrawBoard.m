//
//  HHDrawBoard.m
//  HHDemos
//
//  Created by 胡文(金服银行科技中心网点赋能开发团队平台组) on 2020/7/7.
//  Copyright © 2020 Evan. All rights reserved.
//

#import "HHDrawBoard.h"

@interface HHDrawBoard ()

@property (nonatomic, strong) NSMutableArray *touchPoints;
@property (nonatomic, strong) NSMutableArray *paths;

@end

@implementation HHDrawBoard


#pragma mark - Touch Events
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    HHDrawPath *path = [HHDrawPath pathToPoint:point pathWidth:2 isEraser:NO];
    path.pathColor = [UIColor redColor];
    [self.paths addObject:path];
    [self.touchPoints addObject:[HHDrawPoint drawPoint:point]];
    NSLog(@"%s", __func__);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
   
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    HHDrawPath *path = [self.paths lastObject];
    [path.bezierPath addLineToPoint:point];
    
    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
    shapeLayer.strokeColor = path.pathColor.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineWidth = path.bezierPath.lineWidth;
    shapeLayer.path = path.bezierPath.CGPath;
    NSLog(@"%s", __func__);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    NSLog(@"%s", __func__);
    
    HHDrawPath *path = [self.paths lastObject];
    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
    shapeLayer.strokeColor = path.pathColor.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineWidth = path.bezierPath.lineWidth;
    shapeLayer.path = path.bezierPath.CGPath;
}


#pragma mark = Getter Methods
- (NSMutableArray *)paths {
    if(!_paths){
        _paths = [[NSMutableArray alloc] init];
    }
    return _paths;
}

- (NSMutableArray *)touchPoints {
    if(!_touchPoints){
        _touchPoints = [[NSMutableArray alloc] init];
    }
    return _touchPoints;
}

@end


@interface HHDrawPath ()
@property (nonatomic, assign) CGPoint beginPoint;
@property (nonatomic, assign) CGFloat pathWidth;
@end

@implementation HHDrawPath

+ (instancetype)pathToPoint:(CGPoint)beginPoint pathWidth:(CGFloat)pathWidth isEraser:(BOOL)isEraser {
    
    HHDrawPath *path = [[HHDrawPath alloc] init];
    path.beginPoint = beginPoint;
    path.pathWidth = pathWidth;
    path.isEraser = isEraser;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineWidth = pathWidth;
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    [bezierPath moveToPoint:beginPoint];
    path.bezierPath = bezierPath;
    return path;
}

@end


@implementation HHDrawPoint

+ (instancetype)drawPoint:(CGPoint)point {
    
    HHDrawPoint *drawPoint = [[HHDrawPoint alloc] init];
    drawPoint.x = @(point.x);
    drawPoint.y = @(point.y);
    return drawPoint;
}

@end
