//
//  JRRefreshHeader.m
//  joyRunner
//
//  Created by AlanWang on 16/11/15.
//  Copyright © 2016年 Joyrun. All rights reserved.
//

#import "JRRefreshHeader.h"
#import "JRRefreshObseversManager.h"

@implementation JRRefreshHeader


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self FinishBlocks];
    }
    return self;
}
- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}
- (void)FinishBlocks {
    
    
    __weak typeof(self) weakSelf = self;
    
    [self.observersManager setScrollViewContentOffsetChangeBlock:^(NSDictionary *change,UIScrollView *scrollView) {
        
        [weakSelf scrollViewContentOffsetChange:change scrollView:scrollView];

        
    }];
    
    [self.observersManager setScrollViewContentSizeChangeBlock:^(NSDictionary *change,UIScrollView *scrollView) {
        
        [weakSelf scrollViewGestureStateChange:change scrollView:scrollView];
        
    }];
    
    
    [self.observersManager setScrollViewGestureStateChangeBlock:^(NSDictionary *change,UIScrollView *scrollView) {
        
        [weakSelf scrollViewGestureStateChange:change scrollView:scrollView];
        
    }];
    
}

- (void)scrollViewContentOffsetChange:(NSDictionary *)change scrollView:(UIScrollView *)scrollView {
    
    
    if (self.state == JRRefreshStateRefreshing) {
        
        if (!self.window) {
            return;
        }
        //？？
        CGFloat insetT = scrollView.contentOffset.y > self.originalInset.top ? -scrollView.contentOffset.y : self.originalInset.top;
    }
    
    self.originalInset = scrollView.contentInset;
    CGFloat offSetY = scrollView.contentOffset.y;
    CGFloat happenOffSetY = - self.originalInset.top;
    
    if (offSetY > happenOffSetY) {
        return;
    }
    
    self.pullPercent = offSetY/self.originalInset.top;
    if (_JRRefreshHeaderPullingBlock) {
        _JRRefreshHeaderPullingBlock(self.pullPercent);
    }
}

- (void)scrollViewContentSizeChange:(NSDictionary *)change scrollView:(UIScrollView *)scrollView {
}

- (void)scrollViewGestureStateChange:(NSDictionary *)change scrollView:(UIScrollView *)scrollView {
    
}


- (void)switchState:(JRRefreshState )state {
    
    switch (state) {
        case JRRefreshStateDefault:
            break;
        case JRRefreshStatePulling:
            break;
        case JRRefreshStateRefreshing:
            break;
        case JRRefreshStateWillRefresh:
            break;
        case JRRefreshStateNoMoreData:
            break;
        default:
            break;
    }
    
}

@end
