//
//  VKSalesModel.h
//  MeiFangManager
//
//  Created by Evan on 2017/3/11.
//  Copyright © 2017年 edosoft.net. All rights reserved.
//
/*
 * 销售顾问
 */
#import <Foundation/Foundation.h>


@interface VKSalesModel : NSObject

@property (nonatomic, copy) NSString *ID; //顾问ID

@property (nonatomic, copy) NSString *name; //顾问名字

@property (nonatomic, copy) NSString *roleId;

@property (nonatomic, copy) NSString *roleName;

@property (nonatomic, copy) NSString *roleType;


@end
