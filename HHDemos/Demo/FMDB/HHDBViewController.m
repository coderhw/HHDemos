//
//  HHDBViewController.m
//  VKDemoProject
//
//  Created by XXXXX on 2018/5/7.
//  Copyright © 2018年 Evan. All rights reserved.
//

#import "HHDBViewController.h"
#import "HHBookModel.h"
#import "HHDatabase.h"

@interface HHDBViewController (){
    HHDatabase *_dataBase;
    FMDatabaseQueue *_queue;
}


@end

@implementation HHDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"homePath:%@", NSHomeDirectory());

    self.title = NSLocalizedString(@"FMDB", nil);
    
    _dataBase = [HHDatabase sharedDataBase];

    BOOL result=[_dataBase.db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_book (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, price text NOT NULL, content text NOT NULL);"];
    if(result){
        NSLog(@"create table success");
    }
    
}

//- (void)creatDBFile {
//    NSLog(@"homePath:%@", NSHomeDirectory());
//
//    NSString *docuPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//    NSString *dbPath = [docuPath stringByAppendingPathComponent:@"test.db"];
//    NSLog(@"!!!dbPath = %@",dbPath);
//    //2.创建对应路径下数据库
//    db = [FMDatabase databaseWithPath:dbPath];
//    //3.在数据库中进行增删改查操作时，需要判断数据库是否open，如果open失败，可能是权限或者资源不足，数据库操作完成通常使用close关闭数据库
//    [db open];
//    if (![db open]) {
//        NSLog(@"db open fail");
//        return;
//    }
//
//    /*
//     @property (nonatomic, copy) NSString *name;
//     @property (nonatomic, copy) NSString *price;
//     @property (nonatomic, copy) NSString *author;
//     */
//
//    //4.数据库中创建表（可创建多张）
//    NSString *sql = @"create table if not exists t_book ('ID' INTEGER PRIMARY KEY AUTOINCREMENT,'name' TEXT NOT NULL, 'price' TEXT NOT NULL,'author' TEXT NOT NULL)";
//    //5.执行更新操作 此处database直接操作，不考虑多线程问题，多线程问题，用FMDatabaseQueue 每次数据库操作之后都会返回bool数值，YES，表示success，NO，表示fail,可以通过 @see lastError @see lastErrorCode @see lastErrorMessage
//    BOOL result = [db executeUpdate:sql];
//    if (result) {
//        NSLog(@"create table success");
//
//    }
//    [db close];
//
//}

- (IBAction)add:(id)sender {
    [_dataBase.db open];

    for(int i = 0; i < 20; i++){

        NSString *name = [NSString stringWithFormat:@"红楼梦-%d", i];
        [_dataBase.db executeUpdate:@"INSERT INTO t_book (name, price, content) VALUES (?, ?, ?);",
         name,
         @(arc4random_uniform(40)),
         @"《紅樓夢》，中國古典長篇章回小說，是中國四大小說名著之一" ];
//        [_dataBase.db executeUpdate:@"INSERT INTO person(person_id,person_name,person_age,person_number)VALUES(?,?,?,?)",maxID,person.name,@(person.age),@(person.number)];
    }
    [_dataBase.db close];

}

- (IBAction)delete:(id)sender {
    
    [_dataBase.db open];

//    [_dataBase.db executeUpdate:@"DELETE FROM t_book WHERE name = ?", "红楼梦-1"]; 此处不能携程""
    [_dataBase.db executeUpdate:@"DELETE FROM t_book WHERE name = ?", @"红楼梦-1"];
    [_dataBase.db close];

}

- (IBAction)query:(id)sender {
    [_dataBase.db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    FMResultSet *res = [_dataBase.db executeQuery:@"SELECT * FROM t_book"];
    while ([res next]) {
        HHBookModel *book = [[HHBookModel alloc] init];
        book.name = [res stringForColumn:@"name"];
        book.price = [res stringForColumn:@"price"];
        book.content = [res stringForColumn:@"content"];
        
        [dataArray addObject:book];
    }
    [_dataBase.db close];
    NSLog(@"dataArray:%@", dataArray);
}

- (IBAction)modify:(id)sender {
    
    [_dataBase.db open];
    //将price价格==12.0的book的那么更新为三国演义
    [_dataBase.db executeUpdate:@"UPDATE 't_book' SET name = ?  WHERE price = ? ", @"三国演义", @"12.0"];
    [_dataBase.db close];
    
}

- (IBAction)deleteTable:(id)sender {
    [_dataBase.db open];
    NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE %@", @"t_book"];
    if (![_dataBase.db executeUpdate:sqlstr]) {
        NSLog(@"Delete table error!");
    }
}

- (IBAction)clearTable:(id)sender {
    [_dataBase.db open];
    NSString *sqlstr = [NSString stringWithFormat:@"DELETE FROM %@", @"t_book"];
    if (![_dataBase.db executeUpdate:sqlstr]) {
        NSLog(@"Erase table error!");
    }
}

- (IBAction)insertDataWithQueue:(id)sender {
    
    [_dataBase.queue inDatabase:^(FMDatabase *db) {
        for (int index = 0; index < 50; index++) {
            NSString *s_name=[NSString stringWithFormat:@"Andy%d", index];
            NSString *s_content= [NSString stringWithFormat:@"水浒传%d", index];
            NSNumber *s_price=@(index);
            [db executeUpdate:@"INSERT INTO t_book(name,price,content) VALUES(?,?,?)",s_name,s_price,s_content];
        }
    }];
    
}

- (IBAction)insertDataWithOutTransction:(id)sender {
    
    CFAbsoluteTime beginTime = CFDateGetAbsoluteTime((CFDateRef)[NSDate date]);
    [self insertDatawithTransaction:NO];
    CFAbsoluteTime endTime = CFDateGetAbsoluteTime((CFDateRef)[NSDate date]);
    NSLog(@"未开启事务操作-->耗时:%f", endTime-beginTime);
}


- (IBAction)insertWithTransaction:(id)sender {
   
    //way 1
//    [_dataBase.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
//        for (int i = 0; i < 10000; i++) {
//
//            NSString *s_name=[NSString stringWithFormat:@"Andy%d", i];
//            NSString *s_content= [NSString stringWithFormat:@"水浒传%d", i];
//            NSNumber *s_price=@(i);
//            NSString *sql = @"INSERT INTO t_book(name,price,content) VALUES(?,?,?)";
//            BOOL a = [db executeUpdate:sql,s_name,s_price,s_content];
//            if (!a) {
//                *rollback = YES;
//                return;
//            }
//        }
//    }];
    
    //way 2
    CFAbsoluteTime beginTime = CFDateGetAbsoluteTime((CFDateRef)[NSDate date]);
    [self insertDatawithTransaction:YES];
    CFAbsoluteTime endTime = CFDateGetAbsoluteTime((CFDateRef)[NSDate date]);
    NSLog(@"开启事务操作-->耗时:%f", endTime-beginTime);

}

- (void)insertDatawithTransaction:(BOOL)isTransaction {
    //所有任务执行完成后再将结果一次性提交到数据库。

    BOOL isOpen = [_dataBase.db open];
    if (isOpen) {
        if (isTransaction) {
            //NSLog(@"**********开始事务操作*************");
            [_dataBase.db shouldCacheStatements]; // 开启缓存
            [_dataBase.db beginTransaction]; // 事务操作
            BOOL isRollBack = NO;
            @try {
                [self performInsert];
            }
            @catch (NSException *exception) {
                isRollBack = YES;
                [_dataBase.db rollback]; // 回滚
            }
            @finally {
                if (!isRollBack) {
                    [_dataBase.db commit];
                }
            }
        }else {
            [self performInsert];
        }
        [_dataBase.db close];
    }
    
}

- (void)performInsert {
    
    NSMutableArray *books = [NSMutableArray array];
    
    for (int index = 0; index < 1000; index++) {
        
        HHBookModel *bookModel = [[HHBookModel alloc] init];
        NSString *s_name=[NSString stringWithFormat:@"水浒传%d", index];
        NSString *s_content= [NSString stringWithFormat:@"水浒传第一张%d", index];
        NSNumber *s_price=@(index);
        bookModel.name = s_name;
        bookModel.content = s_content;
        bookModel.price = [s_price stringValue];
        [books addObject:bookModel];
    }
    
//    BOOL isInsert = NO;
    for (HHBookModel *bookModel in books) {
        [_dataBase.db executeUpdate:@"INSERT INTO t_book (name, price, content) VALUES (?, ?, ?);",
         bookModel.name, bookModel.price, bookModel.content];
        //NSLog(@"%@",isInsert ? @"插入成功":@"插入失败");
    }
}





@end
