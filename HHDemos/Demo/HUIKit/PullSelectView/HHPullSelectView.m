//
//  HHPullSelectView.m
//  VKDemoProject
//
//  Created by XXXXX on 2018/3/19.
//  Copyright © 2018年 Evan. All rights reserved.
//

#import "HHPullSelectView.h"
#import "UIButton+ImageTitleSpacing.h"

@interface HHPullSelectView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;  //二维数据
@property (nonatomic, assign) CGRect rect;
@property (nonatomic, strong) NSMutableArray *selectTitles;      //选中的Titles
@property (nonatomic, copy) NSString        *selectTitle;
@property (nonatomic, assign) NSInteger     titleIndex;     //



@end


@implementation HHPullSelectView

- (nullable instancetype)initWithFrame:(CGRect)frame
                            selectTitles:(NSArray *)selectTitles
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.rect = frame;
        self.selectTitles = [[NSMutableArray alloc] initWithArray:selectTitles];
        [self addsubView];
    }
    return self;
}

- (void)addsubView {
    
    if(!self.titles.count) return;
    for (int i = 0; i < 2; i++) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * APP_WIDH/2, 0, APP_WIDH/2, 44)];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:_selectTitles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHex:@"#666666"] forState:UIControlStateNormal];
        button.tag = 888+i;
        [button setImage:[UIImage imageNamed:@"timeArrow"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(pullSelectPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:16];
        [self addSubview:button];
    }
    
    CGRect tableViewF = self.rect;
    tableViewF.origin.y = 44;
    tableViewF.size.height = [self.titles[_titleIndex] count] * 44;
    
    _tableView = [[UITableView alloc] initWithFrame:tableViewF style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.hidden = YES;
    _tableView.delegate = self;
    [self addSubview:_tableView];
}

#pragma mark - UITableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    if (!cell) {

        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellID"];
    }
    cell.backgroundColor = [UIColor lightTextColor];
    NSArray *rowTitles = self.titles[_titleIndex];
    cell.textLabel.text = rowTitles[indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithHex:@"#666666"];
    
    UIImageView *selectView = [cell.contentView viewWithTag:888+3];
    if(selectView){
        [selectView removeFromSuperview];
        selectView = nil;
    }
    
    UIImage *selectImg = [UIImage imageNamed:@"icon_sel_pop_list"];
    selectView = [[UIImageView alloc] initWithImage:selectImg];
    selectView.frame = CGRectMake(APP_WIDH - 16 - selectImg.size.width, 16, selectImg.size.width, selectImg.size.height);
    [cell.contentView addSubview:selectView];
    selectView.tag = 888 + 3;
    NSString *selectTitle = self.selectTitles[_titleIndex];
    NSLog(@"---->%@", selectTitle);
    NSLog(@"---->%@", rowTitles);
    if([selectTitle isEqualToString:rowTitles[indexPath.row]]){
        
        selectView.hidden = NO;
    }else{
        selectView.hidden = YES;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.titles[_titleIndex] count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *titles = self.titles[_titleIndex];
    NSString *selectTitle = titles[indexPath.row];
    [self.selectTitles replaceObjectAtIndex:_titleIndex withObject:selectTitle];
    NSLog(@"selectTitles:%@", self.selectTitles);
    [self updateButtonTitles];
    
    if(self.selectResultBlock){
        self.selectResultBlock(self.selectTitles);
    }
    [self dismiss];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 8, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - getter methods
- (NSArray *)titles {
    
    NSArray *items1 = @[@"拓客排名", @"发展经纪人排名"];
    NSArray *items2 = @[@"今天", @"本周", @"本月", @"本年"];
    NSArray *titles = @[items1, items2];
    return titles;
}

- (UIControl *)backgroundView {
    
    if(!_backgroundView){
        
        _backgroundView = [[UIControl alloc] initWithFrame:CGRectZero];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0.6;
        _backgroundView.hidden = YES;
        [_backgroundView addTarget:self action:@selector(dismiss)
                  forControlEvents:UIControlEventTouchUpInside];
    }
    return _backgroundView;
}


#pragma mark - Controls
- (void)pullSelectPressed:(UIButton *)sender {
    
    self.titleIndex = sender.tag-888;
    
    CGRect rect = self.frame;
    rect.size.height = [self.titles[_titleIndex] count] * 44 + 44;
    self.frame = rect;

    CGRect tableViewF = self.rect;
    tableViewF.origin.y = 44;
    tableViewF.size.height = [self.titles[_titleIndex] count] * 44;
    self.tableView.frame = tableViewF;
    
    if(self.tableView.hidden){
        
        self.tableView.hidden = NO;
        self.backgroundView.hidden = NO;
        [self show];
    }else{
        
        [self dismiss];
        self.tableView.hidden = YES;
        self.backgroundView.hidden = YES;
    }
    
    [self.tableView reloadData];

}

- (void)updateButtonTitles {
    
    for (UIButton *btn in self.subviews) {
        if(btn.tag == 888){
            [btn setTitle:self.selectTitles[0] forState:UIControlStateNormal];
            [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:16];
        }else if(btn.tag == 889){
            [btn setTitle:self.selectTitles[1] forState:UIControlStateNormal];
            [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:16];
        }
    }
}

- (void)show {
    
    //reset self frame
    CGRect rect = self.frame;
    rect.size.height = [self.titles[_titleIndex] count] * 44 + 44;
    self.frame = rect;
    //reset tableView frames
    CGRect tableViewF = self.rect;
    tableViewF.origin.y = 44;
    tableViewF.size.height = [self.titles[_titleIndex] count] * 44;
    self.tableView.frame = tableViewF;
    //reset backgroundView frame
    CGRect backgroundViewF = self.frame;
    backgroundViewF.origin.y = self.frame.origin.y + self.frame.size.height;
    backgroundViewF.size.height = APP_HIGH - (self.frame.origin.y + self.frame.size.height);
    backgroundViewF.size.width = APP_WIDH;
    backgroundViewF.origin.x = 0;
    
    self.backgroundView.frame = backgroundViewF;
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.backgroundView];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
}

- (void)dismiss {
    
    [_backgroundView removeFromSuperview];
    _backgroundView = nil;
    _tableView.hidden = YES;
    
    CGRect rect = self.frame;
    rect.size.height = 44;
    self.frame = rect;
    _tableView.frame = CGRectZero;
}



@end
