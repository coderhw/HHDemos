//
//  HHWebViewTestController.m
//  VKDemoProject
//
//  Created by XXXXX on 2018/4/16.
//  Copyright © 2018年 Evan. All rights reserved.
//

#import "HHWebViewTestController.h"
#import "HHBaseWebViewController.h"
#import "HHLandScapeViewController.h"

@interface HHWebViewTestController ()

@end

@implementation HHWebViewTestController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (IBAction)wkWebView:(id)sender {
    
    NSString *path = [kDistPath stringByAppendingPathComponent:@"dist/index.html#/development2"];
    HHBaseWebViewController *devAgentVC = [[HHBaseWebViewController alloc]
                                       initWithFile:path withNavtionBar:YES];
    [self.navigationController pushViewController:devAgentVC animated:YES];

}


- (IBAction)landScape:(id)sender {

    NSString *path = [kDistPath stringByAppendingPathComponent:@"dist/index.html#/development2"];
    HHLandScapeViewController *devAgentVC = [[HHLandScapeViewController alloc]
                                           initWithFile:path withNavtionBar:YES];
    [self.navigationController pushViewController:devAgentVC animated:YES];
}

@end
