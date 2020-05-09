//
//  HHPickView.m
//  HHDemoProject
//
//  Created by XXXXX on 2019/5/10.
//  Copyright © 2019 Evan. All rights reserved.
//

#import "HHPickView.h"

@interface HHPickView ()<UIPickerViewDelegate, UIPickerViewDataSource>


@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UILabel  *titleLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;

@property (nonatomic, strong) NSMutableArray *leftSource;
@property (nonatomic, strong) NSMutableArray *rightSource;
@property (nonatomic, strong) NSMutableArray *items;
@end

@implementation HHPickView


+ (instancetype)pickView {
    return [[[NSBundle mainBundle] loadNibNamed:@"HHPickView"owner:nil
                                        options:nil] firstObject];
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    NSArray *rightItems1 = @[@"1", @"2", @"3"];
    NSArray *rightItems2 = @[@"4", @"5", @"6"];
    NSArray *leftItems = @[@"key1", @"key2"];
    
    self.leftSource = [NSMutableArray array];
    self.rightSource = [NSMutableArray array];
    self.items = [NSMutableArray array];


    [self.leftSource addObjectsFromArray:leftItems];
    
    [self.items addObject:rightItems1];
    [self.items addObject:rightItems2];
    [self.rightSource addObjectsFromArray:rightItems1];
    
}

- (void)drawRect:(CGRect)rect {
    
    self.frame = CGRectMake(0, 0, APP_WIDH, 260);
    self.center = self.superview.center;
    self.pickView.delegate = self;
    self.pickView.dataSource = self;
    
}

#pragma mark - UIPickView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(component == 0){
        return _leftSource.count;
    }else{
        return _rightSource.count;
    }
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSString *value = nil;
    if(component == 0){
        value = _leftSource[row];
    }else if (component == 1){
        value = _rightSource[row];
    }
    return value;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
//        self.selectedArray = [self.pickerDic objectForKey:[self.provinceArray objectAtIndex:row]];
//        if (self.selectedArray.count > 0) {
//            self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
//        } else {
//            self.cityArray = nil;
//        }
//        if (self.cityArray.count > 0) {
//            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
//        } else {
//            self.townArray = nil;
//        }
        _rightSource = self.items[row];
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
    [pickerView reloadComponent:1];
//    [pickerView selectedRowInComponent:2];
    
//    if (component == 1) {
////        if (self.selectedArray.count > 0 && self.cityArray.count > 0) {
////            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:row]];
////        } else {
////            self.townArray = nil;
////        }
//        [pickerView selectRow:1 inComponent:2 animated:YES];
//    }
//
//    [pickerView reloadComponent:2];
    
}
@end
