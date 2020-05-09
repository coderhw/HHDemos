
//
//  TTStudent.m
//  TTProject
//
//  Created by Evan on 16/9/22.
//  Copyright © 2016年 Evan. All rights reserved.
//

#import "TTStudent.h"

@implementation TTStudent

//模型属性名字和json数据key不一致, 通过此方法来映射或者多级映射

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id",
             @"desc" : @"desciption",
             @"oldName" : @"name.oldName",
             @"nowName" : @"name.newName",
             @"nameChangedTime" : @"name.info[1].nameChangedTime",
             @"bag" : @"other.bag"
             };
}

@end
