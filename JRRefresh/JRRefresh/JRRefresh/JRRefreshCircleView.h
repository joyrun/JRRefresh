//
//  JRRefreshCircleView.h
//  JRRefresh
//
//  Created by AlanWang on 16/11/22.
//  Copyright © 2016年 AlanWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRRefreshCircleView : UIView


@property (nonatomic,strong) UIImage *imageIcon;
@property (nonatomic,strong) UIColor *borderColor;
@property (nonatomic,assign) CGFloat borderWidth;

- (id)initWithCenter:(CGPoint)center;
- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)init;

- (void)setIndicatorProgress:(double)progress;
- (void)startLoadingAnimation;
- (void)stopLoadingAnimation;
- (void)showRoundCornerBG:(BOOL)show;


@end
