//
//  VKImageOCR.h
//  VKImageOCR
//
//  Created by XXXXX on 2017/11/7.
//  Copyright © 2017年 Evan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VKImageOCR : NSObject

+ (void)scanImage:(UIImage *)image complete:(void (^)(NSDictionary *imageInfo, BOOL success))complete;


@end

