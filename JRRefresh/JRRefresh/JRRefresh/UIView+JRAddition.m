//
//  UIView+JRAddition.m
//  JRRefresh
//
//  Created by AlanWang on 16/11/17.
//  Copyright © 2016年 AlanWang. All rights reserved.
//

#import "UIView+JRAddition.h"

@implementation UIView (JRAddition)


#pragma mark - top/bottom/left/right
- (CGFloat)jr_top {
    return self.frame.origin.y;
}
- (void)setJr_top:(CGFloat)jr_top {
    CGRect frame = self.frame;
    frame.origin.y = jr_top;
    self.frame = frame;
}

- (CGFloat)jr_bottom {
    return self.jr_top + self.jr_height;
}
- (void)setJr_bottom:(CGFloat)jr_bottom {
    self.jr_top = jr_bottom - self.jr_height;
}


- (CGFloat)jr_left {
    return self.frame.origin.x;
}
- (void)setJr_left:(CGFloat)jr_left {
    CGRect frame = self.frame;
    frame.origin.x = jr_left;
    self.frame = frame;
}


- (CGFloat)jr_right {
    return self.jr_left + self.jr_width;
}

- (void)setJr_right:(CGFloat)jr_right {
    self.jr_left = jr_right - self.jr_width;
}


#pragma mark - centerX/centerY
- (CGFloat)jr_centerX {
    return self.center.x;
}
- (void)setJr_centerX:(CGFloat)jr_centerX {
    self.center = CGPointMake(jr_centerX, self.jr_centerY);
}


- (CGFloat)jr_centerY {
    return self.center.y;
}
- (void)setJr_centerY:(CGFloat)jr_centerY {
    self.center = CGPointMake(self.jr_centerX, jr_centerY);
}

#pragma mark - height/width
- (CGFloat)jr_height {
    return self.frame.size.height;
}
- (void)setJr_height:(CGFloat)jr_height {
    CGRect frame = self.frame;
    frame.size.height = jr_height;
    self.frame = frame;
}


- (CGFloat)jr_width {
    return self.frame.size.width;
}
- (void)setJr_width:(CGFloat)jr_width {
    CGRect frame = self.frame;
    frame.size.width = jr_width;
    self.frame = frame;
}


#pragma mark - size
- (CGSize)jr_size {
    return self.frame.size;
}
- (void)setJr_size:(CGSize)jr_size {
    CGRect frame = self.frame;
    frame.size = self.jr_size;
    self.frame = frame;
}



@end
