//
//  VKBaseWebController.h
//  VKOnlineHouse
//
//  Created by MacBook on 2017/8/22.
//  Copyright © 2017年 Evan. All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>
#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import <WebViewJavascriptBridge.h>

@interface HHBaseWebViewController : HHBaseViewController
@property (nonatomic, strong)NSURL *requestUrl;
@property (nonatomic, copy) NSString *selfTitle;
@property (nonatomic, copy) NSDictionary *params;
@property (nonatomic) BOOL hasNav;
@property (nonatomic) BOOL hasExitBtn;
@property (nonatomic) BOOL hasShareBtn;
@property (nonatomic) BOOL notNeedTitle;
@property (nonatomic, strong) JSContext *context;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSDictionary *contentDic;
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) WebViewJavascriptBridge  *bridge;
/**
 在线H5页面

 @param url h5页面地址
 @param hidden NavigationBar是否隐藏
 @return 返回webView
 */
- (instancetype)initWithURL:(NSString *)url withNavtionBar:(BOOL)hidden;

/**
 本地H5页面
 
 @param url 本地h5页面地址
 @param hidden NavigationBar是否隐藏
 @return 返回webView
 */
- (instancetype)initWithFile:(NSString *)url withNavtionBar:(BOOL)hidden;


- (void)invokeJavaScript:(NSString *)function;

/**
 * @brief 注册js调用oc的名称
 * @return 子类需要返回注册的名称，以及实现方法
 */
- (NSArray <NSString *>*)registerJavascriptName;

@end

