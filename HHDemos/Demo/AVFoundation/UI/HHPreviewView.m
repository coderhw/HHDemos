//
//  HHPreviewView.m
//  VKDemoProject
//
//  Created by XXXXX on 2018/4/10.
//  Copyright © 2018年 Evan. All rights reserved.
//

#import "HHPreviewView.h"


@implementation HHPreviewView

+ (Class)layerClass {
    return [AVCaptureVideoPreviewLayer class];
}

- (void)setSession:(AVCaptureSession *)session {
    [(AVCaptureVideoPreviewLayer *)self.layer setSession:session];
}

- (AVCaptureSession *)session {
    return [(AVCaptureVideoPreviewLayer *)self.layer session];
}

- (CGPoint)captureDevicePointForPoint:(CGPoint)point {
    
    AVCaptureVideoPreviewLayer *layer = (AVCaptureVideoPreviewLayer *)self.layer;
    return [layer captureDevicePointOfInterestForPoint:point];
}


@end
