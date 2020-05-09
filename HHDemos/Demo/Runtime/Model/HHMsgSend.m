
//
//  HWMsgSend.m
//  HWRuntimeDemo
//
//  Created by Evan on 16/4/12.
//  Copyright © 2016年 Evan. All rights reserved.
//

#import "HHMsgSend.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import <UIKit/UIKit.h>



@implementation HHMsgSend

- (void)noArgumentsAndNoReturnValue {
    NSLog(@"%s was called, and it has no arguments and return value", __FUNCTION__);
}

- (void)hasArguments:(NSString *)arg {
    NSLog(@"%s was called, and argument is %@", __FUNCTION__, arg);
}

- (NSString *)noArgumentsButReturnValue {
    NSLog(@"%s was called, and return value is %@", __FUNCTION__, @"不带参数，但是带有返回值");
    return @"不带参数，但是带有返回值";
}

- (int)hasArguments:(NSString *)arg andReturnValue:(int)arg1 {
    NSLog(@"%s was called, and argument is %@, return value is %d", __FUNCTION__, arg, arg1);
    return arg1;
}


void sayHello(id self, SEL _cmd){
    NSLog(@"Add Method Success");
}

+ (void)testMsgSend {
    
    HHMsgSend *msg = ((HHMsgSend * (*)(id, SEL))objc_msgSend)((id)[HHMsgSend class], @selector(alloc));

    msg = ((HHMsgSend *(*)(id, SEL))objc_msgSend)((id)msg, @selector(init));
    

    //call a method without return value
    ((void (*)(id, SEL))objc_msgSend)((id)msg, @selector(noArgumentsAndNoReturnValue));
    
    //arguments wiitout return values
    ((void (*)(id, SEL, NSString *))objc_msgSend)((id)msg, @selector(hasArguments:), @"带一个参数，但无返回值");
    
    //with return values but without arguments
    NSString *testStr = ((NSString * (*)(id, SEL))objc_msgSend)((id)msg, @selector(noArgumentsButReturnValue));
    NSLog(@"testStr:%@", testStr);
    
    // 6.带参数带返回值
    int returnV =  ((int (*)(id, SEL, NSString *, int))
                    objc_msgSend)((id)msg,
                                  @selector(hasArguments:andReturnValue:),
                                  @"参数1",
                                  2016);
//      int a =  ((int (*)(id, SEL, NSString *, int))objc_msgSend)((id)msg, @selector(hasArguments:andReturnValue:), @"", 2016);
//     int b =    ((int (*)(id, SEL, NSString *, int))objc_msgSend)((id)msg, @selector(hasArguments:andReturnValue:), @"", 2016);
//    int c =   ((int (*)(id, SEL, NSString*, int))objc_msgSend)((id)msg, @selector(hasArguments:andReturnValue:), @"", 2012);
//    int d =  ((int (*)(id, SEL, NSString *, int))objc_msgSend)((id)msg, @selector(hasArguments:andReturnValue:), @"", 2012);
    
    //add method
    class_addMethod([HHMsgSend class], NSSelectorFromString(@"sayHello2"), (IMP)sayHello, "v@:");
    HHMsgSend *instance = [[HHMsgSend alloc] init];
    ((void (*)(id, SEL))objc_msgSend)((id)instance,  NSSelectorFromString(@"sayHello2"));


    
}



@end
