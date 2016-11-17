//
//  JRRefreshBaseView.m
//  joyRunner
//
//  Created by AlanWang on 16/11/15.
//  Copyright © 2016年 Joyrun. All rights reserved.
//

#import "JRRefreshBaseView.h"
#import "JRRefreshConfig.h"
#import "JRRefreshObseversManager.h"

@interface JRRefreshBaseView ()



@end

@implementation JRRefreshBaseView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepare];
    }
    return self;
    
}
- (void)prepare {
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.backgroundColor = [UIColor clearColor];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    
    [super willMoveToSuperview:newSuperview];
    if (newSuperview && ![newSuperview isKindOfClass:[UIScrollView class]]) {
        return;
    }
    [self.observersManager willAddSubview:self toSuperView:newSuperview];
}

- (JRRefreshObseversManager *)observersManager {
    if (!_observersManager) {
        _observersManager = [[JRRefreshObseversManager alloc] init];
    }
    return _observersManager;
}


@end
