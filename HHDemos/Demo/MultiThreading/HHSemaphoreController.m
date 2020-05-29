//
//  TTSemaphoreController.m
//  VKDemoProject
//
//  Created by XXXXX on 2018/2/23.
//  Copyright © 2018年 Evan. All rights reserved.
//

#import "HHSemaphoreController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <AFNetworking.h>

// 信号量
#define HHExtensionSemaphoreCreate(value) \
static dispatch_semaphore_t signalSemaphore; \
static dispatch_once_t onceTokenSemaphore; \
dispatch_once(&onceTokenSemaphore, ^{ \
signalSemaphore = dispatch_semaphore_create(value); \
});

#define HHExtensionSemaphoreWait \
dispatch_semaphore_wait(signalSemaphore, DISPATCH_TIME_FOREVER);

#define HHExtensionSemaphoreSignal \
dispatch_semaphore_signal(signalSemaphore);

@interface HHSemaphoreController ()

@property (weak, nonatomic) IBOutlet UIImageView *testImageVeiw1;
@property (nonatomic, strong) dispatch_semaphore_t mainSemaphore;

@property (nonatomic, assign) dispatch_time_t timeWait;


@end

@implementation HHSemaphoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)testButtonPressed:(id)sender {
    
    [self dispatchSemaphore];
}

//创建一个并发量为10的线程组
/*
 *dispatch_semaphore_create 创建一个semaphore
 *简单的介绍一下这三个函数，第一个函数有一个整形的参数，我们可以理解为信号的总量，
 *dispatch_semaphore_signal是发送一个信号，自然会让信号总量加1，
 *dispatch_semaphore_wait等待信号，当信号总量少于0的时候就会一直等待，否则就可以正常的执行，并让信号总量-1，根据这样的原理，我们便可以快速的创建一个并发控制。
 */
- (void)dispatchSemaphore {
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    for (int i = 0; i < 100; i++) {
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);// -1
        dispatch_group_async(group, queue, ^{
            NSLog(@"%i",i);
            sleep(2);
            dispatch_semaphore_signal(semaphore); //+1
        });
    }
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
}

- (void)downLoadImage {
    
    NSURL *url = [NSURL URLWithString:@"https://cdnzhike.vanke.com/test1/images/item/090d63fa-9a56-aac7-9d29-43a3cf0c4202.jpg"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location,
                                                                                          NSURLResponse * _Nullable response,
                                                                                          NSError * _Nullable error) {
        if(!error){
            [self.testImageVeiw1 sd_setImageWithURL:location];
        }else{
            NSLog(@"error:%@", error.localizedDescription);
        }
    }];
    [task resume];
    
}


- (IBAction)semaphore2Pressed:(id)sender {

    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"模拟任务1开始");
        sleep(3);
        NSLog(@"任务1完成, 并且让信号量+1, 终止阻塞");
        dispatch_semaphore_signal(semaphore); //+1
    });
    
    NSLog(@"准备开始阻塞");
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"模拟任务2开始");
        sleep(1);
        NSLog(@"任务2完成");
    });
}

- (IBAction)semaphoreButton3Pressed:(id)sender {
    
    HHExtensionSemaphoreCreate(1)
    HHExtensionSemaphoreWait
    NSLog(@"semaphoreButton3Pressed");
    HHExtensionSemaphoreSignal
}

- (IBAction)dispatchGroup:(id)sender {
    
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.GCDDemo.queue",DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, concurrentQueue, ^{
        [self downLoadImage];
    });
    dispatch_group_async(group, concurrentQueue, ^{
        [self downLoadImage];
    });
    dispatch_group_notify(group, concurrentQueue, ^{
        NSLog(@"begin task three! %@",[NSThread currentThread]);
    });
}



//利用信号量阻塞进程
- (IBAction)semaphoreAPressed:(id)sender {
    
    //https://www.cnblogs.com/snailhl/p/3906112.html
    self.timeWait = dispatch_time(DISPATCH_TIME_NOW, 5ull*NSEC_PER_SEC);
    int runTime = 1000;
    dispatch_queue_t queue = dispatch_queue_create("com.HH.Queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(self.mainSemaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"runTime:%d", runTime);
        NSLog(@"runTime:%d", runTime);
    });
    
}

- (IBAction)modifySemphoreA:(id)sender {
    dispatch_semaphore_signal(self.mainSemaphore);
}

- (IBAction)semphoreBPressed:(id)sender {
    int runTime = 1000;
    self.timeWait = dispatch_time(DISPATCH_TIME_NOW, 2ull*NSEC_PER_SEC);
    //阻塞2秒
    dispatch_semaphore_wait(self.mainSemaphore, self.timeWait);
    
    NSLog(@"runTime:%d", runTime);
    NSLog(@"runTime:%d", runTime);
}


#pragma mark - Getter Methods
- (dispatch_semaphore_t)mainSemaphore {
    if (!_mainSemaphore) {
        _mainSemaphore = dispatch_semaphore_create(0);
    }
    return _mainSemaphore;
}


@end
