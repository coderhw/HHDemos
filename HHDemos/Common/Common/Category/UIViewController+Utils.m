//
//  UIViewController+Utils.m
//  HHDemos
//
//  Created by 胡文(金服银行科技中心网点赋能开发团队平台组) on 2020/6/8.
//  Copyright © 2020 Evan. All rights reserved.
//

#import "UIViewController+Utils.h"

@implementation UIViewController (Utils)

+ (UIViewController *)visibleController {
    
    UIViewController *topC = [self visibleController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (topC.presentedViewController) {
        topC = [self visibleController:topC.presentedViewController];
    }
    return topC;
}

+ (UIViewController *)visibleController:(UIViewController *)controller {
    
    if ([controller isKindOfClass:[UINavigationController class]]) {
        return [self visibleController:[(UINavigationController *)controller topViewController]];
    } else if ([controller isKindOfClass:[UITabBarController class]]) {
        return [self visibleController:[(UITabBarController *)controller selectedViewController]];
    } else {
        return controller;
    }
}

@end
