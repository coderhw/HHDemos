//
//  TTRenderContextControllerViewController.m
//  VKTeamsProject
//
//  Created by XXXXX on 2017/10/23.
//  Copyright © 2017年 Evan. All rights reserved.
//

#import "HHRenderContextController.h"
#import "HHImageContextView.h"

@interface HHRenderContextController ()

@property (weak, nonatomic) IBOutlet UIView *contentBG;
@property (weak, nonatomic) IBOutlet UILabel *decLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avator;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation HHRenderContextController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"图形上下文";
    
//    UIGraphicsBeginImageContext(CGSizeMake(200, 200));
//    UIImage *image = [UIImage imageNamed:@"phil.png"];
//    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
//    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [self.imageView setImage:resultImage];
    
}

- (IBAction)beginRender:(id)sender {
 
//    UIGraphicsBeginImageContext(CGSizeMake(200, 200));
//    UIImage *image = [UIImage imageNamed:@"phil.png"];
//    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
//    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [self.imageView setImage:resultImage];
    
    
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, APP_HIGH-200,
                                                                       self.view.frame.size.width,
                                                                       200)];
    UIGraphicsBeginImageContextWithOptions(imageV.frame.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //把当前的整个画面导入到context中，然后通过context输出UIImage，这样就可以把整个屏幕转化为图片
    [self.contentBG.layer renderInContext:context];
    UIImage *tempImg = UIGraphicsGetImageFromCurrentImageContext();
    imageV.image = tempImg;
    UIGraphicsEndImageContext();
    [self.view addSubview:imageV];
}




////获得某个范围内的屏幕图像
//- (UIImage *)imageFromView:(UIView *)theView atFrame:(CGRect)r
//{
//    UIGraphicsBeginImageContext(theView.frame.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSaveGState(context);
//    UIRectClip(r);
//    [theView.layer renderInContext:context];
//    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    return  theImage;//[self getImageAreaFromImage:theImage atFrame:r];
//}


- (IBAction)renderCornerRadius:(id)sender {
    
    //创建一个图形上下文
    UIImage *image = [UIImage imageNamed:@"phil"];
    UIGraphicsBeginImageContextWithOptions(_avator.bounds.size, NO, [UIScreen mainScreen].scale);
    [[UIBezierPath bezierPathWithRoundedRect:_avator.bounds cornerRadius:54] addClip];
    [image drawInRect:_avator.bounds];
    _avator.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
}


@end
