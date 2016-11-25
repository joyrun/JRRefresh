//
//  UIScrollView+JRFRefresh.h
//  joyRunner
//
//  Created by AlanWang on 16/11/15.
//  Copyright © 2016年 Joyrun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRRefreshHeader.h"
#import "JRRefreshFooter.h"

@class JRRefreshActivityIndicator;



@interface UIScrollView (JRRefresh)

@property (nonatomic,strong) JRRefreshHeader *jr_header;
@property (nonatomic,strong) JRRefreshFooter *jr_footer;


- (void)jr_addHeaderWithRefreshBlock:(void(^)(void))refreshBlock;
- (void)jr_addFooterWithRefreshBlock:(void(^)(void))refreshBlock;

- (void)jr_headerRefresh;
- (void)jr_headerStopRefresh;

- (void)jr_footerStarLoad;
- (void)jr_footerStopLoad;

- (void)jr_removeFooter;
- (void)jr_showFooter;

- (JRRefreshCircleView *)jr_headerDefaultIndicatorView; /**获取header的默认指示器，进行icon图片，颜色,frame等的修改*/
- (JRRefreshActivityIndicator *)jr_footerDefaultIndicator; /**获取footer的默认指示器，进行图片，frame等的修改*/


@end
