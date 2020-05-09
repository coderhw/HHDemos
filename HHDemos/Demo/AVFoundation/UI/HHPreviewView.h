//
//  HHPreviewView.h
//  VKDemoProject
//
//  Created by XXXXX on 2018/4/10.
//  Copyright © 2018年 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol HHPreviewViewDelegate <NSObject>

- (void)tappedToFocusAtPoint:(CGPoint)point;

- (void)tappedToExpostAtPoint:(CGPoint)point;

- (void)tappedToResetFocusAndExposure;

@end

@interface HHPreviewView : UIView

@property (nonatomic, strong) AVCaptureSession *session;

@property (nonatomic, weak) id <HHPreviewViewDelegate> delegate;

@property (nonatomic) BOOL tapToFocusEnabled;

@property (nonatomic) BOOL tapToExposeEnable;


@end
