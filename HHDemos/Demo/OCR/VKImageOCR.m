//
//  VKImageOCR.m
//  VKImageOCR
//
//  Created by XXXXX on 2017/11/7.
//  Copyright © 2017年 Evan. All rights reserved.
//

#import "VKImageOCR.h"
#import <AFNetworking.h>
#define OCR_BASE_URL @"https://mgw.xxxx.com.cn/icr/recognize_id_card?encoding=utf8&head_portrait=0&crop_image=0"
//要用的时候将xxxx修改为pa全拼小写即可


@implementation VKImageOCR


+ (void)scanImage:(UIImage *)image complete:(void (^)(NSDictionary *imageInfo, BOOL success))complete {
    
    NSAssert(image != nil, @"image == nil");
    NSString *picPathc = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/tempimage.jpg"];
    NSData *imgData = UIImageJPEGRepresentation(image, 1.f);
    [imgData writeToFile:picPathc atomically:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    
    void (^requestBody)(id<AFMultipartFormData>) = ^(id<AFMultipartFormData> formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 1.f);
        [formData appendPartWithFileData:imageData name:@"file" fileName:picPathc mimeType:@"image/png"];
    };
    
    void (^requestSuccess)(NSURLSessionDataTask *, id) = ^(NSURLSessionDataTask *task, id responseObject) {
        NSString *responseString = [[NSString alloc] initWithData:responseObject
                                                         encoding:NSUTF8StringEncoding];
        NSDictionary *imageInfo = [VKImageOCR dictionaryWithJsonString:responseString];
        complete(imageInfo, YES);
    };
    
    void (^requestFailure)(NSURLSessionDataTask *task, NSError *error) =
    ^(NSURLSessionDataTask *operation, NSError *error) {
        complete(nil, NO);
    };
    
    [manager POST:OCR_BASE_URL parameters:nil
constructingBodyWithBlock:requestBody progress:nil
          success:requestSuccess
          failure:requestFailure];
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err){
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end

