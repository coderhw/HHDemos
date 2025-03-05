//
//  HHImageListCollectionController.h
//  HHDemos
//
//  Created by 胡文(平安银行金融科技部零售研发中心基础零售研发团队口袋平台iOS) on 2025/3/5.
//  Copyright © 2025 Evan. All rights reserved.
//

#import "HHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHImageListCollectionController : HHBaseViewController<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *imageNames;


@end

NS_ASSUME_NONNULL_END
