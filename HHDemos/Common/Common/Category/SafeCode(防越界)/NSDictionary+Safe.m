//
//  NSDictionary+Safe.m
//  Wallet
//
//  Created by maokebin on 16/9/14.
//  Copyright © 2016年 Midea. All rights reserved.
//

#import "NSDictionary+Safe.h"
#import "NSObject+Hook.h"

@implementation NSDictionary (Safe)

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[NSDictionary class] changeClassMethod:@selector(dictionaryWithObjectsAndKeys:) replaceSel:@selector(safeDictionaryWithObjectsAndKeys:)];
        if (NSClassFromString(@"__NSPlaceholderDictionary")){
            [NSClassFromString(@"__NSPlaceholderDictionary") changeInstanceMethod:@selector(initWithObjects:forKeys:count:) replaceSel:@selector(safeInitWithObjects:forKeys:count:)];
        }
    });
}

+ (instancetype)safeDictionaryWithObjectsAndKeys:(id)firstObject, ... NS_REQUIRES_NIL_TERMINATION
{
    if (firstObject)
    {
        NSMutableArray *objects = [NSMutableArray array];
        NSMutableArray *keys    = [NSMutableArray array];
        int index = 0;
        va_list argsList;
        [objects addObject:firstObject];
        va_start(argsList, firstObject);
        id arg;
        while ((arg = va_arg(argsList, id)))
        {
            index ++;
            if (index %2) {
                [keys addObject:arg];
            } else {
                [objects addObject:arg];
            }
        }
        va_end(argsList);
        __unsafe_unretained id  object[objects.count];
        __unsafe_unretained id  key[keys.count];
        [objects getObjects:object];
        [keys getObjects:key];
        return [[[self class] alloc] initWithObjects:object forKeys:key count:keys.count];
    }
    return nil;
}

- (instancetype)safeInitWithObjects:(const id [])objects forKeys:(const id <NSCopying> [])keys count:(NSUInteger)cnt
{
    id realObjects[cnt];
    id realkeys[cnt];
    NSUInteger realCount = 0;
    for ( NSUInteger i = 0; i < cnt; i++) {
        if (objects[i] && keys[i]) {
            realObjects[realCount] = objects[i];
            realkeys[realCount] = keys[i];
            realCount ++;
        }
    }
    return [self safeInitWithObjects:realObjects forKeys:realkeys count:realCount];
}
@end
