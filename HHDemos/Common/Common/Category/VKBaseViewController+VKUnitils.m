//
//  VKBaseViewController+VKUnitils.m
//  VKOnlineHouse
//
//  Created by MacBook on 2017/8/28.
//  Copyright © 2017年 Evan. All rights reserved.
//

#import "VKBaseViewController+VKUnitils.h"

@implementation UIViewController (VKUnitils)
- (void)vk_callPhone:(NSString *)phoneNum{
    if (phoneNum.length<=0) {
        return;
    }
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", phoneNum];
    // 防止iOS 10及其之后，拨打电话系统弹出框延迟出现
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    });
//    [MFAppUtils callTelphone:phoneNum];
//    CTCallCenter *callCenter = [[CTCallCenter alloc] init];
//    [callCenter setCallEventHandler:nil];
}
- (void)vk_sendMessage:(NSArray *)phoneNums content:(NSString *)content{
    if (phoneNums.count<=0) {
        return;
    }
    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *messageNaviController = [[MFMessageComposeViewController alloc] init];
        if (messageNaviController) {
            messageNaviController.messageComposeDelegate = self;
            messageNaviController.body = content;
            messageNaviController.recipients = phoneNums;//phone
            [self presentViewController:messageNaviController animated:YES completion:nil];
        }
    }
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
