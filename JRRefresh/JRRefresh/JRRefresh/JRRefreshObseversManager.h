//
//  JRRefreshObseversManager.h
//  joyRunner
//
//  Created by AlanWang on 16/11/15.
//  Copyright © 2016年 Joyrun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRRefreshObseversManager : NSObject

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIView *subView;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

- (void)willAddSubview:(UIView *)subView toSuperView:(UIView *)superView;


@property (nonatomic,copy) void(^ScrollViewContentOffsetChangeBlock)(NSDictionary *change,UIScrollView *scrollView);
@property (nonatomic,copy) void(^ScrollViewContentSizeChangeBlock)(NSDictionary *change,UIScrollView *scrollView);
@property (nonatomic,copy) void(^ScrollViewGestureStateChangeBlock)(NSDictionary *change,UIScrollView *scrollView);

@end
