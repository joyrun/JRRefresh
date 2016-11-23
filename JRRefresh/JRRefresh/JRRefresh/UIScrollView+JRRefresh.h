//
//  UIScrollView+JRFRefresh.h
//  joyRunner
//
//  Created by AlanWang on 16/11/15.
//  Copyright © 2016年 Joyrun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JRRefreshHeader,JRRefreshFooter;


@interface UIScrollView (JRRefresh)

@property (nonatomic,strong) JRRefreshHeader *jr_header;
@property (nonatomic,strong) JRRefreshFooter *jr_footer;


- (void)jr_starRefresh;
- (void)jr_starLoadMore;
- (void)jr_stopLoading;
- (void)jr_hideFooter;
- (void)jr_showFooter;


- (void)jr_setHeaderIndicatorView:(UIView *) indicatorView;
- (UIView *)jr_headerIndicatorView;
- (void)jr_setFooterIndicatorView:(UIView *) indicatorView;
- (UIView *)jr_footerIndicatorView;



- (void)jr_setHeaderIndicatorCircleImage:(UIImage *)image;
- (void)jr_setHeaderIndicatorBgImage:(UIImage *)image;

@end
