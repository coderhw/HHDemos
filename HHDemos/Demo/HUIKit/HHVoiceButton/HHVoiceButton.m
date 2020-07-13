//
//  HHVoiceButton.m
//  HHDemos
//
//  Created by xxx on 2020/7/10.
//  Copyright © 2020 Evan. All rights reserved.
//

#import "HHVoiceButton.h"

#define kLineWidth 1.5

@interface HHVoiceButton ()

@property (nonatomic, strong) CAShapeLayer *mask;
@property (nonatomic, strong) CADisplayLink *link;
@end

@implementation HHVoiceButton


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor darkGrayColor];
        [self drawBottomLine];
        
        self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(action)];
        [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];

    }
    return self;
}


- (void)drawBottomLine {

    
    CGFloat edgeSpace = 6;
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat heigth = CGRectGetHeight(self.frame);
    
    CGFloat topRoundH = 12;
    CGFloat topRoundW = 6;

    UIBezierPath *ellipasePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(width/2 - topRoundW/2, 0, topRoundW, topRoundH)
                                               byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(4, 4)];
    
    CAShapeLayer *topEllipase = [CAShapeLayer layer];
    topEllipase.strokeColor = [UIColor whiteColor].CGColor;
    topEllipase.fillColor = [UIColor whiteColor].CGColor;
    topEllipase.lineWidth = kLineWidth;
    topEllipase.lineJoin = kCALineJoinRound;
    topEllipase.lineCap = kCALineCapRound;
    topEllipase.path = ellipasePath.CGPath;
    [self.layer addSublayer:topEllipase];
   
    
    
    UIBezierPath *ellipasePath2 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(width/2 - topRoundW/2, 0,
                                                                                     topRoundW, topRoundH)
    byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(4, 4)];
    
    CAShapeLayer *topEllipase2 = [CAShapeLayer layer];
    topEllipase2.strokeColor = [UIColor greenColor].CGColor;
    topEllipase2.fillColor = [UIColor greenColor].CGColor;
    topEllipase2.lineWidth = kLineWidth;
    topEllipase2.lineJoin = kCALineJoinRound;
    topEllipase2.lineCap = kCALineCapRound;
    topEllipase2.path = ellipasePath2.CGPath;
        
    
    _mask = [CAShapeLayer layer];
    _mask.frame = CGRectMake(0 , 0, 22, 22);
    _mask.backgroundColor = [UIColor greenColor].CGColor;
    topEllipase2.mask = _mask;
    
    [self.layer addSublayer:topEllipase2];
    
    
    CGFloat spaceH = 3;
    CGFloat spaceV = 3;
    UIBezierPath *centerEllipase = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(width/2 - topRoundW/2 - spaceH, 0,
                                                                                      topRoundH, topRoundH + spaceV)
                                                        byRoundingCorners:UIRectCornerAllCorners
                                                               cornerRadii:CGSizeMake(6, 6)];
    
    ///底部横竖线
    [centerEllipase moveToPoint:CGPointMake(width/2, topRoundH + 3)];
    [centerEllipase addLineToPoint:CGPointMake(width/2, topRoundH + 6)];
    [centerEllipase moveToPoint:CGPointMake(edgeSpace, topRoundH + 7)];
    [centerEllipase addLineToPoint:CGPointMake(width - edgeSpace, topRoundH + 7)];

    
    CAShapeLayer *centerEllipaseLayer = [CAShapeLayer layer];
    centerEllipaseLayer.strokeColor = [UIColor whiteColor].CGColor;
    centerEllipaseLayer.fillColor = [UIColor clearColor].CGColor;
    centerEllipaseLayer.lineWidth = kLineWidth;
    centerEllipaseLayer.lineJoin = kCALineJoinRound;
    centerEllipaseLayer.lineCap = kCALineCapRound;
    centerEllipaseLayer.path = centerEllipase.CGPath;
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame  = CGRectMake(0, heigth/2 - 2, 100, 100);
    maskLayer.backgroundColor = [UIColor greenColor].CGColor;
    centerEllipaseLayer.mask = maskLayer;
    [self.layer addSublayer:centerEllipaseLayer];

    
}


- (void)action {
    
    int x = arc4random() % 100;
    CGFloat value = arc4random() % 500 + x;
    [self updateVolume:value];

}

- (void)updateVolume:(CGFloat)volume {
    
    CGFloat topRoundH = 12;
    CGFloat maxVolume = 800;
    CGFloat currentVolume = volume;
    CGFloat percent = currentVolume / maxVolume;
    
    CGFloat maskHeight = percent * topRoundH;
    CGFloat originY = topRoundH - maskHeight;
    CGRect frame = _mask.frame;
    CGRect newFrame = frame;
    newFrame.origin.y = originY;
    newFrame.size.height = maskHeight + 2;
    _mask.frame = newFrame;
}

@end
