//
//  AppDelegate+PushService.m
//  HHDemos
//
//  Created by Evan on 2020/6/4.
//  Copyright © 2020 Evan. All rights reserved.
//

#import "AppDelegate+PushService.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate (PushService)

#pragma mark - APNS
- (void)registerAPNSService:(UIApplication *)application {
    
    if(IOS10){
        UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
        [center setDelegate:self];
        UNAuthorizationOptions type = UNAuthorizationOptionBadge|UNAuthorizationOptionSound|UNAuthorizationOptionAlert;
        [center requestAuthorizationWithOptions:type completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if(granted && error == nil) {
                NSLog(@"register remote notification success!");
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[UIApplication sharedApplication] registerForRemoteNotifications];
                });
            }else{
                NSLog(@"register remote notification failed!");
            }
        }];
    }
    
    if(IOS8_10){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes
                                                                                 categories:nil];
        [application registerUserNotificationSettings:settings];
    }
}

// iOS8 +
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    // 检查当前用户是否允许通知,如果允许就调用 registerForRemoteNotifications
    if (notificationSettings.types != UIUserNotificationTypeNone) {
        [application registerForRemoteNotifications];
    }
}
#pragma clang diagnostic pop
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

    NSLog(@"didRegisterForRemoteNotificationsWithDeviceToken");
    if(@available(iOS 13.0, *)) {
        NSMutableString *deviceTokenString = [NSMutableString string];
        const char *bytes = deviceToken.bytes;
        NSInteger count = deviceToken.length;
        for (int i = 0; i < count; i++) {
            [deviceTokenString appendFormat:@"%02x", bytes[i]&0x000000FF];
        }
        NSLog(@"deviceTokenString:\n%@",deviceTokenString);

    } else {
        NSString *deviceTokenStr =  [[[[deviceToken description]
                                       stringByReplacingOccurrencesOfString:@"<" withString:@""]
                                      stringByReplacingOccurrencesOfString:@">" withString:@""]
                                     stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSLog(@"deviceTokenStr:\n%@",deviceTokenStr);
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"error -- %@",error);
}

#pragma mark - Remote Notification
//foreground
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    NSLog(@"iOS10 App位于前台时，接收到本地、远程推送时的处理");
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //远程推送
    }
    else {
        //本地推送
    }

    UNNotificationPresentationOptions options = UNNotificationPresentationOptionAlert + UNNotificationPresentationOptionBadge + UNNotificationPresentationOptionSound;
    completionHandler(options);
}
//Background
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSLog(@"iOS10 点击推送消息时处理推送消息");
    
    if ([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //远程推送
    }else{
        //本地推送
    }
    completionHandler();
}

@end
