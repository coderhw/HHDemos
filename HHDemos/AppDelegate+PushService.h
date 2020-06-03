//
//  AppDelegate+PushService.h
//  HHDemos
//
//  Created by Evan on 2020/6/4.
//  Copyright © 2020 Evan. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (PushService)

- (void)registerAPNSService:(UIApplication *)application;

@end

NS_ASSUME_NONNULL_END
