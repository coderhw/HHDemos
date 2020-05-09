//
//  TTStudent.h
//  TTProject
//
//  Created by Evan on 16/9/22.
//  Copyright © 2016年 Evan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TTBag;

@interface TTStudent : NSObject
@property (copy, nonatomic) NSString *ID;
@property (copy, nonatomic) NSString *desc;
@property (copy, nonatomic) NSString *nowName;
@property (copy, nonatomic) NSString *oldName;
@property (copy, nonatomic) NSString *nameChangedTime;
@property (strong, nonatomic) TTBag *bag;

@end
