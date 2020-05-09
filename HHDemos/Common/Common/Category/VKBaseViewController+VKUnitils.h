//
//  VKBaseViewController+VKUnitils.h
//  VKOnlineHouse
//
//  Created by MacBook on 2017/8/28.
//  Copyright © 2017年 Evan. All rights reserved.
//

#import "MessageUI/MessageUI.h"
#import <CoreTelephony/CTCall.h>
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@interface UIViewController (VKUnitils)<MFMessageComposeViewControllerDelegate>
- (void)vk_callPhone:(NSString *)phoneNum;
- (void)vk_sendMessage:(NSArray *)phoneNums content:(NSString *)content;
@end
