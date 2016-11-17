//
//  UIScrollView+JRFRefresh.h
//  joyRunner
//
//  Created by AlanWang on 16/11/15.
//  Copyright © 2016年 Joyrun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JRRefreshHeader;


@interface UIScrollView (JRRefresh)

@property (nonatomic,strong) JRRefreshHeader *jr_header;
@property (nonatomic,strong) UIView *jr_footer;


//- (void)scrollPullDownRefresh;
//- (void)noScrollTopRefresh;
//- (void)noScrollCenterRefresh;

@end
