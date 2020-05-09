//
//  TTImageContextView.m
//  VKTeamsProject
//
//  Created by XXXXX on 2017/10/23.
//  Copyright © 2017年 Evan. All rights reserved.
//

#import "HHImageContextView.h"

@implementation HHImageContextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSuvViews];
    }
    return self;
}

- (void)addSuvViews {
    UIImage *image = [UIImage imageNamed:@"phil.png"];
    
    self.avatorView.frame = CGRectMake(16, 16, image.size.width, image.size.height);
    self.avatorView.image = image;
    [self addSubview:_avatorView];
    
    UIGraphicsBeginImageContext(CGSizeMake(200, 200));
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIGraphicsEndImageContext();

        ///Users/apple/Desktop/素材
    //把图片写入到桌面
    //把图片转成二进制流
    //NSData *data = UIImageJPEGRepresentation(newImage, 1);
//    NSData *data = UIImagePNGRepresentation(newImage);
//    NSLog(@"data:%@",data);
}

- (void)drawRect:(CGRect)rect {
   
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();

}


@end
