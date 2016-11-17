//
//  UIScrollView+JRFRefresh.m
//  joyRunner
//
//  Created by AlanWang on 16/11/15.
//  Copyright © 2016年 Joyrun. All rights reserved.
//

#import "UIScrollView+JRRefresh.h"
#import "JRRefreshHeader.h"
#import <objc/runtime.h>

static NSString *kJr_headerKey = @"kJr_headerKey";
static NSString *kJr_footerKey = @"kJr_footerKey";

@implementation UIScrollView (JRRefresh)


- (void)setJr_header:(JRRefreshHeader *)jr_header {
    
    if (jr_header != self.jr_header) {
        [self.jr_header removeFromSuperview];
//        [self insertSubview:jr_header atIndex:0];
        [self addSubview:jr_header];
        objc_setAssociatedObject(self, &kJr_headerKey, jr_header, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
}
- (JRRefreshHeader *)jr_header {
    return objc_getAssociatedObject(self, &kJr_headerKey);
}

- (void)setJr_footer:(UIView *)jr_footer {
    
}
- (UIView *)jr_footer {
    return nil;
}

@end
