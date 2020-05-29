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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    HHTabBarController  *rootVC = [[HHTabBarController alloc] init];
    
    BOOL flag1 = YES;
    BOOL flag2 = YES;
    BOOL resultFlag = flag1 ^ flag2;
    NSLog(@"resultFlag:%d", resultFlag);
    
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {}
- (void)applicationWillEnterForeground:(UIApplication *)application {}
- (void)applicationWillTerminate:(UIApplication *)application {}


@end
