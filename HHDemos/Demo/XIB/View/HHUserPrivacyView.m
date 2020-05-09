//
//  HHUserPrivacyView.m
//  VKDemoProject
//
//  Created by XXXXX on 2018/12/26.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "HHUserPrivacyView.h"

@implementation HHUserPrivacyView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    // 阴影偏移，默认(0, -3)
    self.layer.shadowOffset = CGSizeMake(0,0);
    // 阴影透明度，默认0
    self.layer.shadowOpacity = 0.2;
    // 阴影半径，默认3
    
    
}

+ (instancetype)userPrivacyView {
    return [[[NSBundle mainBundle] loadNibNamed:@"HHUserPrivacyView"owner:nil
                                                options:nil] firstObject];
}

- (void)showWithSuperView:(UIView *)superView {
    
    self.alpha = 0.0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
        [superView addSubview:self];

    } completion:^(BOOL finished) {
        
    }];
}

- (void)drawRect:(CGRect)rect {
    self.frame = CGRectMake(0, 0, APP_WIDH*0.7, 308);
    self.center = self.superview.center;
}


@end
