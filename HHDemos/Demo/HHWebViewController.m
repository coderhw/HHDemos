//
//  HHWebViewController.m
//  VKDemoProject
//
//  Created by XXXX on 2018/7/6.
//  Copyright © 2018年 Evan. All rights reserved.
//

#import "HHWebViewController.h"

@interface HHWebViewController ()

@property (nonatomic, strong) UIWebView *webView;
@end

@implementation HHWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    _webView.delegate = self;
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
