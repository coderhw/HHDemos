//
//  HHSecondViewController.h
//  HHDemos
//
//  Created by Huwen on 2023/12/23.
//  Copyright © 2023 Evan. All rights reserved.
//

#import "HHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoViewController : UIViewController <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) CGRect sourceFrame;
@property (nonatomic, weak) UIImageView *sourceImageView;

@end

NS_ASSUME_NONNULL_END
