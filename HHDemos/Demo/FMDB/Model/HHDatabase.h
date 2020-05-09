//
//  HHDatabase.h
//  VKDemoProject
//
//  Created by XXXXX on 2018/9/7.
//  Copyright © 2018年 Evan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>

@interface HHDatabase : NSObject

@property (nonatomic, strong) FMDatabase  *db;
@property (nonatomic, strong) FMDatabaseQueue *queue;
/**
 实例化Instance
 @return HHDatabase
 */
+ (instancetype)sharedDataBase;


/**
 *初始化DB
 */
- (void)initDataBase;


@end
