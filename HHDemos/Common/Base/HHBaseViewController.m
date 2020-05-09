//
//  TTBaseViewController.m
//  TTProject
//
//  Created by Evan on 16/8/29.
//  Copyright © 2016年 Evan. All rights reserved.
//

#import "HHBaseViewController.h"
#import "UIColor+Util.h"
#import "HHUtilsDefineHeader.h"

@interface HHBaseViewController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) UIButton  *backButton;
@end

@implementation HHBaseViewController

- (void)dealloc {
    NSLog(@"%@", NSStringFromClass([self class]));
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
   
    [super viewWillDisappear:animated];
    if(self.navigationController.viewControllers.count == 1) {
        if(_backButton){
            [_backButton removeFromSuperview];
            _backButton = nil;
        }
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    
    ///隐藏系统的返回按钮
    [self.navigationItem.backBarButtonItem setCustomView:[UIView new]];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;

    //导航栏
    [self configNavigationBar];
    //返回按钮
    [self initBackButton];
}

- (void)initBackButton {
    
    if([self.navigationController.viewControllers count] == 2){
        [self.navigationController.navigationBar addSubview:self.backButton];
    }
}


- (void)configNavigationBar {
    
    //改变状态栏颜色 导航栏字体 颜色
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHex:kTextColor_6],
                              NSFontAttributeName:kFONT(kTitleName_PingFang_M, 14)}];
    
    // 隐藏导航栏下方的线
    [self hideBottomLineOnNavBar];
    
    //[self customNavigationBar];
    //是否根据ScrollView的Inset自适应
    
    if(@available(iOS 11.0, *)){
        self.automaticallyAdjustsScrollViewInsets = YES;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.navigationController.navigationBar.translucent = NO;
    //拓展是否包含不透明的Bar
    //self.extendedLayoutIncludesOpaqueBars = NO;
    //self.modalPresentationCapturesStatusBarAppearance = NO;
    
    
}

- (void)backButtonPressed:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Getter/Setter
- (UIButton *)backButton {
    
    if(!_backButton) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 44, 44);
        [backButton setImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backButtonPressed:)
             forControlEvents:UIControlEventTouchUpInside];
        _backButton = backButton;
        _backButton.hidden = _hideBackButton;
    }
    return _backButton;
}

- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    self.navigationItem.title = _titleStr;
}


#pragma mark - 遍历导航栏的所有子视图
NSArray *allNavigationSubviews(UIView *aView) {
    NSArray *subviews = [aView subviews];
    for (UIView *eachView in aView.subviews){
        NSArray *tempSubviews = allNavigationSubviews(eachView);
        if (tempSubviews)
            subviews = [subviews arrayByAddingObjectsFromArray:tempSubviews];
    }
    return subviews;
}

// 隐藏导航栏下方的线
- (void)hideBottomLineOnNavBar {
    
    NSArray *subViews = allNavigationSubviews(self.navigationController.navigationBar);
    UIImageView *shadowLine = nil;
    for (UIView *view in subViews) {
        if ([view isKindOfClass:[UIImageView class]] && view.bounds.size.height<1) {
            //实践后发现系统的横线高度为0.333
            shadowLine = (UIImageView *)view;
        }
    }
    shadowLine.hidden = YES;
}

- (void)setNavColor:(UIColor *)navColor {
    self.navigationController.navigationBar.barTintColor = navColor;
}

- (void)setTitleColor:(UIColor *)titleColor {
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor,
                              NSFontAttributeName:BFONT(16)}];
    
}

- (void)setTitleFont:(UIFont *)titleFont {
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSFontAttributeName:titleFont}];
}

@end


