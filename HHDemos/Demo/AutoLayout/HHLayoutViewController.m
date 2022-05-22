//
//  HHLayoutViewController.m
//  HHDemos
//
//  Created by XXXXX on 2020/6/1.
//  Copyright © 2020 Evan. All rights reserved.
//

#import "HHLayoutViewController.h"

@interface HHLayoutViewController ()
@property (nonatomic, strong) UIView *redView;

@end

@implementation HHLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.redView = [[UIView alloc] init];
    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];
    [self.redView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // 设置subView相对于VIEW的上左下右各40像素
    //上边距
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.redView
                                                                   attribute:NSLayoutAttributeTop
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view attribute:NSLayoutAttributeTop
                                                                  multiplier:1.0 constant:87];
    //左边距
    NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:self.redView
                                                                   attribute:NSLayoutAttributeLeft
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view attribute:NSLayoutAttributeLeft
                                                                  multiplier:1.0 constant:40];
    
    
    //下边距
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.redView
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view attribute:NSLayoutAttributeBottom
                                                                  multiplier:1.0 constant:-40];
    
    // 右边距
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.redView
                                                                   attribute:NSLayoutAttributeRight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view attribute:NSLayoutAttributeRight
                                                                  multiplier:1.0 constant:-40];
    
    // 将四条约束加进数组中
    NSArray *array = @[constraint1,constraint2,constraint3,constraint4];
    [self.view addConstraints:array];

}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (@available(iOS 11.0, *)) {
        CGFloat safeBottom = UIApplication.sharedApplication.delegate.window.safeAreaInsets.bottom;
        NSLog(@"safeBottom:%f", safeBottom);
    }
    
    
    if (@available(iOS 11.0, *)) {
        CGFloat sareAreaLeft = self.view.safeAreaInsets.left;
        CGFloat sareAreaRight = self.view.safeAreaInsets.right;
        CGFloat sareAreaTop = self.view.safeAreaInsets.top;
        CGFloat sareAreaBottom = self.view.safeAreaInsets.bottom;
        NSLog(@"sareAreaLeft:%f, sareAreaRight:%f sareAreaTop:%f sareAreaBottom:%f", sareAreaLeft,sareAreaRight,sareAreaTop,sareAreaBottom);
    }
    
    
    if (@available(iOS 11.0, *)) {
        CGFloat sareAreaLeft = self.redView.safeAreaInsets.left;
        CGFloat sareAreaRight = self.redView.safeAreaInsets.right;
        CGFloat sareAreaTop = self.redView.safeAreaInsets.top;
        CGFloat sareAreaBottom = self.redView.safeAreaInsets.bottom;
        NSLog(@"red: sareAreaLeft:%f, sareAreaRight:%f sareAreaTop:%f sareAreaBottom:%f", sareAreaLeft,sareAreaRight,sareAreaTop,sareAreaBottom);
    }
    
 
    if (@available(iOS 11.0, *)) {
        CGFloat sareAreaLeft = UIApplication.sharedApplication.delegate.window.safeAreaInsets.left;
        CGFloat sareAreaRight = UIApplication.sharedApplication.delegate.window.safeAreaInsets.right;
        CGFloat sareAreaTop = UIApplication.sharedApplication.delegate.window.safeAreaInsets.top;
        CGFloat sareAreaBottom = UIApplication.sharedApplication.delegate.window.safeAreaInsets.bottom;
        NSLog(@"window: sareAreaLeft:%f, sareAreaRight:%f sareAreaTop:%f sareAreaBottom:%f", sareAreaLeft,sareAreaRight,sareAreaTop,sareAreaBottom);
    }
}


@end
