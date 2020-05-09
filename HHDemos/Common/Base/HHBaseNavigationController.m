//
//  TTBaseNavigationController.m
//  TTProject
//
//  Created by XXXXX on 2017/10/19.
//  Copyright © 2017年 Evan. All rights reserved.
//

#import "HHBaseNavigationController.h"

@interface HHBaseNavigationController ()

@end

@implementation HHBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    
}

- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated {
    
    return [super popViewControllerAnimated:animated];
}

@end
