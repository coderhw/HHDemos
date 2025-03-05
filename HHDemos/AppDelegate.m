//
//  AppDelegate.m
//  VKTeamsProject
//
//  Created by XXXX on 2017/7/5.
//  Copyright © 2017年 Evan. All rights reserved.
//

#import "AppDelegate.h"
#import "HHTabBarController.h"
#import <objc/objc.h>

#import "AppDelegate+PushService.h"

#import "HHSourceViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();

    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    HHTabBarController  *rootVC = [[HHTabBarController alloc] init];
    //集成推送只需要引入AppDelegate+PushService.h头文件即可
    [self registerAPNSService:application];
    CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
    NSLog(@"--- %f", end - start);
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {}
- (void)applicationWillEnterForeground:(UIApplication *)application {}
- (void)applicationWillTerminate:(UIApplication *)application {}

/// 该方法决定app支持的方向
/// 如果没有实现该方法，则会读取plist里的设置
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskAll;
}





@end
