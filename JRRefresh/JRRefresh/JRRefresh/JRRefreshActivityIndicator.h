//
//  JRRefreshActivityIndicator.h
//  JRRefresh
//
//  Created by AlanWang on 16/11/22.
//  Copyright © 2016年 AlanWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRRefreshActivityIndicator : UIView


@property (nonatomic, assign)BOOL isAnimating;
@property (nonatomic, strong)UIImage *indicatorImg;



- (id)initWithCenter:(CGPoint)center;
- (void)startAnimating;
- (void)stopAnimating;

- (void)showRoundCornerBG:(BOOL)show;



@end
