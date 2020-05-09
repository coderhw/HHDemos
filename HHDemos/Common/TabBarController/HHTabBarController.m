//
//  VKTabBarController.m
//  VKTabBarDemo
//
//  Created by Evan on 2017/2/7.
//  Copyright © 2017年 XXXX.com All rights reserved.
//

#import "HHTabBarController.h"
#import "HHDemoViewController.h"

#import <FLEX.h>

@interface HHTabBarController ()

@end

@implementation HHTabBarController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self authenticatedControllers];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.tabBar.translucent = NO;
    
    //UI
    CGRect rect = CGRectMake(0, 0, APP_WIDH, 0.5);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   [UIColor colorWithHex:kGrayColor_2].CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithHex:kRedColor]];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundColor:[UIColor colorWithHex:kGrayColor_Light]];
    [[UITabBar appearance] setShadowImage:img];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:FONT(10),
                                                        NSForegroundColorAttributeName:[UIColor colorWithHex:kTextColor_6]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:FONT(10),
                                                        NSForegroundColorAttributeName:[UIColor colorWithHex:kRedColor]} forState:UIControlStateSelected];
    
}




- (void)authenticatedControllers {
    
    //团队
    HHDemoViewController *teamsVC = [[HHDemoViewController alloc] init];
    HHBaseNavigationController *teamsNav = [[HHBaseNavigationController alloc] initWithRootViewController:teamsVC];
    teamsNav.tabBarItem = [self itemWithNormal:NSLocalizedString(@"Demo", @"")
                                       nomalImage:@"icon_home_normal.png"
                                         selected:@"icon_home_select.png"];

    
    self.viewControllers = @[teamsNav];
    self.selectedIndex = 0;
}


- (UITabBarItem *)itemWithNormal:(NSString *)title nomalImage:(NSString *)normalName selected:(NSString *)selectedName {
    
    UIImage *normal = [[UIImage imageNamed:normalName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selected = [[UIImage imageNamed:selectedName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(title, @"") image:normal selectedImage:selected];
    NSDictionary *normalTitleAttributs = @{NSForegroundColorAttributeName:[UIColor colorWithHex:kTextColor_3]};
    NSDictionary *selectTitleAttribute = @{NSForegroundColorAttributeName:[UIColor colorWithHex:kBlackColor]};
    [item setTitleTextAttributes:normalTitleAttributs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectTitleAttribute forState:UIControlStateSelected];
    return item;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    //暂时不作处理，后面可用来埋点
}

#ifdef DEBUG
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    [[FLEXManager sharedManager] showExplorer];
}
#endif

@end
