//
//  JRRefreshFooter.m
//  JRRefresh
//
//  Created by AlanWang on 16/11/22.
//  Copyright © 2016年 AlanWang. All rights reserved.
//

#import "JRRefreshFooter.h"
#import "JRRefreshObseversManager.h"
#import "JRRefreshActivityIndicator.h"
#import "JRRefreshConfig.h"

#define BOTTOM_LOAD_MORE_OFFSET -100.0f

@interface JRRefreshFooter ()

@property (nonatomic, strong) JRRefreshActivityIndicator *defaultIndicator;
@property (nonatomic, assign) BOOL isLoading;

@end

@implementation JRRefreshFooter



- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self FinishBlocks];
        [self addSubview:self.defaultIndicator];
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
        [weakSelf scrollViewContentSizeChange:change scrollView:scrollView];
    }];
    
    [self.observersManager setScrollViewGestureStateChangeBlock:^(NSDictionary *change,UIScrollView *scrollView) {
        [weakSelf scrollViewGestureStateChange:change scrollView:scrollView];
    }];
    
}

- (void)scrollViewContentOffsetChange:(NSDictionary *)change scrollView:(UIScrollView *)scrollView {
    
    if (_isLoading) {
        return;
    }
    if (_isHideFooter) {
        return;
    }
    if (scrollView.contentOffset.y + scrollView.jr_height > BOTTOM_LOAD_MORE_OFFSET + scrollView.contentSize.height) {
        [self starLoading];
        JR_DebugLog(@" --scrollView.contentOffset.y %f",scrollView.contentOffset.y);
    }
}

- (void)scrollViewContentSizeChange:(NSDictionary *)change scrollView:(UIScrollView *)scrollView {
    self.frame = CGRectMake(0, scrollView.contentSize.height, scrollView.jr_width, self.jr_height);
}

- (void)scrollViewGestureStateChange:(NSDictionary *)change scrollView:(UIScrollView *)scrollView {
    
}
- (void)starLoading {

    if (_isLoading) {
        return;
    }
    self.defaultIndicator.hidden = NO;
    [self.defaultIndicator startAnimating];
    _isLoading = YES;

    UIScrollView *scrollView = self.observersManager.scrollView;
    scrollView.contentInset = UIEdgeInsetsMake(scrollView.contentInset.top, scrollView.contentInset.left, scrollView.contentInset.bottom + JR_FOOTER_EXTEND, scrollView.contentInset.right);
}
- (void)stopLoading {
    
    if (!_isLoading) {
        return;
    }
    [self.defaultIndicator stopAnimating];
    self.defaultIndicator.hidden = YES;
    _isLoading = NO;
    
    UIScrollView *scrollView = self.observersManager.scrollView;
    scrollView.contentInset = UIEdgeInsetsMake(scrollView.contentInset.top, scrollView.contentInset.left, scrollView.contentInset.bottom - JR_FOOTER_EXTEND, scrollView.contentInset.right);
}

- (JRRefreshActivityIndicator *)defaultIndicator {
    
    if (!_defaultIndicator) {
        _defaultIndicator = [[JRRefreshActivityIndicator alloc] initWithCenter:CGPointMake(self.jr_width / 2, 30)];
        _defaultIndicator.autoresizingMask = UIViewAutoresizingFlexibleLeftAndRightMargin;
    }
    return _defaultIndicator;
}

- (void)setCustomIndicator:(JRRefreshActivityIndicator *)customIndicator {
    _customIndicator = customIndicator;
    _defaultIndicator = customIndicator;
    
}
- (void)setIsHideFooter:(BOOL)isHideFooter {
    _isHideFooter = isHideFooter;
    self.hidden = isHideFooter;
}


@end
