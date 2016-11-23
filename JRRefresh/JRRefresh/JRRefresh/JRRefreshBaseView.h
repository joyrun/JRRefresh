//
//  JRRefreshBaseView.h
//  joyRunner
//
//  Created by AlanWang on 16/11/15.
//  Copyright © 2016年 Joyrun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRRefreshConfig.h"


@class JRRefreshObseversManager;

@interface JRRefreshBaseView : UIView


@property (assign, nonatomic) JRRefreshState state;
@property (nonatomic, strong) JRRefreshObseversManager *observersManager;
@property (nonatomic, assign) UIEdgeInsets originalInset;



@end
