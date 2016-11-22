//
//  JRRefreshHeader.h
//  joyRunner
//
//  Created by AlanWang on 16/11/15.
//  Copyright © 2016年 Joyrun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRRefreshBaseView.h"
@class JRRefreshCircleView;

@interface JRRefreshHeader : JRRefreshBaseView

@property (nonatomic, copy) void(^JRRefreshHeaderPullingBlock)(CGFloat percent);
@property (nonatomic, copy) void(^JRRefreshHeaderEndRefreshCompletionBlock)();
@property (nonatomic, copy) void(^JRRefreshHeaderBegainRefreshCompletionBlock)();
@property (nonatomic, assign) CGFloat pullPercent;

//@property (nonatomic, strong) UIView *defaultView;
//@property (nonatomic, strong) UIView *refreshingView;
//@property (nonatomic, strong) UIView *draggingView;


@property (nonatomic, strong) JRRefreshCircleView *indicatorView;


@end
