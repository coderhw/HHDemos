//
//  NSArray+Safe.m
//  Wallet
//
//  Created by maokebin on 16/9/5.
//  Copyright © 2016年 maokebin. All rights reserved.
//

#import "NSArray+Safe.h"
#import "NSObject+Hook.h"

@implementation NSArray (Safe)
+ (instancetype)safeArrayWithObjects:(id)firstObj, ... NS_REQUIRES_NIL_TERMINATION
{
    if (firstObj)
    {
        NSMutableArray *array = [NSMutableArray array];
        va_list argsList;
        [array addObject:firstObj];
        va_start(argsList, firstObj);
        id arg;
        while ((arg = va_arg(argsList, id)))
        {
            [array addObject:arg];
        }
        va_end(argsList);
        return [self arrayWithArray:array];
    }else{
        return nil;
    }
}


+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self changeClassMethod:@selector(arrayWithObjects:count:) replaceSel:@selector(safeArrayWithObjects:count:)];
        [self changeClassMethod:@selector(arrayWithObject:) replaceSel:@selector(safeArrayWithObject:)];
        if (NSClassFromString(@"__NSArray0")){
            [NSClassFromString(@"__NSArray0") changeInstanceMethod:@selector(objectAtIndex:) replaceSel:@selector(safe0ObjectAtIndex:)];
        }
        if (NSClassFromString(@"__NSArrayI")){
            [NSClassFromString(@"__NSArrayI") changeInstanceMethod:@selector(objectAtIndex:) replaceSel:@selector(safeIObjectAtIndex:)];
        }
        if (NSClassFromString(@"__NSPlaceholderArray")){
            [NSClassFromString(@"__NSPlaceholderArray") changeInstanceMethod:@selector(initWithObjects:count:) replaceSel:@selector(safeInitWithObjects:count:)];
        }
    });
}

- (instancetype)safeInitWithObjects:(const id [])objects count:(NSUInteger)cnt
{
    id realObjects[cnt];
    int index = 0;
    for (int i = 0; i < cnt; i++) {
        if (objects[i]) {
            realObjects[index++] = objects[i];
        }
    }
    return [self safeInitWithObjects:realObjects count:index];
}


+ (instancetype)safeArrayWithObject:(id)anObject
{
    if (!anObject) {
        return nil;
    }
    return [self safeArrayWithObject:anObject];
}

+(instancetype)safeArrayWithObjects:(const id [])objects count:(NSUInteger)cnt;
{
    id realObjects[cnt];
    NSUInteger realCount = 0;
    for ( NSUInteger i = 0; i < cnt; i++) {
        id object = objects[i];
        if (object) {
            realObjects[realCount] = object;
            realCount ++;
        }
    }
    return [self safeArrayWithObjects:realObjects count:realCount];
}

- (id)safeIObjectAtIndex:(NSInteger)index
{
    if (index < 0 || index >=self.count) {
        return nil;
    }
    return [self safeIObjectAtIndex:index];
}

- (id)safe0ObjectAtIndex:(NSInteger)index
{
    if (index < 0 || index >=self.count) {
        return nil;
    }
    return [self safe0ObjectAtIndex:index];
}

@end
