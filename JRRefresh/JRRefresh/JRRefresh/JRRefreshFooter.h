//
//  JRRefreshFooter.h
//  JRRefresh
//
//  Created by AlanWang on 16/11/22.
//  Copyright © 2016年 AlanWang. All rights reserved.
//

#import "JRRefreshBaseView.h"

typedef void(^JRRefreshFooterBegainLoadBlock)(void);

@class JRRefreshActivityIndicator;

@interface JRRefreshFooter : JRRefreshBaseView



@property (nonatomic, copy) JRRefreshFooterBegainLoadBlock begainLoadBlock;
@property (nonatomic, assign) CGFloat pullPercent;
@property (nonatomic, strong) JRRefreshActivityIndicator *customIndicator;
@property (nonatomic, assign) BOOL isHideFooter;

- (void)stopLoading;


@end
