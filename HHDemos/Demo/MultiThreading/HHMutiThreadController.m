//
//  HHMutiThreadController.m
//  HHDemos
//
//  Created by xxxx on 2020/5/22.
//  Copyright © 2020 Evan. All rights reserved.
//

#import "HHMutiThreadController.h"
#import "HHSemaphoreController.h"
#import "HHConCurrenceController.h"
#import "HHThreadCommunicationController.h"

@interface HHMutiThreadController ()

@end

@implementation HHMutiThreadController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleStr = NSLocalizedString(@"并发控制", nil);
}

- (IBAction)semaphoreDemos:(id)sender {
    
    HHSemaphoreController *semaphoreController = [[HHSemaphoreController alloc]
                                                  initWithNibName:@"HHSemaphoreController" bundle:nil];
    [self addChildViewController:semaphoreController];
    [semaphoreController didMoveToParentViewController:self];
    semaphoreController.view.backgroundColor = [UIColor redColor];
    semaphoreController.view.frame = CGRectMake(0, 0, APP_WIDH, APP_HIGH);
    [self.view addSubview:semaphoreController.view];
//    [self.navigationController pushViewController:semaphoreController animated:YES];
}

- (IBAction)mutiThreadDemos:(id)sender {
    
    HHConCurrenceController *conCurrenceController = [[HHConCurrenceController alloc]
                                                      initWithNibName:@"HHConCurrenceController" bundle:nil];
    [self.navigationController pushViewController:conCurrenceController animated:YES];
}


- (IBAction)communication:(id)sender {
    
    HHThreadCommunicationController *communicationController = [[HHThreadCommunicationController alloc]
                                                                initWithNibName:@"HHThreadCommunicationController" bundle:nil];
    [self.navigationController pushViewController:communicationController animated:YES];
    
}



@end
