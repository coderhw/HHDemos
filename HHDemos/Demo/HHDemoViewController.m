//
//  ViewController.m
//  VKTeamsProject
//
//  Created by XXXX on 2017/7/5.
//  Copyright © 2017年 Evan. All rights reserved.

#import "HHDemoViewController.h"
//Base
#import "HHBaseViewController.h"
#import "HHBaseNavigationController.h"
//Runtime
#import "HHRuntimeViewController.h"
//Contact
#import "HHContactViewController.h"
#import "TTSecondViewController.h"
#import "TTThreeViewController.h"
//Render
#import "HHRenderContextController.h"
//QR
#import "TTQRViewControler.h"
//Concurrence Control
#import "HHMutiThreadController.h"
//Hybird
#import "HHBaseWebViewController.h"
#import "HHWebViewTestController.h"
//UIKit
#import "HHUIViewController.h"
//UILayer
#import "HHLayerController.h"
//C
#import "HHCController.h"
//DB
#import "HHDBViewController.h"
//Xib
#import "HHFunctionViewController.h"
#import "HHUserPrivacyView.h"
//web
#import "HHWebViewController.h"
//Layout
#import "HHLayoutController.h"
//RunLoop
#import "HHRunLoopViewController.h"

@interface HHDemoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSArray           *demoLists;
@property (nonatomic, strong) NSMutableArray    *dataSources;

@end

@implementation HHDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    int a = 99;
    NSLog(@"a:%d", a);
    
    id obj = [[NSObject alloc] init];
//    [obj run];
    NSLog(@"obj:%@", obj);
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"List";
    
    self.demoLists = @[@"运行时Demo",@"通讯录",@"基类控制器",@"图形处理",
                       @"二维码",@"并发控制",@"WebView",
                       @"UIKit",@"CALayer",@"C",@"FMDB",
                       @"XIB Demos",@"Layout",@"RunLoop Demo"];
    self.dataSources = [NSMutableArray arrayWithArray:_demoLists];
    
    //UI
    [self initializeConstraints];
    NSLog(@"viewDidLoad");
}


- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    NSLog(@"viewWillLayoutSubviews");
}

- (void)initializeConstraints {
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
         if(@available(iOS 11.0, *)){
             make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(-44);
         } else {
             make.top.equalTo(self.mas_topLayoutGuide);
         }
         
         if(@available(iOS 11.0, *)){
             make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
             
         } else {
             make.bottom.equalTo(self.mas_bottomLayoutGuide);
         }
         make.left.and.right.equalTo(self.view);
    }];
    
}


- (void)readLocalFileWithPath:(NSString *)localPath resuleCallback:(void (^)(BOOL success, NSError *error))callBack {
    
}

- (void)readLocalFile:(NSString *)localPath resultCallBack:(void(^)(BOOL success, NSError *error))callBack {
    
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSources.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YY"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YY"];
    }
    cell.textLabel.text = self.dataSources[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"indexPath:%ld", (long)indexPath.row);
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *viewContoller = nil;
    switch (indexPath.row) {
        case 0:
        {
            viewContoller  = [[HHRuntimeViewController alloc] initWithNibName:@"HHRuntimeViewController" bundle:nil];
        }
            break;
        case 1:
        {
            viewContoller = [[HHContactViewController alloc] initWithNibName:@"HHContactViewController" bundle:nil];
        }
            break;
        case 2:
        {
            viewContoller = [[TTSecondViewController alloc] init];
        }
            break;
        case 3:
        {
            viewContoller = [[HHRenderContextController alloc] initWithNibName:@"HHRenderContextController" bundle:nil];
        }
            break;
        case 4:
        {
            viewContoller = [[TTQRViewControler alloc] init];
        }
            break;
        case 5:
        {
            viewContoller = [[HHMutiThreadController alloc] initWithNibName:@"HHMutiThreadController" bundle:nil];
        }
            break;
        case 6:
        {
            viewContoller = [[HHWebViewTestController alloc] initWithNibName:@"HHWebViewTestController" bundle:nil];
        }
            break;
        case 7:
        {
            viewContoller = [[HHUIViewController alloc] initWithNibName:@"HHUIViewController" bundle:nil];
        }
            break;
        case 8:
        {
            viewContoller = [[HHLayerController alloc] initWithNibName:@"HHLayerController" bundle:nil];
        }
            break;
        case 9:
        {
            viewContoller = [[HHCController alloc] initWithNibName:@"HHCController" bundle:nil];
            break;
        }
            break;
        case 10:
        {
            viewContoller = [[HHDBViewController alloc] initWithNibName:@"HHDBViewController" bundle:nil];
            break;
        }
        case 11:
        {
            viewContoller = [[HHFunctionViewController alloc] initWithNibName:@"HHFunctionViewController" bundle:nil];
            break;
        }
        case 12:
        {
            viewContoller = (HHBaseViewController *)[[HHLayoutController alloc] init];
            [viewContoller setValue:@"Layout" forKey:@"titleStr"];
        }
            break;
        case 13:
        {
            viewContoller = (HHRunLoopViewController *)[[HHRunLoopViewController alloc] init];
        }
        default:
            break;
    }
    viewContoller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewContoller animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

#pragma mark - Getter/Setter Mehtods
- (UITableView *)tableView {
    
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}






@end
