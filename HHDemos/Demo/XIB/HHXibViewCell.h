//
//  HHXibViewCell.h
//  VKDemoProject
//
//  Created by XXXXX on 2018/7/14.
//  Copyright © 2018年 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHBookModel.h"
@interface HHXibViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

- (void)configCellWithModel:(HHBookModel *)model;
@end
