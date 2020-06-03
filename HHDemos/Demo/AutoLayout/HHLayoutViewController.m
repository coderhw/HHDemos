//
//  HHLayoutViewController.m
//  HHDemos
//
//  Created by XXXXX on 2020/6/1.
//  Copyright © 2020 Evan. All rights reserved.
//

#import "HHLayoutViewController.h"

@interface HHLayoutViewController ()

@end

@implementation HHLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *subView = [[UIView alloc] init];
    subView.backgroundColor = [UIColor redColor];
    [self.view addSubview:subView];
    [subView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // 设置subView相对于VIEW的上左下右各40像素
    //上边距
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:subView
                                                                   attribute:NSLayoutAttributeTop
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view attribute:NSLayoutAttributeTop
                                                                  multiplier:1.0 constant:40];
    //左边距
    NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:subView
                                                                   attribute:NSLayoutAttributeLeft
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view attribute:NSLayoutAttributeLeft
                                                                  multiplier:1.0 constant:40];
    
    
    //下边距
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:subView
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view attribute:NSLayoutAttributeBottom
                                                                  multiplier:1.0 constant:-40];
    
    // 右边距
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:subView
                                                                   attribute:NSLayoutAttributeRight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view attribute:NSLayoutAttributeRight
                                                                  multiplier:1.0 constant:-40];
    
    // 将四条约束加进数组中
    NSArray *array = @[constraint1,constraint2,constraint3,constraint4];
    [self.view addConstraints:array];

}



@end
