//
//  HHImageListCollectionController.m
//  HHDemos
//
//  Created by 胡文(平安银行金融科技部零售研发中心基础零售研发团队口袋平台iOS) on 2025/3/5.
//  Copyright © 2025 Evan. All rights reserved.
//

#import "HHImageListCollectionController.h"
#import "HHImageCollectionViewCell.h" // 自定义Cell头文件

#import "PhotoViewController.h"
#import "PhotoTransitionAnimator.h"

#import "ImageBrowserViewController.h"

static NSString *const kCellIdentifier = @"ImageCell";
static CGFloat const kItemsPerRow = 4; // 每行4个item


@interface HHImageListCollectionController ()<UIViewControllerTransitioningDelegate>

@end

@implementation HHImageListCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化测试图片数据
    _imageNames = @[@"girl1", @"girl2", @"girl3", @"girl4", @"girl5",
                    @"girl6", @"girl7", @"girl8", @"girl9", @"girl10",@"girl11",@"girl12",@"girl1",
                    @"girl2", @"girl3", @"girl4", @"girl5",@"girl1", @"girl2", @"girl3", @"girl4",
                    @"girl5",@"girl1", @"girl2", @"girl3", @"girl4", @"girl5",@"girl1", @"girl2", @"girl3", @"girl4", @"girl5",
                    @"girl6", @"girl7", @"girl8", @"girl9", @"girl10",@"girl11",@"girl12",@"girl1",
                    @"girl2", @"girl3", @"girl4", @"girl5",@"girl1", @"girl2", @"girl3", @"girl4",
                    @"girl5",@"girl1", @"girl2", @"girl3", @"girl4", @"girl5"];
    
    // 创建流式布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 8;      // 行间距
    layout.minimumInteritemSpacing = 8; // 列间距
    layout.sectionInset = UIEdgeInsetsMake(12, 12, 12, 12); // 边距
    
    // 创建CollectionView
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
//    _collectionView.allowsSelection = NO;
    _collectionView.backgroundColor = [UIColor systemBlueColor];

    // 注册自定义Cell
    [_collectionView registerClass:[HHImageCollectionViewCell class]
        forCellWithReuseIdentifier:kCellIdentifier];
    
    [self.view addSubview:_collectionView];
}

#pragma mark - 动态计算单元格尺寸
- (CGSize)calculateItemSize {
    // 获取布局边距和间距
    UIEdgeInsets sectionInset = [(UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout sectionInset];
    CGFloat spacing = [(UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout minimumInteritemSpacing];
    
    // 计算可用宽度
    CGFloat availableWidth = self.collectionView.frame.size.width
                           - sectionInset.left
                           - sectionInset.right
                           - (kItemsPerRow - 1) * spacing;
    
    // 计算每个item的宽度
    CGFloat itemWidth = floor(availableWidth / kItemsPerRow);
    return CGSizeMake(itemWidth, itemWidth); // 正方形单元格
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self calculateItemSize];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HHImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier
                                                                           forIndexPath:indexPath];
    // 加载图片（实际项目建议使用SDWebImage等库）
    cell.imageView.image = [UIImage imageNamed:self.imageNames[indexPath.item]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 转换frame到window坐标系
    HHImageCollectionViewCell *cell = (HHImageCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    CGRect sourceFrame = [cell.imageView convertRect:cell.imageView.bounds toView:nil];
    cell.selected = NO;
    
//    PhotoViewController *vc = [PhotoViewController new];
//    vc.image = cell.imageView.image;
//    vc.sourceFrame = sourceFrame;
//    vc.sourceImageView = cell.imageView;
//    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
//    vc.transitioningDelegate = vc;
//    
//    [self presentViewController:vc animated:YES completion:nil];
    
    
    NSMutableArray *images = [NSMutableArray array];
    for(int i = 0; i < self.imageNames.count; i++){
        UIImage *image = [UIImage imageNamed:self.imageNames[i]];
        [images addObject:image];
    }
    
    NSLog(@"didSelectItemAtIndexPath:%@", @(indexPath.row));
    ImageBrowserViewController *browser = [[ImageBrowserViewController alloc] init];
    browser.imageArray = images;
    browser.currentIndex = indexPath.row;
    browser.originFrame = sourceFrame; // 原始图片位置
    browser.modalPresentationStyle = UIModalPresentationCustom;
    browser.transitioningDelegate = self;
    [self presentViewController:browser animated:YES completion:nil];
    
}



@end
