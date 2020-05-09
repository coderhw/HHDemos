//
//  NSMutableString+safe.m
//  Wallet
//
//  Created by maokebin on 16/9/9.
//  Copyright © 2016年 Midea. All rights reserved.
//

#import "NSMutableString+safe.h"
#import "NSObject+Hook.h"

@implementation NSMutableString(Safe)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (NSClassFromString(@"__NSCFString")) {
            [NSClassFromString(@"__NSCFString") changeInstanceMethod:@selector(appendString:) replaceSel:@selector(safeAppendString:)];
        }
        [self changeInstanceMethod:@selector(insertString:atIndex:) replaceSel:@selector(safeInsertString:atIndex:)];
    });
}

- (void)safeInsertString:(NSString *)aString atIndex:(NSUInteger)loc
{
    if (aString) {
        return [self safeInsertString:aString atIndex:loc];
    }
}

- (void)safeAppendString:(NSString *)aString
{
    if (!aString) {
        aString = @" ";
    }
    return [self safeAppendString:aString];
}

@end
