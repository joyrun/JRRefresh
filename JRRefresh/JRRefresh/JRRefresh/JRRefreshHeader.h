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

typedef void(^JRRefreshHeaderBegainRefreshBlock)();

typedef void(^JRRefreshHeaderIndicatorStarAnimationBlock)();
typedef void(^JRRefreshHeaderIndicatorStopAnimationBlock)();



@interface JRRefreshHeader : JRRefreshBaseView



@property (nonatomic, copy) void(^JRRefreshHeaderPullingBlock)(CGFloat percent);
@property (nonatomic, copy) void(^JRRefreshHeaderEndRefreshCompletionBlock)();


@property (nonatomic, copy) JRRefreshHeaderBegainRefreshBlock begainRefreshBlock;
@property (nonatomic, copy) JRRefreshHeaderIndicatorStarAnimationBlock starAnimationBlock;
@property (nonatomic, copy) JRRefreshHeaderIndicatorStopAnimationBlock stopAnimationBlock;


@property (nonatomic, assign) CGFloat pullPercent;
@property (nonatomic, strong) UIView *indicatorView;


+ (JRRefreshHeader *)headerWithRefreshBlock:(JRRefreshHeaderBegainRefreshBlock )refreshBlock;

- (void)stopRefresh;
- (void)refresh;



@end
