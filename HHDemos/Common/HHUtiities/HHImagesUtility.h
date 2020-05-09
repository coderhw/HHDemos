//
//  VKImagesUtility.h
//  VKFilePersistenceDemo
//
//  Created by Evan on 2016/12/16.
//  Copyright © 2016年 XXXX.com All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VKImagesUtility : NSObject


/**
 存放图片

 @param images 要存放的图片
 @param imageKeys 图片名字对应的key 
 @userId 通过UserId 默认在Document 目录下面创建子目录
 @ ps: 如果key已经存在，则不会再次持久化该图片
 */
+ (void)writeImageToDiskWithImages:(NSArray *)images
                     withImageKeys:(NSArray *)imageKeys
                        withUserId:(NSString *)userId;



/**
 读取图片

 @param userId 图片存放的目录/文件夹
 @param imageKeys 通过ImageKey读取文件
 @return 返回所需要读取的图片
 */
+ (NSMutableArray *)getImagesWithUserId:(NSString *)userId
                             ImagesKeys:(NSArray *)imageKeys;


/**
 返回本地没有的图片资源, 以供下载
 
 @param keys 需要下载的文件对应的key
 @param userId 图片存放的目录/文件夹
 @param isSync 是否需要同步删除本地照片
 @return 返回本地没有需要下载的keys
 */
+ (NSMutableArray *)filterImageKeysBySuffixKeys:(NSArray *)keys
                                     withUserId:(NSString*)userId
                                   isSync:(BOOL)isSync;

@end
