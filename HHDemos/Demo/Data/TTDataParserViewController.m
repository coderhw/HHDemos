

//
//  TTDataParserViewController.m
//  TTProject
//
//  Created by Evan on 16/9/22.
//  Copyright © 2016年 Evan. All rights reserved.
//

#import "TTDataParserViewController.h"
#import "MJExtension.h"

#import "TTUser.h"
#import "TTPersonModel.h"
#import "TTStatus.h"
#import "TTNewsModel.h"
#import "TTStatusResults.h"
#import "TTStudent.h"
#import "TTAd.h"
#import "TTBag.h"

//test
#import "VKSalesListModel.h"
#import "VKSalesTeamModel.h"
#import "VKSalesModel.h"


@implementation TTDataParserViewController


- (void)viewDidLoad {
   
    self.navigationItem.title = @"数据模型转换";
    
}

//字典转模型
- (IBAction)dictToModel:(id)sender {
    
//    NSDictionary *dict = @{
//                           @"name":@"Jhon",
//                           @"age" :@"25"
//                           };
//    
//    TTPersonModel *personModel = [TTPersonModel mj_objectWithKeyValues:dict];
    
}

//json字符串转模型
- (IBAction)jsonStringToModel:(id)sender {
    
    NSString *jsonString = @"{\"name\":\"Jack\", \"icon\":\"lufy.png\", \"age\":20}";
    TTUser *userModel = [TTUser mj_objectWithKeyValues:jsonString];
    NSLog(@"userModel:%@", userModel);
}

//模型中套模型
- (IBAction)modelContainModel:(id)sender {
    
    //status
//        NSDictionary *dict = @{
//                               @"text" : @"Agree!Nice weather!",
//                               @"user" : @{
//                                       @"name" : @"Jack",
//                                       @"icon" : @"lufy.png"
//                                       },
//                               @"retweetedStatus" : @{
//                                       @"text" : @"Nice weather!",
//                                       @"user" : @{
//                                               @"name" : @"Rose",
//                                               @"icon" : @"nami.png"
//                                               }
//                                       }
//                               };
//    
//    
//        Status *status = [Status mj_objectWithKeyValues:dict];
//    
//        NSString *text = status.text;
//        NSString *name = status.user.name;
//        NSString *icon = status.user.icon;
//        NSLog(@"text=%@\n, name=%@\n, icon=%@\n", text, name, icon);
    
    
    //news
        NSDictionary *dict = @{
                               @"time":@"2016上半年",
                               @"name":@"房价走势",
                               @"houseNews": @{
                                            @"location":@"深圳市",
                                            @"price":@"50 000人民币"
                                       }
                               };
    
        TTNewsModel *newModel = [TTNewsModel mj_objectWithKeyValues:dict];
        NSLog(@"newModel\n time:%@\n name:%@\n location:%@\n price:%@\n",
              newModel.time,
              newModel.name,
              newModel.houseNews.location,
              newModel.houseNews.price);
    
}

//模型中有个数组属性，数组里面又要装着其他模型
- (IBAction)modelContainArray:(id)sender {
    
    // 1.定义一个字典
    NSDictionary *dict = @{
                           @"statuses" : @[
                                               @{
                                                   @"text" : @"今天天气真不错！",
                                                   @"user" : @{
                                                           @"name" : @"Rose",
                                                           @"icon" : @"nami.png"
                                                           }
                                                   },
                                               @{
                                                   @"text" : @"明天去旅游了",
                                                   @"user" : @{
                                                           @"name" : @"Jack",
                                                           @"icon" : @"lufy.png"
                                                           }
                                                   }
                                            ],
                           @"ads" : @[
                                       @{
                                           @"image" : @"ad01.png",
                                           @"url" : @"http://www.小码哥ad01.com"
                                           },
                                       @{
                                           @"image" : @"ad02.png",
                                           @"url" : @"http://www.小码哥ad02.com"
                                           }
                                    ],
                           @"totalNumber" : @"2014",
                           @"previousCursor" : @"13476589",
                           @"nextCursor" : @"13476599"
                           };
    
    // 2.将字典转为MJStatusResult模型
    TTStatusResults *result = [TTStatusResults mj_objectWithKeyValues:dict];
    
    // 3.打印MJStatusResult模型的简单属性
    MJExtensionLog(@"totalNumber=%@, previousCursor=%lld, nextCursor=%lld", result.totalNumber, result.previousCursor, result.nextCursor);
    
    // 4.打印statuses数组中的模型属性
    for (TTStatus *status in result.statuses) {
        NSString *text = status.text;
        NSString *name = status.user.name;
        NSString *icon = status.user.icon;
        NSLog(@"text=%@, name=%@, icon=%@", text, name, icon);
    }
    
    // 5.打印ads数组中的模型属性
    for (TTAd *ad in result.ads) {
        NSLog(@"image=%@, url=%@", ad.image, ad.url);
    }
}

// 模型中的属性名和字典中的key不相同(或者需要多级映射)
- (IBAction)keyReplaceValue:(id)sender {
    
    // 1.定义一个字典
    NSDictionary *dict = @{
                           @"id" : @"20",
                           @"desciption" : @"好孩子",
                           @"name" : @{
                                   @"newName" : @"lufy",
                                   @"oldName" : @"kitty",
                                   @"info" : @[
                                           @"test-data",
                                           @{@"nameChangedTime" : @"2013-08-07"}
                                           ]
                                   },
                           @"other" : @{
                                   @"bag" : @{
                                           @"name" : @"小书包",
                                           @"price" : @100.7
                                           }
                                   }
                           };
    
    // 2.将字典转为MJStudent模型
    TTStudent *stu = [TTStudent mj_objectWithKeyValues:dict];
    NSLog(@"stu:%@\n %@\n %@\n %@\n %@\n %@\n", stu.ID, stu.desc, stu.nowName, stu.oldName, stu.nameChangedTime, stu.bag);
    
}

//将一个字典数组转成模型数组
- (IBAction)dictArray2ModelsArray:(id)sender {
    
    NSArray *dictArray = @[
                           @{
                               @"name" : @"Jack",
                               @"icon" : @"lufy.png"
                               },
                           @{
                               @"name" : @"Rose",
                               @"icon" : @"nami.png"
                               }
                           ];
    
    // JSON array -> User array
    NSArray *userArray = [TTUser mj_objectArrayWithKeyValuesArray:dictArray];
    
    // Printing
    for (TTUser *user in userArray) {
        NSLog(@"name=%@, icon=%@", user.name, user.icon);
    }
    // name=Jack, icon=lufy.png
    // name=Rose, icon=nami.png
}

//将一个模型转成字典
- (IBAction)model2Dict:(id)sender {
    
    // New model
    TTUser *user = [[TTUser alloc] init];
    user.name = @"Jack";
    user.icon = @"lufy.png";
    
    TTStatus *status = [[TTStatus alloc] init];
    status.user = user;
    status.text = @"Nice mood!";
    
    // Status -> JSON
    NSDictionary *statusDict = status.mj_keyValues;
    NSLog(@"%@", statusDict);
    /*
     {
     text = "Nice mood!";
     user =     {
     icon = "lufy.png";
     name = Jack;
     };
     }
     */
    
    // More complex situation
    TTStudent *stu = [[TTStudent alloc] init];
    stu.ID = @"123";
    stu.oldName = @"rose";
    stu.nowName = @"jack";
    stu.desc = @"handsome";
    stu.nameChangedTime = @"2018-09-08";
    
    TTBag *bag = [[TTBag alloc] init];
    bag.name = @"a red bag";
    bag.price = 205;
    stu.bag = bag;
    
    NSDictionary *stuDict = stu.mj_keyValues;
    NSLog(@"%@", stuDict);
    /*
     {
     ID = 123;
     bag =     {
     name = "\U5c0f\U4e66\U5305";
     price = 205;
     };
     desc = handsome;
     nameChangedTime = "2018-09-08";
     nowName = jack;
     oldName = rose;
     }
     */
    
}

//将一个模型数组转成字典数组
- (IBAction)modelsArry2DictsArray:(id)sender {
    // New model array
    TTUser *user1 = [[TTUser alloc] init];
    user1.name = @"Jack";
    user1.icon = @"lufy.png";
    
    TTUser *user2 = [[TTUser alloc] init];
    user2.name = @"Rose";
    user2.icon = @"nami.png";
    
    NSArray *userArray = @[user1, user2];
    
    // Model array -> JSON array
    NSArray *dictArray = [TTUser mj_keyValuesArrayWithObjectArray:userArray];
    NSLog(@"%@", dictArray);
    /*
     (
     {
     icon = "lufy.png";
     name = Jack;
     },
     {
     icon = "nami.png";
     name = Rose;
     }
     )
     */
}

- (void)arrayContainModelArrayAndModel {
    
    
    
}


@end
