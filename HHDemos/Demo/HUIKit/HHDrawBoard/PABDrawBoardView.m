//
//  PANimDrawBoardView.m
//  WDrawing
//
//  Created by xx on 2020/6/19.
//  Copyright © 2020 W.Miga. All rights reserved.
//

#import "PABDrawBoardView.h"

#define kBackButtonWidth    60
#define kBackButtonHeight   40
#define kPaddingH   20
#define kPaddingV   20
#define kButtonTag 1000

@interface PABDrawBoardView ()

@property (nonatomic, strong) NSMutableArray *drawPaths;
@property (nonatomic, strong) NSMutableArray *drawLayers;
///回退
@property (nonatomic, strong) UIButton *backButton;
///清空
@property (nonatomic, strong) UIButton *cleanButton;
///橡皮擦
@property (nonatomic, strong) UIButton *eraserButton;

@end

@implementation PABDrawBoardView

+ (instancetype)drawBoardView {
    return [[PABDrawBoardView alloc] init];
}

- (void)showWithView:(UIView *)superView {
    if(superView){
        self.frame = CGRectMake(0, 0, superView.frame.size.width, superView.frame.size.height);
        [self addSubview:self.backButton];
        [self addSubview:self.cleanButton];
        [self addSubview:self.eraserButton];
        [superView addSubview:self];
    }
}

//- (instancetype)initWithFrame:(CGRect)frame {
//
//    self = [super initWithFrame:frame];
//    if (self) {
//
//        [self addSubview:self.backButton];
//        [self addSubview:self.cleanButton];
//        [self addSubview:self.eraserButton];
//    }
//    return self;
//}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:[[touches anyObject] locationInView:self]];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.backgroundColor = [UIColor clearColor].CGColor;
    layer.frame = self.bounds;
    layer.path = path.CGPath;
    layer.lineWidth = 4.0f;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.miterLimit = 2.;
    layer.lineDashPhase = 10;
    layer.lineDashPattern = @[@1,@0];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.fillRule = kCAFillRuleEvenOdd;
    layer.lineCap = kCALineCapRound;
    layer.lineJoin = kCALineJoinRound;
    
    // 将layer添加进图层
    [self.layer addSublayer:layer];
    [self.drawPaths addObject:path];
    [self.drawLayers addObject:layer];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
    [super touchesMoved:touches withEvent:event];
    UIBezierPath *path = self.drawPaths.lastObject;
    CAShapeLayer *layer = self.drawLayers.lastObject;
    [path addLineToPoint:[[touches anyObject] locationInView:self]];
    layer.path = path.CGPath;
}

- (NSMutableArray *)drawPaths{
    if (_drawPaths == nil) {
        _drawPaths = [NSMutableArray array];
    }
    return _drawPaths;
}

- (NSMutableArray *)drawLayers{
    if (_drawLayers == nil) {
        _drawLayers = [NSMutableArray array];
    }
    return _drawLayers;
}

#pragma mark - Action
- (void)backButtonPressed:(UIButton *)sender {
    NSInteger tagIndex = sender.tag - kButtonTag;
    switch (tagIndex) {
        case 1:
        {
            CAShapeLayer * layer = self.drawLayers.lastObject;
             [layer removeFromSuperlayer];
            [self.drawLayers removeLastObject];
        }
            break;
        case 2:
        {
            for(CAShapeLayer * layer in self.drawLayers) {
                [layer removeFromSuperlayer];
            }
            self.drawLayers = nil;
            [self.drawPaths removeAllObjects];
        }
            break;
        case 3:
        {
            
        }
            break;
        default:
            break;
    }
    NSLog(@"backButtonPressed");
}

#pragma mark - Getter Methods
- (UIButton *)backButton {
    
    if(!_backButton){
         _backButton = [[UIButton alloc] initWithFrame:
                              CGRectMake(CGRectGetWidth(self.frame) - kBackButtonWidth*1 - kPaddingH*1,
                                         CGRectGetHeight(self.frame) - kBackButtonHeight - kPaddingV,
                                         kBackButtonWidth, kBackButtonHeight)];
       _backButton.backgroundColor = [UIColor clearColor];
       [_backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
       _backButton.titleLabel.font = [UIFont systemFontOfSize:14];
       _backButton.tag = kButtonTag + 2;
       [_backButton setTitle:@"撤回" forState:UIControlStateNormal];
       [_backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UIButton *)cleanButton {
    
    if(!_cleanButton){
        _cleanButton = [[UIButton alloc] initWithFrame:
                       CGRectMake(CGRectGetWidth(self.frame) - kBackButtonWidth*2 - kPaddingH*2,
                                  CGRectGetHeight(self.frame) - kBackButtonHeight - kPaddingV,
                                  kBackButtonWidth, kBackButtonHeight)];
        
        _cleanButton.backgroundColor = [UIColor clearColor];
        [_cleanButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cleanButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _cleanButton.tag = kButtonTag + 2;
        [_cleanButton setTitle:@"清空" forState:UIControlStateNormal];
        [_cleanButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cleanButton;
}

- (UIButton *)eraserButton {
    
    if(!_eraserButton){
        _eraserButton = [[UIButton alloc] initWithFrame:
                       CGRectMake(CGRectGetWidth(self.frame) - kBackButtonWidth*3 - kPaddingH * 3,
                                  CGRectGetHeight(self.frame) - kBackButtonHeight - kPaddingV,
                                  kBackButtonWidth, kBackButtonHeight)];
        
        _eraserButton.backgroundColor = [UIColor clearColor];
        [_eraserButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _eraserButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _eraserButton.tag = kButtonTag + 3;
        [_eraserButton setTitle:@"橡皮擦" forState:UIControlStateNormal];
        [_eraserButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _eraserButton;
}



@end
