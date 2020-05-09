//
//  TTStatusResult.h
//  TTProject
//
//  Created by Evan on 16/9/22.
//  Copyright © 2016年 Evan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TTUser;

@interface TTStatus : NSObject

/** 微博文本内容 */
@property (copy, nonatomic) NSString *text;
/** 微博作者 */
@property (strong, nonatomic) TTUser *user;
/** 转发的微博 */
@property (strong, nonatomic) TTStatus *retweetedStatus;

@end
