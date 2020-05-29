//
//  HHFunctionViewController.m
//  HHDemos
//
//  Created by 胡文(金服银行科技中心网点赋能开发团队平台组) on 2020/5/22.
//  Copyright © 2020 Evan. All rights reserved.
//

#import "HHFunctionViewController.h"
#import "HHXibViewController.h"

typedef void(^HHMutiCallBackBlock)(void);

@interface HHFunctionViewController ()

@property (nonatomic, copy) HHMutiCallBackBlock mutiCallBackBlock;

@end

@implementation HHFunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)autoResizeCellDemo:(id)sender {
    
    HHXibViewController *autoResizeCellVC = [[HHXibViewController alloc] initWithNibName:@"HHXibViewController" bundle:nil];
    [self.navigationController pushViewController:autoResizeCellVC animated:YES];
}

- (IBAction)mutiCallBackBlockDemo:(id)sender {
    
    [self fetchDataFromNetwork:^(NSString *message) {
        NSLog(@"message:%@", message);
    }];
}

- (IBAction)triggerCallBackBlockDemo:(id)sender {
    
}


- (void)fetchDataFromNetwork:(void(^)(NSString *message))resultBlock {

    if(resultBlock){
        resultBlock(@"This is First CallBack");
    }
    
    dispatch_time_t timeWait = dispatch_time(DISPATCH_TIME_NOW, 5ull * NSEC_PER_SEC);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_semaphore_wait(semaphore, timeWait);
    resultBlock(@"This is Second CallBack");
    
}



@end
