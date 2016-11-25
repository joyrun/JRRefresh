//
//  JRRefreshFooter.h
//  JRRefresh
//
//  Created by AlanWang on 16/11/22.
//  Copyright © 2016年 AlanWang. All rights reserved.
//

#import "JRRefreshBaseView.h"

typedef void(^JRRefreshFooterBegainLoadBlock)(void);
typedef void(^JRRefreshFooterStarAnimationBlock)(void);
typedef void(^JRRefreshFooterStopAnimationBlock)(void);


@interface JRRefreshFooter : JRRefreshBaseView



@property (nonatomic, copy) JRRefreshFooterBegainLoadBlock begainLoadBlock;
@property (nonatomic, copy) JRRefreshFooterStarAnimationBlock starAnimationBlock;
@property (nonatomic, copy) JRRefreshFooterStopAnimationBlock stopAnimationBlock;
@property (nonatomic, strong) UIView *customIndicator;
@property (nonatomic, assign) BOOL isHideFooter;

+ (JRRefreshFooter *)footerWithLoadBlock:(JRRefreshFooterBegainLoadBlock )loadBlock;

- (void)starLoading;
- (void)stopLoading;


@end
