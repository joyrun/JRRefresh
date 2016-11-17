//
//  UIView+JRAddition.h
//  JRRefresh
//
//  Created by AlanWang on 16/11/17.
//  Copyright © 2016年 AlanWang. All rights reserved.
//

#import <UIKit/UIKit.h>


#define UIViewAutoresizingFlexibleTopAndBottomMargin UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin
#define UIViewAutoresizingFlexibleLeftAndRightMargin UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin

#define UIViewAutoresizingFlexibleCenter UIViewAutoresizingFlexibleTopAndBottomMargin | UIViewAutoresizingFlexibleLeftAndRightMargin
#define UIViewAutoresizingFlexibleSize UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight

@interface UIView (JRAddition)



@property CGFloat jr_top;
@property CGFloat jr_bottom;
@property CGFloat jr_left;
@property CGFloat jr_right;

@property CGFloat jr_centerX;
@property CGFloat jr_centerY;

@property CGFloat jr_height;
@property CGFloat jr_width;

@property CGSize jr_size;


@end
