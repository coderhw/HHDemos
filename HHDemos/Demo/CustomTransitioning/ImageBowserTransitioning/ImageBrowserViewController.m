//
//  ImageBrowserViewController.m
//  HHDemos
//
//  Created by Huwen on 2025/3/5.
//  Copyright © 2025 Evan. All rights reserved.
//

#import "ImageBrowserViewController.h"
#import "ImageViewerTransitionAnimator.h"


@interface ImageBrowserViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIImageView *transitionImageView;
@property (nonatomic, assign) CGPoint panStartOffset;

@end



@implementation ImageBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCollectionView];
    [self setupGestureRecognizers];
}

- (void)setupCollectionView {
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = self.view.bounds.size;
    layout.minimumLineSpacing = 0;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.pagingEnabled = YES;
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
    
    NSLog(@"ImageBrowserViewController:%@", @(self.currentIndex));
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
    [_collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    self.currentIndex = indexPath.row;
}

- (void)setupGestureRecognizers {
    // 拖拽手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:pan];
    
    // 双击手势
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
}

- (void)handlePan:(UIPanGestureRecognizer *)gesture {
    CGPoint translation = [gesture translationInView:self.view];
    CGPoint velocity = [gesture velocityInView:self.view];
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            self.panStartOffset = self.collectionView.contentOffset;
            break;
            
        case UIGestureRecognizerStateChanged: {
            CGFloat progress = translation.y / 300;
            progress = MIN(1, MAX(0, progress));
            
            self.view.transform = CGAffineTransformMakeTranslation(0, translation.y);
            self.view.alpha = 1 - progress;
        }
            break;
            
        case UIGestureRecognizerStateEnded: {
            if (translation.y > 120 || velocity.y > 500) {
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                [UIView animateWithDuration:0.3 animations:^{
                    self.view.transform = CGAffineTransformIdentity;
                    self.view.alpha = 1;
                }];
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)gesture {
    UIScrollView *scrollView = [self currentScrollView];
    CGFloat zoomScale = scrollView.zoomScale != 1 ? 1 : 3;
    [scrollView setZoomScale:zoomScale animated:YES];
}

- (UIScrollView *)currentScrollView {
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:
        [NSIndexPath indexPathForItem:self.currentIndex inSection:0]];
    return [cell.contentView.subviews firstObject];
}

#pragma mark - CollectionView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:cell.bounds];
    scrollView.delegate = self;
    scrollView.maximumZoomScale = 3;
    
    if(cell.contentView.subviews.count) {
        for (UIView *subview in cell.contentView.subviews) {
            [subview removeFromSuperview];
        }
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:scrollView.bounds];
    imageView.image = self.imageArray[indexPath.item];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [scrollView addSubview:imageView];
    [cell.contentView addSubview:scrollView];
    
    return cell;
}

#pragma mark - ScrollView Delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return scrollView.subviews.firstObject;
}


- (void)dealloc
{
    NSLog(@"ImageBrowserViewController dealloc");
}
@end
