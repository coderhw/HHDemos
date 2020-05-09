//
//  HHPlayerViewController.m
//  VKDemoProject
//
//  Created by XXXXX on 2018/4/9.
//  Copyright © 2018年 Evan. All rights reserved.
//

#import "HHPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface HHPlayerViewController ()

@end

@implementation HHPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.捕捉会话
    //AVFoundation捕捉栈的核心类是AVCaptureSession. 一个捕捉会话相当于一个虚拟的‘插线板’ 用于连接输入和输出的资源
    //捕捉会话管理从屋里设备得到的数据流，比如摄像图和麦克风设备，输出到一个或多个目的地。可以动态配置输入和输出的线路
    //让开发者能够在会话进行中按需重新配置捕捉环境
    //捕捉会话还可以额外配置一个会话预设值(session preset)用来控制捕捉数据的格式和质量、 会话预设值为AVCaptureSessionPresetHigh.
    
    //2.捕捉设备
    //请求一个默认的视频设备，在包含前置摄像头的iOS系统下返回的是后置摄像头. 在mac上返回的是FaceTime摄像头
//    AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //3.捕捉设备的输入
    //不过一个捕捉设备不能直接添加到AVCaptureSession中，可以通过将它封装在一个AVCaptureDeviceInput实例中
    //这个对象在设备输出数据和捕捉会话间扮演的接线板的作用

//    NSError *error = nil;
//    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
//    if(error){
//        NSLog(@"error:%@", error);
//    }
    
    //4.捕捉的输出
    //AVCaptureOutput AVCaptureOutput是一个抽象的基类，用于为捕捉会话得到的数据寻找输出的目的地。
    //框架定义了一些基于AVCaptureOutput的子类，eg:AVCaptureStillImageOutput和AVCaptureMovieFileOutput
    //基于AVCaptureStillImageOutput和AVCaptureMovieFileOutput可以很容易的实现捕捉照片和视频的功能
    //AVCaptureAudioDataOutput和AVCaptureVideoDataOutput使用他们可以直接访问硬件的数字样本
    
    //5.捕捉连接
    //AVCaptureConnection类
    //捕捉会话首先需要确定由给定捕捉设备输入渲染的媒体类型，并自动建立其到能够接收该媒体类型的捕捉输出端的连接。
    //AVCaptureMovieFileOutput可以接受音频和视频数据，所以会话会确定那些输入产生视频，那些输入产生音频，并正确地建议该链接
    //对这些连接的访问可以让开发者对信号流进行底层的控制，比如禁用某些特定的连接，或者再音频连接中访问单独的音频轨道。
    
    
    //6.捕捉预览
    //系统框架定义了AVCaptureVideoPreviewLayer类来满足该需求，预览层是一个core animation的Calyer子类
    //对捕捉视频数据进行实时的预览。这个类扮演的角色类似于AVPayerLayer, 不过它针对摄像头捕捉的需求进行了定制。
    //类似于AVPlayer一样，AVCaptureVideoPreviewLayer也支持视频重力的概念，可以控制视频内容渲染的缩放和拉伸效果
    
    
    //Demo
    //1.创建capture session
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    
    //2.获取默认的设备
    AVCaptureDevice *camperaDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //3.创建设备的输入
    NSError *err = nil;
    AVCaptureDeviceInput *cameraInput = [AVCaptureDeviceInput deviceInputWithDevice:camperaDevice error:&err];
    
    //4.将input和seesion连接起来
    if([session canAddInput:cameraInput]){
        [session addInput:cameraInput];
    }
    
    //5.创建AVCaptureOutput 用来输出still Images
    AVCaptureStillImageOutput *imageOutput = [[AVCaptureStillImageOutput alloc] init];
    
    //6.将outputh和session连接起来
    if([session canAddOutput:imageOutput]){
        [session addOutput:imageOutput];
    }
    
    //
    [session startRunning];
    
}



@end
