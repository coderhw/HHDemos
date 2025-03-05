//
//  HHImageCollectionViewCell.m
//  HHDemos
//
//  Created by 胡文(平安银行金融科技部零售研发中心基础零售研发团队口袋平台iOS) on 2025/3/5.
//  Copyright © 2025 Evan. All rights reserved.
//

#import "HHImageCollectionViewCell.h"

@implementation HHImageCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 图片视图配置
        _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        _imageView.layer.cornerRadius = 6; // 可选：圆角效果
        [self.contentView addSubview:_imageView];
        
        // 可选：添加选中效果
//        _selectedOverlay = [[UIView alloc] initWithFrame:self.contentView.bounds];
//        _selectedOverlay.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
//        _selectedOverlay.hidden = YES;
//        [self.contentView addSubview:_selectedOverlay];
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
//    self.selectedOverlay.hidden = !selected;
}

@end
