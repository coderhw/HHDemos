//
//  TTAd.h
//  TTProject
//
//  Created by Evan on 16/9/22.
//  Copyright © 2016年 Evan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTAd : NSObject

/** 广告图片 */
@property (copy, nonatomic) NSString *image;

/** 广告url */
@property (strong, nonatomic) NSURL *url;

@end
