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
#pragma mark - create methods
+ (JRRefreshHeader *)headerWithRefreshBlock:(JRRefreshHeaderBegainRefreshBlock )refreshBlock {
    
    JRRefreshHeader *header = [[JRRefreshHeader alloc] init];
    header.begainRefreshBlock = refreshBlock;

    
    return header;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self FinishBlocks];
        _defaulIndicatorTop = 10;
        _starRefreshDistance = 60.0;
        _isLoading = NO;
        self.state = JRRefreshStateDefault;
    }
    return self;
}


- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

#pragma mark - Scroll Manager
- (void)FinishBlocks {
    
    __weak typeof(self) weakSelf = self;
    
    [self.observersManager setScrollViewContentOffsetChangeBlock:^(NSDictionary *change,UIScrollView *scrollView) {
        [weakSelf scrollViewContentOffsetChange:change scrollView:scrollView];
    }];
}

- (void)scrollViewContentOffsetChange:(NSDictionary *)change scrollView:(UIScrollView *)scrollView {
        
    self.originalInset = scrollView.contentInset;
    CGFloat offSetY = scrollView.contentOffset.y;
    CGFloat happenOffSetY = - self.originalInset.top; //offSetY初始值不一定为0，需与happenOffSetY结合使用
    self.jr_top = offSetY - happenOffSetY;
    
    NSArray *subViews = scrollView.subviews;
    if (subViews.lastObject != self) {
        [scrollView bringSubviewToFront:self];
    }
    
    if (self.state == JRRefreshStateRefreshing) {
        return;
    }

    
    if (offSetY > happenOffSetY) {
        _JRRefreshHeaderPullingBlock(0.0);
        return;
    }
    
    //下拉百分比
    self.pullPercent = (happenOffSetY-offSetY)/_starRefreshDistance;
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
            if (self.state != JRRefreshStateWillRefreshPulling) {
                self.state = JRRefreshStateWillRefreshPulling;
            }
        }
    }else {
        if (self.pullPercent >= 1) {
            if (self.state == JRRefreshStateWillRefreshPulling) {
                self.state = JRRefreshStateRefreshing;
                [self refresh];
            }
        }
    }
}


#pragma mark - Action

- (void)stopRefresh {
    if (self.state != JRRefreshStateDefault) {
        self.state = JRRefreshStateDefault;
    }
    if (_stopAnimationBlock) {
        _stopAnimationBlock();
    }
    _isLoading = NO;
}

- (void)refresh {
    if (self.state != JRRefreshStateRefreshing) {
        self.state = JRRefreshStateRefreshing;
    }
    if (_begainRefreshBlock) {
        _begainRefreshBlock();
    }
    if (_starAnimationBlock) {
        _starAnimationBlock();
    }
    _isLoading = YES;
    [self.observersManager.scrollView bringSubviewToFront:self];
 
}

#pragma mark - Setter

- (void)setIndicatorView:(UIView *)indicatorView {
    _indicatorView = indicatorView;
    [self addSubview:_indicatorView];
    
}
@end
