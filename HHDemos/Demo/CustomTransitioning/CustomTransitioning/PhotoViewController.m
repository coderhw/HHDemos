//
//  HHSecondViewController.m
//  HHDemos
//
//  Created by Huwen on 2023/12/23.
//  Copyright © 2023 Evan. All rights reserved.
//

// PhotoViewController.m
#import "PhotoViewController.h"
#import "PhotoTransitionAnimator.h"

@interface PhotoViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    _imageView = [[UIImageView alloc] initWithImage:self.image];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.frame = self.view.bounds;
    [self.view addSubview:_imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    [self.view addGestureRecognizer:tap];
}

- (void)handleTap {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Transitioning Delegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    PhotoTransitionAnimator *animator = [PhotoTransitionAnimator new];
    animator.transitionType = TransitionTypePresent;
    animator.startFrame = self.sourceFrame;
    animator.sourceImageView = self.sourceImageView;
    return animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    PhotoTransitionAnimator *animator = [PhotoTransitionAnimator new];
    animator.transitionType = TransitionTypeDismiss;
    animator.startFrame = self.sourceFrame;
    animator.sourceImageView = self.sourceImageView;
    return animator;
}

@end
