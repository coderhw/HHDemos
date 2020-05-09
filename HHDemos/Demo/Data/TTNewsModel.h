//
//  TTNewsModel.h
//  TTProject
//
//  Created by Evan on 16/9/22.
//  Copyright © 2016年 Evan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTHouseNewsModel.h"

@interface TTNewsModel : NSObject

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) TTHouseNewsModel *houseNews;

@end
