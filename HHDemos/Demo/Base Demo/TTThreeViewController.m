//
//  TTThreeViewController.m
//  HHDemos
//
//  Created by XXXXX on 2020/5/7.
//  Copyright © 2020 Evan. All rights reserved.
//

#import "TTThreeViewController.h"

@interface TTThreeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TTThreeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initializeConstraints];
}

- (void)initializeConstraints {
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
         if(@available(iOS 11.0, *)){
             make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(-44);
//             make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
         } else {
             make.top.equalTo(self.mas_topLayoutGuide);
//             make.bottom.equalTo(self.mas_bottomLayoutGuide);
         }
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);

    }];
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YY"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YY"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    cell.backgroundColor = [UIColor magentaColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (UITableView *)tableView {
    
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor magentaColor];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
