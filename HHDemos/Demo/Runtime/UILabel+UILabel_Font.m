//
//  UILabel+UILabel_Font.m
//  TTProject
//
//  Created by Evan on 16/8/17.
//  Copyright © 2016年 Evan. All rights reserved.
//

#import "UILabel+UILabel_Font.h"
#import <objc/runtime.h>


@implementation UILabel (UILabel_Font)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class cls = [UILabel class];
        SEL originalSelector = @selector(willMoveToSuperview:);
        SEL swizzedSelector = @selector(myWillMoveToSuperview:);
        
        Method originalMethod = class_getInstanceMethod(cls, originalSelector);
        Method swizzedMethod = class_getInstanceMethod(cls, swizzedSelector);
        
        
        /**
         * Adds a new method to a class with a given name and implementation.
         *
         * @param cls The class to which to add a method.
         * @param name A selector that specifies the name of the method being added.
         * @param imp A function which is the implementation of the new method. The function must take at least two arguments—self and _cmd.
         * @param types An array of characters that describe the types of the arguments to the method.
         *
         * @return YES if the method was added successfully, otherwise NO
         *  (for example, the class already contains a method implementation with that name).
         *
         * @note class_addMethod will add an override of a superclass's implementation,
         *  but will not replace an existing implementation in this class.
         *  To change an existing implementation, use method_setImplementation.
         */
        
//        IMP imp1 = method_getImplementation(originalMethod);
//        IMP imp2 = method_getImplementation(swizzedMethod);
        
        
        //
        BOOL didAddMethod = class_addMethod(cls,originalSelector,
                                            method_getImplementation(swizzedMethod),
                                            method_getTypeEncoding(swizzedMethod));
        
        
        
        /**
         * Replaces the implementation of a method for a given class.
         *
         * @param cls The class you want to modify.
         * @param name A selector that identifies the method whose implementation you want to replace.
         * @param imp The new implementation for the method identified by name for the class identified by cls.
         * @param types An array of characters that describe the types of the arguments to the method.
         *  Since the function must take at least two arguments—self and _cmd, the second and third characters
         *  must be “@:” (the first character is the return type).
         *
         * @return The previous implementation of the method identified by \e name for the class identified by \e cls.
         *
         * @note This function behaves in two different ways:
         *  - If the method identified by \e name does not yet exist, it is added as if \c class_addMethod were called.
         *    The type encoding specified by \e types is used as given.
         *  - If the method identified by \e name does exist, its \c IMP is replaced as if \c method_setImplementation were called.
         *    The type encoding specified by \e types is ignored.
         */
//        IMP imp3 = method_getImplementation(originalMethod);
//        IMP imp4 = method_getImplementation(swizzedMethod);


        if(didAddMethod) {
            class_replaceMethod(cls,
                                swizzedSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        }else {
            method_exchangeImplementations(originalMethod, swizzedMethod);
        }
    
    });
}


- (void)myWillMoveToSuperview:(UIView *)newSuperview {
    
    [self myWillMoveToSuperview:newSuperview];
    if(newSuperview != nil) {
        
        self.textColor = [UIColor colorWithHex:@"#333333"];
        self.font = kFONT(kTitleName_PingFang_R, 14);
    }
}



@end
