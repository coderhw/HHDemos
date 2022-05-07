//
//  PANimDrawBoardView.h
//  WDrawing
//
//  Created by xx on 2020/6/19.
//  Copyright © 2020 W.Miga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PABDrawBoardView : UIView

+ (instancetype)drawBoardView;

- (void)showWithView:(UIView *)superView;

@end

NS_ASSUME_NONNULL_END
