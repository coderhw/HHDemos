//
//  VKSalesListModel.m
//  MeiFangManager
//
//  Created by Evan on 2017/3/11.
//  Copyright © 2017年 edosoft.net. All rights reserved.
//

#import "VKSalesListModel.h"

@implementation VKSalesListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"saleTeam":@"VKSalesTeamModel"};
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"sales" : @"VKSalesModel"
             };
}

@end
