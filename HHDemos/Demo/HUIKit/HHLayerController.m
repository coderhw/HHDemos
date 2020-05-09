//
//  HHLayerController.m
//  VKDemoProject
//
//  Created by XXXXX on 2018/4/5.
//  Copyright © 2018年 Evan. All rights reserved.
//

#import "HHLayerController.h"

@interface HHLayerController ()

@property (weak, nonatomic) IBOutlet UIView *layerView;

@property (weak, nonatomic) IBOutlet UIView *topLeftView;
@property (weak, nonatomic) IBOutlet UIView *topRightView;

@property (weak, nonatomic) IBOutlet UIView *bottomleftView;
@property (weak, nonatomic) IBOutlet UIView *bottomRightView;


@end

@implementation HHLayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    //create sublayer
//    CALayer *blueLayer = [CALayer layer];
//    blueLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
//    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
//    //add it to our view
//    [self.layerView.layer addSublayer:blueLayer];
    
    
//    self.layerView.contentMode = UIViewContentModeScaleAspectFit;
    
    UIImage *image = [UIImage imageNamed:@"avator.png"];
    //add it directly to our view's layer
    self.layerView.layer.contents = (__bridge id)image.CGImage;
    
    self.layerView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    //contentsGravity 类似于 UIView 的 ContentMode属性
//    self.layerView.layer.contentsGravity = kCAGravityResizeAspect;
    
    //contentsScale
//    self.layerView.layer.contentsScale = image.scale;
    self.layerView.layer.contentsScale = [UIScreen mainScreen].scale;
    
    //contentsRect
    [self addImageWithContentLayer];
    
    //Mask
//    [self testMask];
}


//******************************
- (void)addImageWithContentLayer {
    
    UIImage *image = [UIImage imageNamed:@"avator.png"];
    
    [self addSpriteImage:image withContentRect:CGRectMake(0, 0, 0.5, 0.5) contentLayer:_topLeftView.layer];
    [self addSpriteImage:image withContentRect:CGRectMake(0.5, 0, 1.0, 0.5) contentLayer:_topRightView.layer];
    [self addSpriteImage:image withContentRect:CGRectMake(0, 0.5, 0.5, 1) contentLayer:_bottomleftView.layer];
    [self addSpriteImage:image withContentRect:CGRectMake(0.5, 0.5, 1, 1) contentLayer:_bottomRightView.layer];
}

- (void)addSpriteImage:(UIImage *)image withContentRect:(CGRect)rect contentLayer:(CALayer *)layer {
    
    layer.contents = (__bridge id)image.CGImage;
    //scale contents to fit
//    layer.contentsGravity = kCAGravityCenter;
    //set contentsRect
    layer.contentsRect = rect;
}

//******************************

//mask
- (void)testMask {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(128/2.f, 128/2.f)
                                                        radius:128/2.f
                                                    startAngle:0
                                                      endAngle:M_PI*2.f
                                                     clockwise:YES];
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.path = path.CGPath;
    _layerView.layer.mask = shapeLayer;
}








@end
