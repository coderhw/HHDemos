//
//  HHPortraitViewController.m
//  HHDemos
//
//  Created by ZZ on 2022/5/6.
//  Copyright © 2022 Evan. All rights reserved.
//

#import "HHPortraitViewController.h"
#import "HHLandscapeViewController.h"
#import "AppDelegate.h"
@interface HHPortraitViewController ()

@end

@implementation HHPortraitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
}

- (IBAction)push:(id)sender {
    HHLandscapeViewController *landscapeVc = [[HHLandscapeViewController alloc] initWithNibName:@"HHLandscapeViewController" bundle:nil];
    [self.navigationController pushViewController:landscapeVc  animated:YES];
}

- (IBAction)rotate:(id)sender {
    NSNumber *value = @(UIInterfaceOrientationLandscapeRight);
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}


- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}




@end
