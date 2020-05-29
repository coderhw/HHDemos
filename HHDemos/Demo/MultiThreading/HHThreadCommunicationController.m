//
//  HHThreadCommunicationController.m
//  HHDemos
//
//  Created by E on 2020/5/22.
//  Copyright © 2020 Evan. All rights reserved.
//

#import "HHThreadCommunicationController.h"

@interface HHThreadCommunicationController ()

@property (nonatomic, assign) int ticketSurplusCount;
@property (nonatomic, strong) dispatch_semaphore_t semaphoreLock;
@end

@implementation HHThreadCommunicationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleStr = NSLocalizedString(@"线程通信", nil);
}


- (IBAction)communication:(id)sender {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        //异步追加任务 1
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1---%@",[NSThread currentThread]);
        
        //回到主线程
        dispatch_async(mainQueue, ^{
            //追加在主线程中执行的任务
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2---%@",[NSThread currentThread]);
        });
    });
}

- (IBAction)dispatchBarrier:(id)sender {
    
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.HH.Queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrentQueue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1---%@",[NSThread currentThread]);
    });
    
    dispatch_async(concurrentQueue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2---%@",[NSThread currentThread]);
    });
    
    dispatch_barrier_sync(concurrentQueue, ^{
        // 追加任务 barrier
        [NSThread sleepForTimeInterval:2];
        NSLog(@"barrier---%@",[NSThread currentThread]);
        
    });
    
    dispatch_async(concurrentQueue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3---%@",[NSThread currentThread]);
    });
    
    dispatch_async(concurrentQueue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"4---%@",[NSThread currentThread]);
    });
}

- (IBAction)dispatchApply:(id)sender {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSLog(@"dispatchApply---begin");
    dispatch_apply(10, queue, ^(size_t index) {
        NSLog(@"%zd---%@", index, [NSThread currentThread]);
    });
    NSLog(@"dispatchApply---end");
    /*第一个参数为重复次数；
     第二个参数为追加对象的Dispatch Queue；
     第三个参数为追加的操作，追加的Block中带有参数，这是为了按第一个参数重复追加Block并区分各个Block而使用。*/
}

- (IBAction)dispatchGroup:(id)sender {
    
    //分别异步执行2个耗时任务，然后当2个耗时任务都执行完毕后再回到主线程执行任务,这时候我们可以用到GCD的队列组
    /*调用队列组的 dispatch_group_async 先把任务放到队列中，然后将队列放入队列组中。
     或者使用队列组的 dispatch_group_enter、
     dispatch_group_leave 组合来实现 dispatch_group_async。
     调用队列组的 dispatch_group_notify 回到指定线程执行任务。或者使用 dispatch_group_wait 回到当前线程继续向下执行（会阻塞当前线程）*/
    [self fetchAllDataComplete:^(BOOL success) {
        
        NSLog(@"fetchAllDataComplete");
    }];
    
}

// 请求是否全部完成
- (void)fetchAllDataComplete:(void(^)(BOOL success))completed {
    
  dispatch_group_t group = dispatch_group_create();
  dispatch_group_enter(group);
  [self loadADataFinished:^(BOOL success){
    if (success){
      dispatch_group_leave(group);
    }else{
      completed(NO);
    }
  }];
  dispatch_group_enter(group);
  [self loadBDataFinished:^(BOOL success){
    if (success){
      dispatch_group_leave(group);
    }else{
      completed(NO);
    }
  }];

 dispatch_group_wait(group, DISPATCH_TIME_FOREVER);// A,B同时执行, 执行完才会执行下面的 C
 dispatch_group_enter(group);
 [self loadCDataFinished:^(BOOL success){
    if (success){
      dispatch_group_leave(group);
    }else{
      completed(NO);
    }
  }];
 
  //  group 中的任务都成功完成后,才会返回 YES
  dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        completed(YES);
   });
}

// A 请求数据
- (void)loadADataFinished:(void(^)(BOOL success))complete {
    complete(YES);
}

// B 请求数据
- (void)loadBDataFinished:(void(^)(BOOL success))complete {
    complete(YES);
}
// C 请求数据
- (void)loadCDataFinished:(void(^)(BOOL success))complete {
    complete(YES);
}

- (IBAction)groupWait:(id)sender {
    
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"group---begin");
    dispatch_group_t group =  dispatch_group_create();
    //dispatch_queue_t concurrentQueue = dispatch_queue_create("com.HH.Queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t serialQueue = dispatch_queue_create("net.HHH.Queue", DISPATCH_QUEUE_SERIAL);
    dispatch_group_async(group, serialQueue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_group_async(group, serialQueue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    // 等待上面的任务全部完成后，会往下继续执行（会阻塞当前线程）
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"group---end");
    
}

- (IBAction)semaphoreSync:(id)sender {
        NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
        NSLog(@"semaphore---begin");
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        __block int number = 0;
        dispatch_async(queue, ^{
            // 追加任务 1
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
            
            number = 100;
            
            dispatch_semaphore_signal(semaphore);
        });
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"semaphore---end,number = %d",number);
    
}

- (IBAction)semphoreSafeSaleTickets:(id)sender {
    
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
        NSLog(@"semaphore---begin");
        
        _semaphoreLock = dispatch_semaphore_create(1);
        _ticketSurplusCount = 50;
        
        // queue1 代表北京火车票售卖窗口
        dispatch_queue_t queue1 = dispatch_queue_create("net.bujige.testQueue1", DISPATCH_QUEUE_SERIAL);
        // queue2 代表上海火车票售卖窗口
        dispatch_queue_t queue2 = dispatch_queue_create("net.bujige.testQueue2", DISPATCH_QUEUE_SERIAL);
        
        __weak typeof(self) weakSelf = self;
        dispatch_async(queue1, ^{
            [weakSelf saleTicketSafe];
        });
        
        dispatch_async(queue2, ^{
            [weakSelf saleTicketSafe];
        });

}

/**
 * 售卖火车票（线程安全）
 */
- (void)saleTicketSafe {
    while (1) {
        // 相当于加锁
        dispatch_semaphore_wait(_semaphoreLock, DISPATCH_TIME_FOREVER);
        
        if (self.ticketSurplusCount > 0) {  // 如果还有票，继续售卖
            self.ticketSurplusCount--;
            NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%d 窗口：%@", self.ticketSurplusCount, [NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.2];
        } else { // 如果已卖完，关闭售票窗口
            NSLog(@"所有火车票均已售完");
            
            // 相当于解锁
            dispatch_semaphore_signal(_semaphoreLock);
            break;
        }
        
        // 相当于解锁
        dispatch_semaphore_signal(_semaphoreLock);
    }
}





@end
