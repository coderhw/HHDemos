//
//  NSMutableArray+Safe.m
//  Wallet
//
//  Created by maokebin on 16/9/14.
//  Copyright © 2016年 Midea. All rights reserved.
//

#import "NSMutableArray+Safe.h"
#import "NSObject+Hook.h"

@implementation NSMutableArray (Safe)
+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (NSClassFromString(@"__NSArrayM")){
            [NSClassFromString(@"__NSArrayM") changeInstanceMethod:@selector(objectAtIndex:) replaceSel:@selector(safeObjectAtIndex:)];
            [NSClassFromString(@"__NSArrayM") changeInstanceMethod:@selector(insertObject:atIndex:) replaceSel:@selector(safeInsertObject:atIndex:)];
        }
    });
}

-(void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (!anObject) {
        return;
    }
    return [self safeInsertObject:anObject atIndex:index];
}

-(id)safeObjectAtIndex:(NSInteger)index
{
    if (index < 0 || index >= self.count) {
        return nil;
    }
    return [self safeObjectAtIndex:index];
}
@end
