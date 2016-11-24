//
//  JRRefreshObseversManager.m
//  joyRunner
//
//  Created by AlanWang on 16/11/15.
//  Copyright © 2016年 Joyrun. All rights reserved.
//

#import "JRRefreshObseversManager.h"
#import "JRRefreshConfig.h"
#import "UIView+JRAddition.h"


@implementation JRRefreshObseversManager


#pragma mark Observers
- (void)willAddSubview:(UIView *)subView toSuperView:(UIView *)superView {
    self.subView = subView;
    self.scrollView = (UIScrollView *)superView;
    
    self.subView.jr_width = superView.jr_width;
    self.subView.jr_left = 0;
    _scrollView.alwaysBounceVertical = YES;
    [self addObservers];
    
}
- (void)addObservers {
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:JRREFRESH_CONTENTOFFSET options:options context:nil];
    [self.scrollView addObserver:self forKeyPath:JRREFRESH_CONTENTSIZE options:options context:nil];
    self.panGesture = self.scrollView.panGestureRecognizer;
    [self.panGesture addObserver:self forKeyPath:JRREFRESH_GESTURESTATE options:options context:nil];
}

- (void)removeObservers {
    [self.scrollView removeObserver:self forKeyPath:JRREFRESH_CONTENTOFFSET];
    [self.scrollView removeObserver:self forKeyPath:JRREFRESH_CONTENTSIZE];;
    [self.panGesture removeObserver:self forKeyPath:JRREFRESH_GESTURESTATE];
    self.panGesture = nil;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if (!self.subView.userInteractionEnabled) {
        return;
    }
    
    if ([keyPath isEqualToString:JRREFRESH_CONTENTSIZE]) {
        if (_ScrollViewContentSizeChangeBlock) {
            _ScrollViewContentSizeChangeBlock(change,self.scrollView);
        }
    }
    
    if (self.subView.hidden) {
        return;
    }
    
    if ([keyPath isEqualToString:JRREFRESH_CONTENTOFFSET]) {
        if (_ScrollViewContentOffsetChangeBlock) {
            _ScrollViewContentOffsetChangeBlock(change,self.scrollView);
        }
    }
    
    if ([keyPath isEqualToString:JRREFRESH_GESTURESTATE]) {
        if (_ScrollViewGestureStateChangeBlock) {
            _ScrollViewGestureStateChangeBlock(change,self.scrollView);
        }
    }
    
}




@end
