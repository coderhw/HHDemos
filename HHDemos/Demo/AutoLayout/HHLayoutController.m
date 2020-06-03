//
//  HHLayoutController.m
//  VKDemoProject
//
//  Created by XXXX on 2018/11/1.
//  Copyright © 2018 Evan. All rights reserved.
//

#import "HHLayoutController.h"
#import "HHVFLViewController.h"
#import "HHLayoutViewController.h"
#import <Masonry.h>

@interface HHLayoutController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSources;

@property (nonatomic , strong)UIView *redView;
@property (nonatomic , strong)UIView *yellowView;
@property (nonatomic, strong) UIButton *button;

@end

@implementation HHLayoutController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.dataSources = @[@"VFL Layout", @"NSLayoutContrains",@"VFL Layout",
                         @"NSLayoutContrains", @"VFL Layout", @"NSLayoutContrains",
                         @"VFL Layout", @"NSLayoutContrains", @"VFL Layout",
                         @"NSLayoutContrains", @"VFL Layout", @"NSLayoutContrains",
                         @"VFL Layout", @"NSLayoutContrains",@"VFL Layout",
                         @"NSLayoutContrains",@"VFL Layout", @"NSLayoutContrains"];
    
    [self.view addSubview:self.tableView];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *views  = NSDictionaryOfVariableBindings(_tableView);
    NSDictionary *metres = @{@"top":@0,@"bottom":@0, @"left":@10, @"right":@0,@"tableViewH":@200};
    NSArray *HContrains = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_tableView]-0-|"
                                                                      options:0 metrics:metres views:views];
    NSArray *VContrains = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_tableView]-0-|"
                                                                     options:0 metrics:metres views:views];
    [self.view addConstraints:HContrains];
    [self.view addConstraints:VContrains];
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {return self.dataSources.count;}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YY"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YY"];
    }
    cell.textLabel.text = self.dataSources[indexPath.row];
    cell.backgroundColor = [UIColor colorWithHex:kRedColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"indexPath:%ld", (long)indexPath.row);
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            HHVFLViewController *vflVC = [[HHVFLViewController alloc] init];
            [self.navigationController pushViewController:vflVC animated:YES];
        }
            break;
        case 1:
        {
            HHLayoutViewController *layoutVC = [[HHLayoutViewController alloc] init];
            [self.navigationController pushViewController:layoutVC animated:YES];
        }
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

#pragma mark - Getter/Setter Mehtods
- (UITableView *)tableView {
    
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}




@end
