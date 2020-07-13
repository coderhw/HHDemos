//
//  HHDrawBoardViewController.m
//  HHDemos
//
//  Created by Evan on 2020/7/7.
//  Copyright © 2020 Evan. All rights reserved.
//

#import "HHDrawBoardViewController.h"
#import "HHDrawBoard.h"
#import "PABDrawBoardView.h"
@interface HHDrawBoardViewController ()

@end

@implementation HHDrawBoardViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    
    PABDrawBoardView *drawBoard = [PABDrawBoardView drawBoardView];
    [drawBoard showWithView:self.view];
}



@end
