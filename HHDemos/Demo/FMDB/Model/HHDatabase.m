//
//  HHDatabase.m
//  VKDemoProject
//
//  Created by XXXXX on 2018/9/7.
//  Copyright © 2018年 Evan. All rights reserved.
//

#import "HHDatabase.h"


static HHDatabase *_database = nil;

@interface HHDatabase()<NSCopying, NSMutableCopying>{

}
@end

@implementation HHDatabase

+(instancetype)sharedDataBase{
    
    if (_database == nil) {
        
        _database = [[HHDatabase alloc] init];
        [_database initDataBase];
    }
    return _database;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone {
    
    if (_database == nil) {
        _database = [super allocWithZone:zone];
    }
    
    return _database;
    
}

-(id)copy{return self;}

-(id)mutableCopy{return self;}

-(id)copyWithZone:(NSZone *)zone{return self;}

-(id)mutableCopyWithZone:(NSZone *)zone{return self;}

- (void)initDataBase {
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"model.sqlite"];
    self.db = [FMDatabase databaseWithPath:filePath];
    _queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
    [_db open];
}

@end
