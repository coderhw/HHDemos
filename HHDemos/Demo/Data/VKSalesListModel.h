//
//  VKSalesListModel.h
//  MeiFangManager
//
//  Created by Evan on 2017/3/11.
//  Copyright © 2017年 edosoft.net. All rights reserved.
//

#import "VKSalesModel.h"
#import "VKSalesTeamModel.h"


@interface VKSalesListModel : NSObject

@property (nonatomic, strong) VKSalesTeamModel *teamModel;

@property (nonatomic, strong) NSArray *sales;

@end
