//
//  TTPerson.h
//  TTProject
//
//  Created by Evan on 16/8/6.
//  Copyright © 2016年 Evan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHPerson : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *age;

+ (instancetype)person;


@end
