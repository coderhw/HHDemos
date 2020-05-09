
//
//  VKImagesUtility.m
//  VKFilePersistenceDemo
//
//  Created by Evan on 2016/12/16.
//  Copyright © 2016年 Vanke.com All rights reserved.
//

#import "VKImagesUtility.h"
#import "FCFileManager.h"

@implementation VKImagesUtility

+ (void)writeImageToDiskWithImages:(NSArray *)images
                     withImageKeys:(NSArray *)imageKeys
                        withUserId:(NSString *)userId{
    
    
    //根据用户UserId创建图片存放路径
    NSString *userImageDeirectory = [FCFileManager pathForDocumentsDirectoryWithPath:userId];
    
    //检查目录是否存在
    //NSString *userImageDeirectory1 = [FCFileManager pathForDocumentsDirectoryWithPath:@"123"];
    BOOL isDirectoryExist = [FCFileManager isDirectoryItemAtPath:userImageDeirectory];
    
    if(isDirectoryExist) {
        //目录存在
        for(int i = 0; i < images.count; i++) {
            //根据ImageKey查找图片是否存在
            NSString *imagePathKey = [userImageDeirectory stringByAppendingPathComponent:[imageKeys objectAtIndex:i]];
            BOOL isFileExist = NO;
            if([FCFileManager existsItemAtPath:[NSString stringWithFormat:@"%@.jpg", imagePathKey]]) {
                isFileExist = [FCFileManager existsItemAtPath:[NSString stringWithFormat:@"%@.jpg", imagePathKey]];
            }else {
                isFileExist = [FCFileManager existsItemAtPath:[NSString stringWithFormat:@"%@.png", imagePathKey]];
            }
            
            if(isFileExist){
                NSLog(@"image isExist!%@", imagePathKey);
            }else {
                //存放资源
                UIImage *image = images[i];
                NSData *imageData = nil;
                if([imagePathKey containsString:@"jpg"]){
                    imageData = UIImagePNGRepresentation(image);
                }else {
                    imageData = UIImageJPEGRepresentation(image, 1);
                }
                NSString *imagePathKey = imageKeys[i];
                NSString *imageDirectory = [FCFileManager pathForDocumentsDirectoryWithPath:userId];
                NSString *imagePath = [imageDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", imagePathKey]];
                if(![FCFileManager writeFileAtPath:imagePath content:imageData]) {
                    //如果存储失败, 则删掉
                    NSError *error = nil;
                    [FCFileManager removeItemAtPath:imagePath error:&error];
                }
            }
        }
    }else {
        
        //目录不存在创建目录
        NSError *error = nil;
        [FCFileManager createDirectoriesForPath:userImageDeirectory error:&error];
        if(error) {
            NSLog(@"error:%@", error.localizedDescription);
        }
        
        //存放资源
        for(int i = 0; i < images.count; i++) {
            UIImage *image = images[i];
            NSData *imageData = UIImagePNGRepresentation(image);
            NSString *imagePathKey = imageKeys[i];
            NSString *imageDirectory = [FCFileManager pathForDocumentsDirectoryWithPath:userId];
            NSString *imagePath = [imageDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", imagePathKey]];
            if(![FCFileManager writeFileAtPath:imagePath content:imageData]) {
                //如果存储失败, 则删掉
                NSError *error = nil;
                [FCFileManager removeItemAtPath:imagePath error:&error];
            }
        }
    }
}

+ (NSMutableArray *)getImagesWithUserId:(NSString *)userId ImagesKeys:(NSArray *)imageKeys {
    
    if(!imageKeys.count) return nil;
    NSMutableArray *imagesArray = [NSMutableArray array];
    NSString *userImageDeirectory = [FCFileManager pathForDocumentsDirectoryWithPath:userId];
    
    for(int i = 0; i < imageKeys.count; i++) {
        NSString *imageKey = [NSString stringWithFormat:@"%@", imageKeys[i]];
        NSString *imagePathKey = [userImageDeirectory stringByAppendingPathComponent:imageKey];
        UIImage *image =  [FCFileManager readFileAtPathAsImage:imagePathKey];
        if(image){
            [imagesArray addObject:image];
        }
    }
    return imagesArray;
    //    NSString *imagePathKey = [userImageDeirectory stringByAppendingPathComponent:@"hello-1"];
    //    UIImage *image =  [FCFileManager readFileAtPathAsImage:[NSString stringWithFormat:@"%@.png", imagePathKey]];
    
}

+ (NSMutableArray *)filterImageKeysBySuffixKeys:(NSArray *)keys withUserId:(NSString*)userId isSync:(BOOL)isSync{
    
    //根据用户UserId创建图片存放路径
    NSString *userImageDeirectory = [FCFileManager pathForDocumentsDirectoryWithPath:userId];
    NSArray *existPNGKeys = [FCFileManager listFilesInDirectoryAtPath:userImageDeirectory withSuffix:@"png" deep:YES];
    NSArray *existsJPGkeys = [FCFileManager listFilesInDirectoryAtPath:userImageDeirectory withSuffix:@"jpg" deep:YES];
    NSMutableArray *existskeys = [NSMutableArray arrayWithArray:existPNGKeys];
    [existskeys addObjectsFromArray:existsJPGkeys];
    
    //获取keys后缀
    NSArray *keysSuffixs = [VKImagesUtility getKeysSuffixWithKeys:keys];
    //获取已经存在文件的后缀
    NSArray *existSuffixs = [VKImagesUtility getKeysSuffixWithKeys:existskeys];
    NSMutableArray *needDownloadKeys = [NSMutableArray array];
    for(int i = 0; i < keysSuffixs.count; i++) {
        
        if(![existSuffixs containsObject:keysSuffixs[i]]){
            [needDownloadKeys addObject:keys[i]];
        }
    }
    
    if(isSync) {
        //将本地文件后缀与之比较，删除本地多余的图片
        NSMutableArray *needDeleteKeys = [NSMutableArray array];
        for(int i = 0; i < existSuffixs.count; i++) {
            if(![keysSuffixs containsObject:existSuffixs[i]]) {
                [needDeleteKeys addObject:existskeys[i]];
                NSLog(@"needDeleteKeys:%@", needDeleteKeys);
                NSError *error = nil;
                [FCFileManager removeItemAtPath:existskeys[i] error:&error];
            }
        }
    }
   
    return needDownloadKeys;
}


+ (NSMutableArray *)getKeysSuffixWithKeys:(NSArray *)keys {
    
    NSMutableArray *subfixKeys = [NSMutableArray array];
    for(int i = 0; i < keys.count; i++) {
        if([keys[i] length] < 8) return nil;
        NSString *suffixStr = [keys[i] substringFromIndex:[keys[i] length] - 8];
        [subfixKeys addObject:suffixStr];
    }
    return subfixKeys;
}


@end
