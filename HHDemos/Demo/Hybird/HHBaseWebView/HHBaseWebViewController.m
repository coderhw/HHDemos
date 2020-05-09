//
//  HHBaseWebViewController.m
//  VKDemoProject
//
//  Created by XXXXX on 2018/2/27.
//  Copyright © 2018年 Evan. All rights reserved.
//

#import "HHBaseWebViewController.h"


@interface HHBaseWebViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler, UIWebViewDelegate, WKScriptMessageHandler>

@property (nonatomic ,strong) NSMutableURLRequest *webRequest;
@property (nonatomic ,assign) BOOL hiddenNavtionBar;
@property (nonatomic) BOOL   isFile;//是否是本地文件 YES:代表加载本地H5文件  NO:在线加载URL

@end

@implementation HHBaseWebViewController

#pragma mark - Life Cycle
- (instancetype)initWithURL:(NSString *)url withNavtionBar:(BOOL)hidden {
    
    if (self = [super initWithNibName:@"HHBaseWebViewController" bundle:nil]) {
        _requestUrl = [NSURL URLWithString:url];
        _hiddenNavtionBar = hidden ;
        _isFile = NO;
        
    }
    return self;
}

- (instancetype)initWithFile:(NSString *)url withNavtionBar:(BOOL)hidden {
    
    if (self = [super initWithNibName:@"HHBaseWebViewController" bundle:nil]) {
        _requestUrl = [NSURL fileURLWithPath:url];
        _hiddenNavtionBar = hidden;
        _isFile = NO;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self initWebView];
    [self initWKWebView];
}


/**
 * 初始化WebView
 */
- (void)initWebView {

    if (self.hiddenNavtionBar || self.hasNav || self.notNeedTitle) {
        self.titleStr = @"";
    }else{
        if (self.selfTitle.length > 0) {
            self.titleStr = self.selfTitle;
        }
    }

    self.view.backgroundColor = [UIColor whiteColor];
    CGRect rect = CGRectMake(0, self.hiddenNavtionBar ? 20 + (iPhoneX?24:0):0,
                             self.view.frame.size.width,
                             self.view.frame.size.height - (self.hiddenNavtionBar?20+(iPhoneX?24+34:0):0));


    if (self.hiddenNavtionBar) {
        CGRect viewRect = CGRectMake(rect.origin.x, rect.origin.y-20, rect.size.width, rect.size.height+20);
        UIView *view = [[UIView alloc]initWithFrame:viewRect];
        view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:view];
    }

    self.webView = [[UIWebView alloc]initWithFrame:rect];
    self.webView.backgroundColor = [UIColor whiteColor];

    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    self.webView.scrollView.bounces = NO;
    [self.webView loadRequest:self.webRequest];
}

/*
 ** 初始化WKWebView
 */
- (void)initWKWebView {

    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    [userContentController addScriptMessageHandler:self name:@"testNativeMethods"];
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController;
    
    CGRect rect = CGRectMake(0, self.hiddenNavtionBar ? 20+(iPhoneX?24:0):0,
                             APP_WIDH,
                             APP_HIGH - (_hiddenNavtionBar ? 0: (20+(iPhoneX?24+34:0))));
    CGRect viewRect = CGRectMake(rect.origin.x, rect.origin.y-20, rect.size.width, rect.size.height+20);
    _wkWebView = [[WKWebView alloc] initWithFrame:viewRect configuration:configuration];
    _wkWebView.UIDelegate = self;
    _wkWebView.navigationDelegate = self;

    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:_wkWebView];
    [_bridge setWebViewDelegate:self];

    _webRequest = [NSMutableURLRequest requestWithURL:self.requestUrl];
    
//    NSString *path = [kDistPath stringByAppendingPathComponent:@"dist/index.html"];
//    NSString *path2 = [NSString stringWithFormat:@"file:///%@", path];
//    NSURL *pathURL1 = [NSURL URLWithString:path2];
//    _webRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]];
//    [_wkWebView loadFileURL:pathURL1 allowingReadAccessToURL:pathURL1];
    
    NSString *h5Path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    [_wkWebView loadFileURL:[NSURL fileURLWithPath:h5Path] allowingReadAccessToURL:[NSURL fileURLWithPath:h5Path]];

    
    [self.view addSubview:_wkWebView];
    [self registerNativeFunctions];
    
}

- (void)registerNativeFunctions {
    
    [self.bridge registerHandler:@"callPhone" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"callPhone called with: %@", data);
        responseCallback(data);
    }];
   
    [self.bridge callHandler:@"JS Echo" data:nil responseCallback:^(id responseData) {
        NSLog(@"ObjC received response: %@", responseData);
    }];
}


#pragma mark - JS Methods Action


#pragma mark - WKWebView Delegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"%s", __func__);
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"%s", __func__);
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"%s", __func__);
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"%s", __func__);
}

// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"%s", __func__);
}


#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    NSLog(@"body:%@",message.body);
    
}














@end
