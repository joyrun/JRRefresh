//
//  JRRefreshConfig.h
//  joyRunner
//
//  Created by AlanWang on 16/11/15.
//  Copyright © 2016年 Joyrun. All rights reserved.
//

#ifndef JRRefreshConfig_h
#define JRRefreshConfig_h



#import "UIView+JRAddition.h"


#define JRREFRESH_CONTENTOFFSET @"contentOffset"
#define JRREFRESH_CONTENTSIZE @"contentSize"
#define JRREFRESH_CONTENTINSET @"contentInset"
#define JRREFRESH_GESTURESTATE @"state"


#define JR_DEGREES_TO_RADIANS(x) (x)/180.0*M_PI
#define JR_RADIANS_TO_DEGREES(x) (x)/M_PI*180.0
#define JR_RGBA(R,G,B,A)	[UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define JR_FOOTER_EXTEND 60.0
/** 刷新控件的状态 */
typedef NS_ENUM(NSInteger, JRRefreshState) {
    /** 普通闲置状态 */
    JRRefreshStateDefault = 1,
    /** 松开就可以进行刷新的状态 */
    JRRefreshStateWillRefreshPulling,
    /** 正在刷新中的状态 */
    JRRefreshStateRefreshing,
};



#ifdef DEBUG
#define JR_DebugLog( fmt, ... ) NSLog( @"[%@:(%d)] %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(fmt), ##__VA_ARGS__] )
#else
#define JR_DebugLog( fmt, ... )
#endif

#endif /* JRRefreshConfig_h */
