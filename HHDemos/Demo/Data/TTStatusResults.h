//
//  statusResult.h
//  TTProject
//
//  Created by Evan on 16/9/22.
//  Copyright © 2016年 Evan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTStatusResults : NSObject

/** 存放着某一页微博数据（里面都是Status模型） */
@property (strong, nonatomic) NSMutableArray *statuses;

/** 存放着一堆的广告数据（里面都是MJAd模型） */
@property (strong, nonatomic) NSArray *ads;

/** 总数 */
@property (strong, nonatomic) NSNumber *totalNumber;

/** 上一页的游标 */
@property (assign, nonatomic) long long previousCursor;

/** 下一页的游标 */
@property (assign, nonatomic) long long nextCursor;


@end
