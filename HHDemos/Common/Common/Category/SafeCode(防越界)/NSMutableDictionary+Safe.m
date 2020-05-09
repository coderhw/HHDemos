//
//  NSMutableDictionary+Safe.m
//  Wallet
//
//  Created by maokebin on 16/9/14.
//  Copyright © 2016年 Midea. All rights reserved.
//

#import "NSMutableDictionary+Safe.h"
#import "NSObject+Hook.h"

@implementation NSMutableDictionary (Safe)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (NSClassFromString(@"__NSDictionaryM")) {
            [NSClassFromString(@"__NSDictionaryM") changeInstanceMethod:@selector(setObject:forKey:) replaceSel:@selector(safeSetObject:forKey:)];
        }
    });
}

- (void)safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (!anObject || !aKey) {
        return;
    }
    return [self safeSetObject:anObject forKey:aKey];
}
@end
