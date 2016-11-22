//
//  JRRefreshFooter.h
//  JRRefresh
//
//  Created by AlanWang on 16/11/22.
//  Copyright © 2016年 AlanWang. All rights reserved.
//

#import "JRRefreshBaseView.h"

@class JRRefreshActivityIndicator;

@interface JRRefreshFooter : JRRefreshBaseView

@property (nonatomic, copy) void(^JRRefreshHeaderPullingBlock)(CGFloat percent);
@property (nonatomic, copy) void(^JRRefreshHeaderEndRefreshCompletionBlock)();
@property (nonatomic, copy) void(^JRRefreshHeaderBegainRefreshCompletionBlock)();

@property (nonatomic, assign) CGFloat pullPercent;
@property (nonatomic, strong) JRRefreshActivityIndicator *customIndicator;

- (void)stopLoading;


@end
