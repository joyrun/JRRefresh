//
//  UIScrollView+JRFRefresh.m
//  joyRunner
//
//  Created by AlanWang on 16/11/15.
//  Copyright © 2016年 Joyrun. All rights reserved.
//

#import "UIScrollView+JRRefresh.h"
#import "JRRefreshHeader.h"
#import "JRRefreshCircleView.h"
#import "JRRefreshFooter.h"
#import <objc/runtime.h>
#import "JRRefreshActivityIndicator.h"

#define RefreshFooterViewDefaultHeight  65.0


static NSString *kJr_headerKey = @"kJr_headerKey";
static NSString *kJr_footerKey = @"kJr_footerKey";

@implementation UIScrollView (JRRefresh)
#pragma mark - Hook

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        

        Method m1 = class_getInstanceMethod([self class], @selector(didAddSubview:));
        Method m2 = class_getInstanceMethod([self class], @selector(jr_didAddSubview:));
        
        BOOL isSuccess = class_addMethod([self class], @selector(didAddSubview:), method_getImplementation(m2), method_getTypeEncoding(m2));
        if (isSuccess) {
            // 添加成功：说明源方法m1现在的实现为交换方法m2的实现，现在将源方法m1的实现替换到交换方法m2中
            
            class_replaceMethod([self class], @selector(jr_didAddSubview:), method_getImplementation(m1), method_getTypeEncoding(m1));
        }else {
            //添加失败：说明源方法已经有实现，直接将两个方法的实现交换即
            method_exchangeImplementations(m1, m2);
        }
        
    });
    
}
- (void)jr_didAddSubview:(UIView *)subview {

    [self jr_didAddSubview:subview];
    if (self.jr_header || self.jr_footer) {
        [self jr_customMethod];
    }

}

- (void)jr_customMethod {
 
    if (self.jr_header) {
        [self bringSubviewToFront:self.jr_header];
    }
    if (self.jr_footer) {
        [self bringSubviewToFront:self.jr_footer];
    }
    
}
#pragma mark - Properties
- (void)setJr_header:(JRRefreshHeader *)jr_header {
    
    if (jr_header != self.jr_header) {
        [self.jr_header removeFromSuperview];
        [self addSubview:jr_header];
        objc_setAssociatedObject(self, &kJr_headerKey, jr_header, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
}
- (JRRefreshHeader *)jr_header {
    return objc_getAssociatedObject(self, &kJr_headerKey);
}

- (void)setJr_footer:(UIView *)jr_footer {
    if (jr_footer != self.jr_footer) {
        [self.jr_footer removeFromSuperview];
        [self insertSubview:jr_footer atIndex:0];
        objc_setAssociatedObject(self, &kJr_footerKey, jr_footer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        if (self.jr_footer.jr_height <= 0   ) {
            self.jr_footer.jr_height = RefreshFooterViewDefaultHeight;
        }
        self.jr_footer.frame = CGRectMake(0, self.contentSize.height, self.jr_width, self.jr_footer.jr_height);
    }
}
- (UIView *)jr_footer {
    return objc_getAssociatedObject(self, &kJr_footerKey);
}


#pragma mark - Add header and footer
- (void)jr_addHeaderWithRefreshBlock:(void(^)(void))refreshBlock {
    
    JRRefreshHeader *header = [JRRefreshHeader headerWithRefreshBlock:refreshBlock];
    self.jr_header = header;
    
    JRRefreshCircleView *circleView = [[JRRefreshCircleView alloc] initWithCenter:CGPointMake(header.jr_centerX, 20)];
    circleView.autoresizingMask = UIViewAutoresizingFlexibleLeftAndRightMargin;
    
    header.starAnimationBlock = ^() {
        [circleView startLoadingAnimation];
    };
    header.stopAnimationBlock = ^() {
        [circleView stopLoadingAnimation];
    };
    header.JRRefreshHeaderPullingBlock = ^(CGFloat percent) {
        [circleView setIndicatorProgress:percent];
    };
    [circleView showRoundCornerBG:YES];
    header.indicatorView = circleView;
    
}

- (void)jr_addFooterWithRefreshBlock:(void(^)(void))refreshBlock {
    
    JRRefreshFooter *footer = [JRRefreshFooter footerWithLoadBlock:refreshBlock];
    self.jr_footer = footer;
    JRRefreshActivityIndicator *indicator = [[JRRefreshActivityIndicator alloc] initWithCenter:CGPointMake(self.jr_width / 2, 30)];
    indicator.autoresizingMask = UIViewAutoresizingFlexibleLeftAndRightMargin;
    footer.customIndicator = indicator;
    footer.starAnimationBlock = ^(){
        [indicator startAnimating];
    };
    footer.stopAnimationBlock = ^(){
        [indicator stopAnimating];
    };
    
}


#pragma mark - Action
- (void)jr_headerRefresh {
    [self.jr_header refresh];
}
- (void)jr_headerRefreshWithoutAnimation {
    if (self.jr_header.begainRefreshBlock) {
        self.jr_header.begainRefreshBlock();
    }
}
- (void)jr_headerStopRefresh {
    [self.jr_header stopRefresh];
}
- (void)jr_footerStarLoad {
    [self.jr_footer starLoading];
}
- (void)jr_footerStopLoad {
    [self.jr_footer stopLoading];
}
- (void)jr_removeFooter {
    self.jr_footer.manualHideFooter = YES;
}
- (void)jr_showFooter {
    self.jr_footer.manualHideFooter= NO;
}

- (void)jr_setFooterPreLoadOffset:(CGFloat)offset {
    self.jr_footer.preLoadOffset = offset;
}

#pragma mark - Get indicator
- (JRRefreshCircleView *)jr_headerDefaultIndicatorView {
    if ([self.jr_header.indicatorView isKindOfClass:[JRRefreshCircleView class]]) {
        return (JRRefreshCircleView *)self.jr_header.indicatorView;
    }
    return nil;
}

- (JRRefreshActivityIndicator *)jr_footerDefaultIndicator {
    if ([self.jr_footer.customIndicator isKindOfClass:[JRRefreshActivityIndicator class]]) {
        return (JRRefreshActivityIndicator *)self.jr_footer.customIndicator;
    }
    return nil;
}

@end
