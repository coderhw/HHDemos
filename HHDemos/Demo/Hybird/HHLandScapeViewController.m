//
//  HHLandScapeViewController.m
//  HHDemoProject
//
//  Created by XXXXX on 2019/3/19.
//  Copyright © 2019 Evan. All rights reserved.
//

#import "HHLandScapeViewController.h"
#import <WebViewJavascriptBridge.h>
#import "AppDelegate.h"


@interface HHLandScapeViewController ()

@end

@implementation HHLandScapeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = NO;
    [self changeOrientation:UIInterfaceOrientationPortrait];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = YES;
}


- (void)registerNativeFunctions {

    __weak typeof(self) weakSelf = self;
    [self.bridge registerHandler:@"ObjC Echo" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"ObjC Echo called with: %@", data);
        [weakSelf rotateScreen];
        responseCallback(data);
    }];
//
    [self.bridge callHandler:@"JS Echo" data:nil responseCallback:^(id responseData) {
        NSLog(@"ObjC received response: %@", responseData);
    }];
}

#pragma mark - LandScape Method
bool isLandScape = NO;
- (void)rotateScreen {
//    // 这里我是通过按钮的selected状态来判定横屏竖屏的,并不是唯一的判断标准
//    if (!isLandScape) {
//        [self changeOrientation:UIInterfaceOrientationPortrait];
//    }else{
//        [self changeOrientation:UIInterfaceOrientationLandscapeRight];
//    }
//    isLandScape = !isLandScape;
    [self changeOrientation:UIInterfaceOrientationLandscapeRight];

}

/**
 *    强制横屏
 *
 *    @param orientation 横屏方向
 */
- (void)changeOrientation:(UIInterfaceOrientation)orientation {
//    int val = orientation;
//    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
//        SEL selector = NSSelectorFromString(@"setOrientation:");
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
//        [invocation setSelector:selector];
//        [invocation setTarget:[UIDevice currentDevice]];
//        [invocation setArgument:&val atIndex:2];
//        [invocation invoke];
//    }
    [[UIDevice currentDevice] setValue:@(orientation) forKey:@"orientation"];
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}


@end
