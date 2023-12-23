//
//  HHTipsPopView.m
//  HHDemos
//
//  Created by 胡文(金服银行科技中心网点赋能开发团队平台组)(HUWEN824) on 2023/3/17.
//  Copyright © 2023 Evan. All rights reserved.
//

#import "HHBubbleView.h"
#import "NSString+ContentSize.h"
#import "UILabel+Category.h"

#define kBubbleWidth [UIScreen mainScreen].bounds.size.width - 64

@interface HHBubbleView ()

@property (nonatomic, strong) UIImageView   *backgroudView;
@property (nonatomic, strong) UILabel       *contentLabel;

@property (nonatomic, assign) CGFloat bubbleWidth;
@end

@implementation HHBubbleView

+ (instancetype)bubbleView {
    return [[HHBubbleView  alloc] initWithFrame:CGRectMake(8, 100, kBubbleWidth, 60)];;
}


- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        [self addSubview:self.backgroudView];
    }
    return self;
}


- (void)show:(NSString *)text {
    
    
    CGFloat LabelW = kBubbleWidth - 12;
    
    CGFloat height = [text paba_heightWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:LabelW];

    
    
    self.contentLabel.frame = CGRectMake(12, 0, LabelW, height);
    self.contentLabel.backgroundColor = [UIColor whiteColor];
    self.contentLabel.text = text;
    [self addSubview:self.contentLabel];
    
    CGRect rect = self.frame;
    rect.size.height = height;
    
    
    self.frame = rect;
    
    CGRect rect2 = self.contentLabel.frame;
    rect2.size.height = rect.size.height;
    
    self.contentLabel.frame = rect2;
    _backgroudView.frame = self.bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
        
}

- (UIImageView *)backgroudView {
    
    if(!_backgroudView) {
        _backgroudView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pab_video_alertBg.png"]];
        _backgroudView.frame = self.bounds;
    }
    return _backgroudView;
}

- (UILabel *)contentLabel {
    if(!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.font = [UIFont systemFontOfSize:14.0f];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}


- (float)heightForString:(NSString *)value andWidth:(float)width withFontSize:(CGFloat)fontSize{
    // 使用UITextView 的 sizeThatFits 方法计算出字符串的高度后再给 UILabel 使用
    UITextView *detailTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
    detailTextView.font = [UIFont systemFontOfSize:fontSize];
    detailTextView.text = value;
    CGSize deSize = [detailTextView sizeThatFits:CGSizeMake(width,CGFLOAT_MAX)];
    return deSize.height;
}



@end
