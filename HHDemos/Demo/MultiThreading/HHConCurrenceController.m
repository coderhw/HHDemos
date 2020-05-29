//
//  HHConCurrenceController.m
//  HHDemos
//
//  Created by 胡文(金服银行科技中心网点赋能开发团队平台组) on 2020/5/22.
//  Copyright © 2020 Evan. All rights reserved.
//

#import "HHConCurrenceController.h"

@interface HHConCurrenceController ()

@end

@implementation HHConCurrenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - 同步执行|异步执行 + 串行队列|并发队列

/// 同步执行 + 并发队列
- (IBAction)syncConcurrenceDemos:(id)sender {
    
    NSLog(@"currentThread:%@", [NSThread currentThread]);
    NSLog(@"syncConcurrenceDemos---begin");
    //init sync concurrent
    dispatch_queue_t syncQueue = dispatch_queue_create("com.HH.syncConcurrenceDemos", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(syncQueue, ^{
        // add task 1
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1---%@",[NSThread currentThread]);
    });
    
    dispatch_sync(syncQueue, ^{
        // add task 2
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2---%@",[NSThread currentThread]);
    });
    
    dispatch_sync(syncQueue, ^{
        // add task 3
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3---%@",[NSThread currentThread]);
    });
    
    NSLog(@"syncConcurrenceDemos---end");
    //consulution: 同步 + 并发队列不会开启新线程，所有任务都是在当前线程（主线程）中执行的，没有开启新的线程（同步执行不具备开启新线程的能力）任务按照顺序执行。
}

//异步执行 + 并发队列
- (IBAction)asyncConcurrenceDemos:(id)sender {
    
    NSLog(@"currentThread:%@", [NSThread currentThread]);
    NSLog(@"asyncConcurrenceDemos---begin");
    //init async concurrent
    dispatch_queue_t asyncQueue = dispatch_queue_create("com.HH.syncConcurrenceDemos", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(asyncQueue, ^{
        // add task 1
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1---%@",[NSThread currentThread]);
    });
    
    dispatch_async(asyncQueue, ^{
        // add task 2
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2---%@",[NSThread currentThread]);
    });
    
    dispatch_async(asyncQueue, ^{
        // add task 3
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3---%@",[NSThread currentThread]);
    });
    
    NSLog(@"asyncConcurrenceDemos---end");
    /*
     2020-05-22 16:29:04.168869+0800 HHDemos[38710:778016] asyncConcurrenceDemos---begin
     2020-05-22 16:29:04.169166+0800 HHDemos[38710:778016] asyncConcurrenceDemos---end
     2020-05-22 16:29:06.174373+0800 HHDemos[38710:778137] 2---<NSThread: 0x600000c14180>{number = 2, name = (null)}
     2020-05-22 16:29:06.174383+0800 HHDemos[38710:778457] 1---<NSThread: 0x600000c88680>{number = 9, name = (null)}
     2020-05-22 16:29:06.174391+0800 HHDemos[38710:778461] 3---<NSThread: 0x600000c80500>{number = 10, name = (null)}
     */
    //（异步执行 具备开启新线程的能力。且 并发队列 可开启多个线程，同时执行多个任务）
    //任务是打印在begin 和 end之后，说明线程没有等待，而是直接开启了新线程，在新线程中执行任务(异步执行，没有等待);
}

//同步执行 + 串行队列
- (IBAction)syncSerialDemos:(id)sender {
    
    NSLog(@"currentThread:%@", [NSThread currentThread]);
    NSLog(@"syncSerialDemos---begin");
    //init sync concurrent
    dispatch_queue_t syncQueue = dispatch_queue_create("com.HH.syncSerialDemos", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(syncQueue, ^{
        // add task 1
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1---%@",[NSThread currentThread]);
    });
    
    dispatch_sync(syncQueue, ^{
        // add task 2
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2---%@",[NSThread currentThread]);
    });
    
    dispatch_sync(syncQueue, ^{
        // add task 3
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3---%@",[NSThread currentThread]);
    });
    
    NSLog(@"syncSerialDemos---end");
    /*
     1.所有任务都是在(当前线程)主队列中执行，并没有开启新的线程（同步执行不具备开启新线程的能力）;
     2.所有的任务都在打印syncSerialDemos---begin  和 syncSerialDemos---end之间，（同步任务需要等待队列的任务执行结束）
     3.所有的任务是按照顺序执行的(串行队列每次只有一个任务被执行，任务一个一个被执行)
     */
}

- (IBAction)asyncSerialDemos:(id)sender {
    
    NSLog(@"currentThread:%@", [NSThread currentThread]);
      NSLog(@"asyncSerialDemos---begin");
      //init sync concurrent
      dispatch_queue_t syncQueue = dispatch_queue_create("com.HH.asyncSerialDemos", DISPATCH_QUEUE_SERIAL);
      
      dispatch_async(syncQueue, ^{
          // add task 1
          [NSThread sleepForTimeInterval:2];
          NSLog(@"1---%@",[NSThread currentThread]);
      });
      
      dispatch_async(syncQueue, ^{
          // add task 2
          [NSThread sleepForTimeInterval:2];
          NSLog(@"2---%@",[NSThread currentThread]);
      });
      
      dispatch_async(syncQueue, ^{
          // add task 3
          [NSThread sleepForTimeInterval:2];
          NSLog(@"3---%@",[NSThread currentThread]);
      });
      
      NSLog(@"asyncSerialDemos---end");
    
   /*
    1.开启了新线程(异步执行具备开启新线程的能力，串行队列只会开启一个线程)
    2.所有任务是在打印的 asyncSerialDemos---begin 和 asyncSerialDemos---end 之后才开始执行的（异步执行 不会做任何等待，可以继续执行任务）
    3.任务是按照顺序执行的（串行队列 每次只有一个任务被执行，任务一个接一个按顺序执行）
    */
    
}

#pragma mark - 同步执行 + 主队列
/**
 * 同步执行 + 主队列
 * 特点(主线程调用)：互等卡主不执行。
 * 特点(其他线程调用)：不会开启新线程，执行完一个任务，再执行下一个任务。
 */

- (IBAction)syncMain:(id)sender {
    
    //主队列执行
    NSLog(@"currentThread---%@",[NSThread currentThread]);
    NSLog(@"syncMain---begin");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_sync(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1---%@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2---%@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3---%@",[NSThread currentThread]);
    });
    
    NSLog(@"syncMain---end");
    /*
     1.主线程中执行 syncMain 方法，相当于把syncMain 任务加入到了主线程的队列中。
     2.而同步执行会等待当前队列中的任务执行完毕，才会接着执行，那么我们把任务1追加到主队列中，任务1就在等待syncMain任务完成。 而syncMain又在等待任务1完成。
     3.因此syncMain和任务1两者相互等待，形成死锁🔐
     */
}


/// 其他线程调用 同步执行+主队列
- (IBAction)subThreadCallSerialMainQueue:(id)sender {
    //其它线程执行
    [NSThread detachNewThreadSelector:@selector(syncMain:) toTarget:self withObject:nil];
    /*
     2020-05-22 17:33:44.192963+0800 HHDemos[41069:828391] syncMain---begin
     2020-05-22 17:33:46.194577+0800 HHDemos[41069:827530] 1---<NSThread: 0x600001010f80>{number = 1, name = main}
     2020-05-22 17:33:48.196293+0800 HHDemos[41069:827530] 2---<NSThread: 0x600001010f80>{number = 1, name = main}
     2020-05-22 17:33:50.198019+0800 HHDemos[41069:827530] 3---<NSThread: 0x600001010f80>{number = 1, name = main}
     2020-05-22 17:33:50.198420+0800 HHDemos[41069:828391] syncMain---end
     1.在其他线程中使用 （同步执行+主队列），没有开启新线程（所有的主队列的任务都会放在主线程中执行）
     2.所有的任务都在 syncMain---begin 和 syncMain---end之间。（同步任务 需要等待队列的任务执行结束）
     3.任务是按照顺序执行的，（主队列是串行队列，每次只有一个任务被执行，任务一个接一个按照顺序执行）
     
     为什么现在就不会卡住了呢？
     1.因为syncMain 任务放到了其它线程中执行，而任务1 任务2 任务3则在主线程中执行，所以两个任务之间没有相互依赖，不会造成死锁🔐，
     2.因为是同步执行，因此会一次执行任务1 任务2 任务3
     */
}

//异步执行 + 主队列 特点:只在主线程中执行任务，执行完一个任务，再执行下一个任务。
- (IBAction)asyncMainDemos:(id)sender {
    
    //主队列执行
    NSLog(@"currentThread---%@", [NSThread currentThread]);
    NSLog(@"asyncMainDemos---begin");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1---%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2---%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3---%@",[NSThread currentThread]);
    });
    
    NSLog(@"asyncMainDemos---end");
    /*
     1.所有任务都是在当前线程（主线程）中执行的，并没有开启新的线程（虽然 异步执行 具备开启线程的能力，但因为是主队列，所以所有任务都在主线程中）
     2.所有任务是在打印的 asyncMainDemos---begin 和 asyncMainDemos---end 之后才开始执行的（异步执行不会做任何等待，可以继续执行任务）
     3.所有任务是在打印的 asyncMainDemos---begin 和 asyncMainDemos---end 之后才开始执行的（异步执行不会做任何等待，可以继续执行任务）
     */
}






@end
