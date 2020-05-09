//
//  HHRemindCardView.m
//  HHDemoProject
//
//  Created by XXXXX on 2019/3/4.
//  Copyright © 2019 Evan. All rights reserved.
//

#import "HHRemindCardView.h"

@implementation HHRemindCardView

- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.layer.cornerRadius = 5.0f;
    self.layer.masksToBounds = YES;
    
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    
}
+ (instancetype)remindCardView {
    return [[[NSBundle mainBundle] loadNibNamed:@"HHRemindCardView"owner:nil
                                        options:nil] firstObject];
}

- (void)drawRect:(CGRect)rect {
    
    self.frame = CGRectMake(0, 0, APP_WIDH - 64, 163);
    self.center = self.superview.center;
}


@end
