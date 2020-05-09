//
//  HHFiterView.m
//  HHDemoProject
//
//  Created by XXXXX on 2019/2/19.
//  Copyright © 2019 Evan. All rights reserved.
//

#import "HHFiterView.h"

@interface HHFiterView ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) NSInteger page;
@end

@implementation HHFiterView

- (instancetype)initWithFrame:(CGRect)frame Items:(NSArray *)items {
    self = [super init];
    if (self) {
        
        self.frame = frame;
        self.items = items;
        self.page = (items.count % 10) == 0 ? (items.count/10) : (items.count/10 + 1);
        [self addSubview:self.scrollView];
        [self addItems];
    }
    return self;
}

- (UIScrollView *)scrollView {
    
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,
                                                                     CGRectGetWidth(self.frame),
                                                                     CGRectGetHeight(self.frame))];
        _scrollView.contentSize = CGSizeMake(APP_WIDH*self.page, CGRectGetHeight(self.frame));
        _scrollView.backgroundColor = [UIColor blueColor];
    }
    return _scrollView;
}

- (void)addItems {
    
    CGFloat top = 32;
    CGFloat left = 32;
    CGFloat itemW = 44;
    CGFloat itemH = 64;
    NSInteger rowNum = 5;   //每行5个
    NSInteger itemTotal = 10; //每页10个
    CGFloat space = (APP_WIDH - itemW * rowNum - left*2)/4;
    
    for(int i = 0; i < self.items.count; i++){
        
        NSInteger count = i / 5;
        if(count % 2 == 0) top = 32;
        else top = (32 + itemH + space);
        CGFloat origin_x = left + (i % 5)*space + itemW * (i % rowNum) + i/itemTotal*APP_WIDH;
        UIButton *itemBtn = [[UIButton alloc] initWithFrame:CGRectMake(origin_x, top, itemW, itemH)];
        itemBtn.backgroundColor = [UIColor redColor];
        [itemBtn setTitle:[NSString stringWithFormat:@"%d", i] forState:UIControlStateNormal];
        [self.scrollView addSubview:itemBtn];
    }
}


@end
