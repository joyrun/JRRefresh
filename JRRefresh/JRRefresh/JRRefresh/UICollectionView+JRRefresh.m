//
//  UICollectionView+JRRefresh.m
//  JRRefresh
//
//  Created by AlanWang on 16/11/23.
//  Copyright © 2016年 AlanWang. All rights reserved.
//

#import "UICollectionView+JRRefresh.h"
#import "UIScrollView+JRRefresh.h"
#import <objc/runtime.h>
@implementation UICollectionView (JRRefresh)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method m1 = class_getInstanceMethod(self.class, @selector(reloadData));
        Method m2 = class_getInstanceMethod(self.class, @selector(jr_reloadData));
        method_exchangeImplementations(m1, m2);
        
    });
    
}

- (void)jr_reloadData {
    [self jr_reloadData];
    [self customMethodAfterReloadData];
    
}

- (void)customMethodAfterReloadData {
    
    NSInteger totalCount = 0;
    for (int i = 0; i<self.numberOfSections; i++) {
        totalCount = [self numberOfItemsInSection:i];
    }    
    if (totalCount == 0) {
        [self jr_removeFooter];
    }else {
        [self jr_showFooter];
    }
    
}
- (NSInteger)dataCount {
    NSInteger totalCount = 0;
    for (int i = 0; i<self.numberOfSections; i++) {
        totalCount = [self numberOfItemsInSection:i];
    }
    return totalCount;
}
@end
