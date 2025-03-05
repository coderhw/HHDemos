//
//  HHImageCollectionViewCell.h
//  HHDemos
//
//  Created by 胡文(平安银行金融科技部零售研发中心基础零售研发团队口袋平台iOS) on 2025/3/5.
//  Copyright © 2025 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHImageCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *selectedOverlay; // 可选：选中状态覆盖层


@end

NS_ASSUME_NONNULL_END
