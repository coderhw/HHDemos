//
//  HHDIYView.m
//  VKDemoProject
//
//  Created by XXXX on 2018/11/2.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "HHDIYView.h"

@interface HHDIYView ()
@property (nonatomic, strong) UIButton *button;
@end

@implementation HHDIYView


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.button = [[UIButton alloc] init];
        
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}




@end
