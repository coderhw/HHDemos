//
//  NSObject+Hook.m
//  Wallet
//
//  Created by maokebin on 16/9/14.
//  Copyright © 2016年 Midea. All rights reserved.
//

#import "NSObject+Hook.h"
#import <objc/runtime.h>

@implementation NSObject (Hook)

+ (void)changeClassMethod:(SEL)origSel   replaceSel:(SEL)swizSel
{
    /*
    Method origMethod = class_getClassMethod(object_getClass(self.class), origSel);
    Method swizMethod = class_getClassMethod(object_getClass(self.class), swizSel);
    //class_addMethod will fail if original method already exists
    //BOOL didAddMethod = class_addMethod(self.class, origSel, method_getImplementation(swizMethod), method_getTypeEncoding(swizMethod));
    //if (didAddMethod) {
    //    class_replaceMethod(self.class, swizSel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    //} else {
        //origMethod and swizMethod already exist
        method_exchangeImplementations(origMethod, swizMethod);
    //}
     */
    /*
    Method origMethod = class_getClassMethod(self.class, origSel);
    Method swizMethod = class_getClassMethod(self.class, swizSel);
    //class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(self.class, origSel, method_getImplementation(swizMethod), method_getTypeEncoding(swizMethod));
    if (didAddMethod) {
        class_replaceMethod(self.class, swizSel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        //origMethod and swizMethod already exist
        method_exchangeImplementations(origMethod, swizMethod);
    }
    */
    method_exchangeImplementations(class_getClassMethod(self, origSel), class_getClassMethod(self, swizSel));
}

+ (void)changeInstanceMethod:(SEL)origSel   replaceSel:(SEL)swizSel
{
    /*
    Method origMethod = class_getInstanceMethod(self, origSel);
    Method swizMethod = class_getInstanceMethod(self, swizSel);
    //class_addMethod will fail if original method already exists
    //BOOL didAddMethod = class_addMethod(self, origSel, method_getImplementation(swizMethod), method_getTypeEncoding(swizMethod));
    //if (didAddMethod) {
    //    class_replaceMethod(self, swizSel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    //} else {
        //origMethod and swizMethod already exist
        method_exchangeImplementations(origMethod, swizMethod);
    //}
    */
   method_exchangeImplementations(class_getInstanceMethod(self, origSel), class_getInstanceMethod(self, swizSel));
}
@end
