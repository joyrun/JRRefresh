//
//  JRRefreshConfig.h
//  joyRunner
//
//  Created by AlanWang on 16/11/15.
//  Copyright © 2016年 Joyrun. All rights reserved.
//

#ifndef JRRefreshConfig_h
#define JRRefreshConfig_h


#define JRREFRESH_CONTENTOFFSET @"contentOffset"
#define JRREFRESH_CONTENTSIZE @"contentSize"
#define JRREFRESH_CONTENTINSET @"contentInset"
#define JRREFRESH_GESTURESTATE @"state"

CGFloat const jr_defaultRefreshHeaderHeight = 40.0;

/** 刷新控件的状态 */
typedef NS_ENUM(NSInteger, JRRefreshState) {
    /** 普通闲置状态 */
    JRRefreshStateDefault = 1,
    /** 松开就可以进行刷新的状态 */
    JRRefreshStatePulling,
    /** 正在刷新中的状态 */
    JRRefreshStateRefreshing,
    
    JRRefreshStateNoOffsetRefreshing,
    
    /** 即将刷新的状态 */
    JRRefreshStateWillRefresh,
    /** 所有数据加载完毕，没有更多的数据了 */
    JRRefreshStateNoMoreData
};

#endif /* JRRefreshConfig_h */
