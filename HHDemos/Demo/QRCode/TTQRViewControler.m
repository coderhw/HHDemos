//
//  TTQRViewControler.m
//  VKTeamsProject
//
//  Created by XXXXX on 2017/10/23.
//  Copyright © 2017年 Evan. All rights reserved.
//

#import "TTQRViewControler.h"
#import "SGQRCode.h"

@interface TTQRViewControler ()

@end

@implementation TTQRViewControler

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setTitle:@"QR Code" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@88);
        make.height.equalTo(@88);
        make.center.equalTo(self.view);
    }];
}

- (void)buttonPressed:(UIButton *)sender {
    
    // 1、借助UIImageView显示二维码
    UIImageView *imageView = [[UIImageView alloc] init];
    CGFloat imageViewW = 150;
    CGFloat imageViewH = imageViewW;
    CGFloat imageViewX = (self.view.frame.size.width - imageViewW) / 2;
    CGFloat imageViewY = 80;
    imageView.frame =CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    [self.view addSubview:imageView];
    
    // 2、将CIImage转换成UIImage，并放大显示
    imageView.image = [SGQRCodeGenerateManager generateWithDefaultQRCodeData:@"https://github.com/kingsic" imageViewWidth:imageViewW];
}




@end
