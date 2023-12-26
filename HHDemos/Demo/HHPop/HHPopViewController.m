//
//  HHPopViewController.m
//  HHDemos
//
//  Created by Huwen on 2023/12/23.
//  Copyright © 2023 Evan. All rights reserved.
//

#import "HHPopViewController.h"
#import "FTPopOverMenu.h"

@interface HHPopViewController ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation HHPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 60, 44)];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonPressed:(UIButton *)sender {
    NSString *icomImageURLString = @"https://avatars1.githubusercontent.com/u/4414522?v=3&s=40";
    NSURL *icomImageURL = [NSURL URLWithString:icomImageURLString];

    [FTPopOverMenu showForSender:sender
                   withMenuArray:@[@"MenuOne", @"MenuTwo", @"MenuThree", @"MenuFour",]
                      imageArray:@[icomImageURLString, icomImageURL, [UIImage imageNamed:@"Pokemon_Go_03"], @"Pokemon_Go_04"]
//                   configuration:configuration
                       doneBlock:^(NSInteger selectedIndex) {
                           
                           NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                           
                       } dismissBlock:^{
                           
                           NSLog(@"user canceled. do nothing.");
                           
//                           FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
//                           configuration.allowRoundedArrow = !configuration.allowRoundedArrow;
                           
                       }];
}

@end
