//
//  HHPullSelectView.h
//  VKDemoProject
//
//  Created by XXXXX on 2018/3/19.
//  Copyright © 2018年 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HHPullSelectResultBlock)(NSArray * _Nullable selectTitles);

@interface HHPullSelectView : UIView

@property (nonatomic, strong) UIControl *backgroundView;


/**
 initialization

 @param frame frame
 @param selectTitles 选中的Titles
 @return 返回的实例
 */
- (nullable instancetype)initWithFrame:(CGRect)frame
                          selectTitles:(nullable NSArray *)selectTitles;

@property (nonatomic, copy) HHPullSelectResultBlock _Nonnull selectResultBlock;

/**
 * show PullSelectView
 */
- (void)show;

/**
 * dismiss
 */
- (void)dismiss;




@end
