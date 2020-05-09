//
//  HHRunLoopViewController.m
//  HHDemoProject
//
//  Created by XXXX on 2019/3/5.
//  Copyright © 2019 Evan. All rights reserved.
//

#import "HHRunLoopViewController.h"
#import "HHThread.h"


@interface HHRunLoopViewController ()

@end

@implementation HHRunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
  
}

- (void)run {
    NSLog(@"%s", __func__);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    HHThread *thread = [[HHThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    [thread start];
    
    NSLog(@"%s, %@", __func__, [NSThread currentThread]);
}


@end
