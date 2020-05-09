//
//  NSObject+Hook.h
//  Wallet
//
//  Created by maokebin on 16/9/14.
//  Copyright © 2016年 Midea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Hook)
+ (void)changeClassMethod:(SEL)origSel   replaceSel:(SEL)swizSel;
+ (void)changeInstanceMethod:(SEL)origSel   replaceSel:(SEL)swizSel;
@end
