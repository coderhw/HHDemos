//
//  HHLandscapeViewController.m
//  HHDemos
//
//  Created by xx on 2022/5/6.
//  Copyright © 2022 Evan. All rights reserved.
//

#import "HHLandscapeViewController.h"

@interface HHLandscapeViewController ()

@end

@implementation HHLandscapeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)push:(id)sender {
    
}

- (BOOL)shouldAutorotate {
    return NO;
}

//支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

//默认方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}


@end
