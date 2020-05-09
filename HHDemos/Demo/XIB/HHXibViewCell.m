//
//  HHXibViewCell.m
//  VKDemoProject
//
//  Created by XXXXX on 2018/7/14.
//  Copyright © 2018年 Evan. All rights reserved.
//

#import "HHXibViewCell.h"

@implementation HHXibViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configCellWithModel:(HHBookModel *)model {
    self.contentLabel.text = model.content;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

@end
