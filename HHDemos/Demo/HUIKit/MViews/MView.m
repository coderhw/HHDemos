//
//  MView.m
//  HHDemos
//
//  Created by Evan on 2020/5/17.
//  Copyright © 2020 Evan. All rights reserved.
//

#import "MView.h"

@interface MView ()

@end

@implementation MView

+ (instancetype)mView {
    return [[[NSBundle mainBundle] loadNibNamed:@"MView"owner:nil options:nil] firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@260);
        make.height.equalTo(@120);
        make.center.equalTo(self.superview);
    }];
}

@end
