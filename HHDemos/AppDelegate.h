//
//  AppDelegate.h
//  VKTeamsProject
//
//  Created by XXXX on 2017/7/5.
//  Copyright © 2017年 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
// 判断是否允许屏幕旋转
@property (nonatomic,assign)BOOL allowRotation;

@property (nonatomic, strong) NSData        *deviceToken;


@end

