//
//  JRRefreshHeader.m
//  joyRunner
//
//  Created by AlanWang on 16/11/15.
//  Copyright © 2016年 Joyrun. All rights reserved.
//

#import "JRRefreshHeader.h"
#import "JRRefreshObseversManager.h"
#import "JRRefreshConfig.h"
#import "JRRefreshCircleView.h"


@interface JRRefreshHeader ()
{
    CGFloat _defaulIndicatorTop;
    
}
@property (nonatomic, assign) BOOL isLoading;

@end


@implementation JRRefreshHeader

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self FinishBlocks];
        _defaulIndicatorTop = 10.0;
        
        
    }
    return self;
}
- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    [self.observersManager.scrollView addSubview:self.indicatorView];
}
- (void)FinishBlocks {
    
    
    __weak typeof(self) weakSelf = self;
    
    [self.observersManager setScrollViewContentOffsetChangeBlock:^(NSDictionary *change,UIScrollView *scrollView) {
        [weakSelf scrollViewContentOffsetChange:change scrollView:scrollView];
    }];
    
    [self.observersManager setScrollViewContentSizeChangeBlock:^(NSDictionary *change,UIScrollView *scrollView) {
        [weakSelf scrollViewContentSizeChange:change scrollView:scrollView];
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
    }
    
    self.originalInset = scrollView.contentInset;
    CGFloat offSetY = scrollView.contentOffset.y;
    CGFloat happenOffSetY = - self.originalInset.top; //offSetY初始值不一定为0，需与happenOffSetY结合使用
    
    if (offSetY > happenOffSetY) {
        return;
    }
    
    //下拉百分比
    self.pullPercent = (happenOffSetY-offSetY)/self.jr_height;
    if (self.pullPercent < 0) {
        self.pullPercent = 0.0;
    }
    if (self.pullPercent > 1) {
        self.pullPercent = 1.0;
    }
    
    if (!_isLoading) {
        if (_JRRefreshHeaderPullingBlock) {
            _JRRefreshHeaderPullingBlock(self.pullPercent);
        }
    }
    
    
    
    //状态切换
    if (scrollView.isDragging) {
        if (self.pullPercent >= 1) { //超过
            self.state = JRRefreshStateWillRefreshPulling;
        }
    }else {
        if (self.pullPercent >= 1) {
            if (self.state == JRRefreshStateWillRefreshPulling) {
                self.state = JRRefreshStateRefreshing;
            }
        }
    }
    [self switchByState:self.state];
    
    
    //指示器
    self.indicatorView.jr_top =  offSetY - happenOffSetY + _defaulIndicatorTop;
    
    [self.indicatorView setProgress:self.pullPercent scrollView:scrollView];
    JR_DebugLog(@"offset --: %f  happenOffsety-- :%f",offSetY,happenOffSetY);
}

- (void)scrollViewContentSizeChange:(NSDictionary *)change scrollView:(UIScrollView *)scrollView {

}

- (void)scrollViewGestureStateChange:(NSDictionary *)change scrollView:(UIScrollView *)scrollView {
    
}

- (void)switchByState:(JRRefreshState)state {

    if (_isLoading) {
        return;
    }
    switch (state) {
        case JRRefreshStateDefault:
            break;
        case JRRefreshStateWillRefreshPulling:
            break;
        case JRRefreshStateNotRefreshPulling:
            break;
        case JRRefreshStateRefreshing:{
            [_indicatorView startLoadingAnimation];
            _isLoading = YES;
        }
            break;
        case JRRefreshStateWillRefresh:
            break;
        case JRRefreshStateNoMoreData:
            break;
        default:
            break;
    }
    
}

- (void)setIndicatorTopDistance:(CGFloat)distance {
    _defaulIndicatorTop = distance;
    
}

- (JRRefreshCircleView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView =  [[JRRefreshCircleView alloc] initWithCenter:CGPointMake(self.observersManager.scrollView.jr_centerX, 0)];
    }
    return _indicatorView;
}
@end
