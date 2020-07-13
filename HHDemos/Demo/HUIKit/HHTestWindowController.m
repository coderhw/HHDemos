//
//  HHTestWindowController.m
//  HHDemos
//
//  Created by xxxx on 2020/7/7.
//  Copyright © 2020 Evan. All rights reserved.
//

#import "HHTestWindowController.h"

@interface HHTestWindowController ()



@end

@implementation HHTestWindowController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSLog(@"%s", __func__);
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    NSLog(@"%s", __func__);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%s", __func__);
}

- (IBAction)hideWindow:(id)sender {
    NSLog(@"%s", __func__);    
}


@end
