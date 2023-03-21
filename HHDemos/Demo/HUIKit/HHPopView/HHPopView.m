//
//  HHPopView.m
//  HHDemos
//
//  Created by Huwen on 2023/3/20.
//  Copyright © 2023 Evan. All rights reserved.
//

#import "HHPopView.h"

@interface HHPopView ()


@end

@implementation HHPopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.backgroundColor = [UIColor magentaColor];
        self.backgroundColor = [UIColor clearColor];
        [self addBorderLine];
    }
    return self;
}

- (void)addBorderLine {
    
    CGFloat width = 180;
    CGFloat height = 120;
    CGFloat arrowRightPadding = 36;
    CGFloat arrowWidth = 16;
    CGFloat arrowHeight = 8;
    
    // draw rect
    UIBezierPath *borderLine = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 0, width, height) cornerRadius:8.0f];
    UIBezierPath *trangleLine = [UIBezierPath bezierPath];
    // draw arrow
    [trangleLine moveToPoint:CGPointMake(width - arrowRightPadding, height)];
    [trangleLine addLineToPoint:CGPointMake(width - arrowRightPadding + arrowWidth, height)];
    [trangleLine addLineToPoint:CGPointMake(width - arrowRightPadding + arrowWidth/2, height + arrowHeight)];
    [trangleLine addLineToPoint:CGPointMake(width - arrowRightPadding, height)];
    [borderLine appendPath:trangleLine];
    
    CAShapeLayer *topEllipase = [CAShapeLayer layer];
    topEllipase.strokeColor = [UIColor whiteColor].CGColor;
    topEllipase.fillColor = [UIColor whiteColor].CGColor;
    topEllipase.lineWidth = 2;
    topEllipase.lineJoin = kCALineJoinRound;
    topEllipase.lineCap = kCALineCapRound;
    topEllipase.path = borderLine.CGPath;
    [topEllipase setFillRule:kCAFillRuleNonZero];
    [self.layer addSublayer:topEllipase];
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 40, 32)];
    [button setTitle:@"123" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
}


- (void)buttonPressed:(UIButton *)sender {
    
}


@end
