//
//  HHVFLViewController.m
//  HHDemos
//
//  Created by XXXXX on 2020/6/1.
//  Copyright © 2020 Evan. All rights reserved.
//

#import "HHVFLViewController.h"

@interface HHVFLViewController ()

@property (nonatomic , strong)UIView *redView;
@property (nonatomic , strong)UIView *yellowView;
@property (nonatomic, strong) UIButton *button;

@end

@implementation HHVFLViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    self.navigationItem.title = @"List";

    ///先将控件添加到视图上
    [self.view addSubview:self.redView];
    [self.view addSubview:self.yellowView];
    [self.view addSubview:self.button];


    ///注意translatesAutoresizingMaskIntoConstraints 一定要设置为 NO
    self.redView.translatesAutoresizingMaskIntoConstraints = NO;
    self.yellowView.translatesAutoresizingMaskIntoConstraints = NO;
    self.button.translatesAutoresizingMaskIntoConstraints = NO;

    ///创建第四个参数用到布局 views 的字典 注意 这个地方用 NSDictionaryOfVariableBindings
    NSDictionary *views = NSDictionaryOfVariableBindings(_redView,_yellowView);

    ///创建第三个参数 所用到的 布局度量 metres 字典
    NSDictionary *metres = @{@"redViewnW":@100, @"leftArglin":@50,@"rightArglin":@50};

    ///水平方向的约束
    NSArray *HContrains = [NSLayoutConstraint
                           constraintsWithVisualFormat:@"H:|-leftArglin-[_redView(redViewnW)]-11-[_yellowView]-rightArglin-|"
                           options:0 metrics:metres views:views];

    ///垂直方向的约束
    NSArray *VContrains = [NSLayoutConstraint
                           constraintsWithVisualFormat:@"V:|-120-[_redView(50)]-20-[_yellowView(==_redView)]"
                                     options:0 metrics:metres views:views];
    
    ///注意上面 如果V:|-20-[_redView(50)]-20-[_yellowView(==_redView)] 换成了V:|-20-[_redView(50)]-20-[_yellowView(==_redView)]-| 会把_yellowView拉着顶到父视图的下边,所以如果你写了这个-| 又和_yellowView 高度定死和 距离 _redView 20 起了冲突 所以会报约束异常

    NSDictionary *btnViews = NSDictionaryOfVariableBindings(_button);
    NSDictionary *btnMetrics = @{@"buttonW":@100, @"left":@50, @"top":@290, @"buttonH": @80};

    NSArray *HContrainsBtn = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-left-[_button]-|"
                                                                     options:0 metrics:btnMetrics views:btnViews];
    NSArray *VContrainsBtn = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[_button(buttonH)]"
                                                                     options:0 metrics:btnMetrics views:btnViews];

    ///添加约束
    [self.view addConstraints:HContrains];
    [self.view addConstraints:VContrains];
    [self.view addConstraints:HContrainsBtn];
    [self.view addConstraints:VContrainsBtn];
}

#pragma mark - Getter Methods
-(UIView *)redView {
    if (!_redView) {
        _redView = [[UIView alloc] init];
        _redView.backgroundColor = [UIColor redColor];
    }
    return _redView;
}

-(UIView *)yellowView {
    if (!_yellowView) {
        _yellowView = [[UIView alloc] init];
        _yellowView.backgroundColor = [UIColor yellowColor];
    }
    return _yellowView;
}

- (UIButton *)button {
    if (!_button) {
        _button = [[UIButton alloc] init];
        _button.backgroundColor = [UIColor magentaColor];
    }
    return _button;
}


@end
