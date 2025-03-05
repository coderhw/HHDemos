//
//  ImageBrowserViewController.h
//  HHDemos
//
//  Created by Huwen on 2025/3/5.
//  Copyright © 2025 Evan. All rights reserved.
//

#import "HHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN


@interface ImageBrowserViewController : HHBaseViewController

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) CGRect originFrame;


- (UIScrollView *)currentScrollView;
@end

NS_ASSUME_NONNULL_END
