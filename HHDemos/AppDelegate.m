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
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    HHTabBarController  *rootVC = [[HHTabBarController alloc] init];
    
//    BOOL flag1 = YES;
//    BOOL flag2 = YES;
//    BOOL resultFlag = flag1 ^ flag2;
//    NSLog(@"resultFlag:%d", resultFlag);
    
    [self registerAPNSService:application];
    
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {}
- (void)applicationWillEnterForeground:(UIApplication *)application {}
- (void)applicationWillTerminate:(UIApplication *)application {}


#pragma mark - APNS
- (void)registerAPNSService:(UIApplication *)application {
    
    if(IOS10){
        UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];

        [center setDelegate:self];
        UNAuthorizationOptions type = UNAuthorizationOptionBadge|UNAuthorizationOptionSound|UNAuthorizationOptionAlert;
        [center requestAuthorizationWithOptions:type completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if(granted) {
                NSLog(@"注册成功");
            }else{
                NSLog(@"注册失败");
            }
        }];
    }
    
    if(IOS8_10){
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge|UIUserNotificationTypeSound| UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
}

// iOS8+需要使用这个方法
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    // 检查当前用户是否允许通知,如果允许就调用 registerForRemoteNotifications
    if (notificationSettings.types != UIUserNotificationTypeNone) {
        [application registerForRemoteNotifications];
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

    NSString *deviceTokenStr = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"deviceTokenStr:\n%@",deviceTokenStr);

}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"error -- %@",error);
}


@end
