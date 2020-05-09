//
//  HHUIViewController.m
//  VKDemoProject
//
//  Created by XXXXX on 2018/3/19.
//  Copyright © 2018年 Evan. All rights reserved.
//

#import "HHUIViewController.h"
#import "HHPullSelectView.h"
#import "HHFiterView.h"
#import "HHCollectionController.h"
#import "HHRemindCardView.h"
#import "UIViewController+Extension.h"
#import "HHPickView.h"

@interface HHUIViewController ()

@property (nonatomic, strong) HHPullSelectView *pullSelectView;
@property (nonatomic, strong) HHFiterView *fiterView;
@property (nonatomic, strong) UILabel *label;
@end

@implementation HHUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleStr = NSLocalizedString(@"UIKit", nil);
    self.view.backgroundColor = [UIColor darkGrayColor];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_pullSelectView removeFromSuperview];
    [_pullSelectView.backgroundView removeFromSuperview];
    _pullSelectView = nil;
}

- (IBAction)pullAction:(id)sender {
    
    _pullSelectView = [[HHPullSelectView alloc] initWithFrame:CGRectMake(0, 120, APP_WIDH, 160)
                                                 selectTitles:@[@"拓客排名", @"今天"]];
    [_pullSelectView show];
    _pullSelectView.selectResultBlock = ^(NSArray * _Nullable selectTitles) {
        
    };

}

- (IBAction)dismiss:(id)sender {
    [_pullSelectView dismiss];
}

- (IBAction)instroduceView:(id)sender {
    _fiterView = [[HHFiterView alloc] initWithFrame:CGRectMake(0, 200, APP_WIDH, 240)
                                              Items:@[@"1", @"2", @"3", @"4", @"5", @"6",@"7", @"8", @"9", @"10", @"11"]];
    [self.view addSubview:_fiterView];
}

- (IBAction)collectionView:(id)sender {
    
    HHCollectionController *coVC = [[HHCollectionController alloc] init];
    [self.navigationController pushViewController:coVC animated:YES];
}


- (IBAction)alertView:(id)sender {
    
    HHRemindCardView *remindCardView = [HHRemindCardView remindCardView];
    [[[UIApplication sharedApplication] keyWindow] addSubview:remindCardView];
}

- (IBAction)topViewController:(id)sender {
    
    UIViewController *vc = [UIViewController visibleContollrer];
    NSLog(@"topViewController:%@", vc);
}

- (IBAction)pickView:(id)sender {
    
    HHPickView *pickView = [HHPickView pickView];
    [self.view addSubview:pickView];
}

#pragma mark -



@end
