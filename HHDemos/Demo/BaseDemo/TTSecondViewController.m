//
//  TTSecondViewController.m
//  VKTeamsProject
//
//  Created by XXXXX on 2017/10/19.
//  Copyright © 2017年 Evan. All rights reserved.
//

#import "TTSecondViewController.h"

#import "TTThreeViewController.h"

@interface TTSecondViewController ()

@end

@implementation TTSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleStr = @"基类控制器";
    [self addButton];
}

- (void)addButton {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(APP_WIDH/2-50, 200, 100, 44);
    [button setTitle:@"Hello World" forState:UIControlStateNormal];
    [button setTitleColor:kBarColor forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonPressed {
    
//    TTSecondViewController *childVC = [[TTSecondViewController alloc] init];
//    [self.navigationController pushViewController:childVC animated:YES];
    
    TTThreeViewController *threeVC = [[TTThreeViewController alloc] init];
    [self.navigationController pushViewController:threeVC animated:YES];
    
}

@end
