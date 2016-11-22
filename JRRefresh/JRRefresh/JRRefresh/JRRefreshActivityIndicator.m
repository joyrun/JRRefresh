//
//  JRRefreshActivityIndicator.m
//  JRRefresh
//
//  Created by AlanWang on 16/11/22.
//  Copyright © 2016年 AlanWang. All rights reserved.
//

#import "JRRefreshActivityIndicator.h"
#import "JRRefreshConfig.h"



@interface JRRefreshActivityIndicator ()
@property (nonatomic, strong) UIView *bg;
@property (nonatomic, strong) CALayer *imageLayer;

@end
@implementation JRRefreshActivityIndicator
- (id)initWithCenter:(CGPoint)center
{
    int size = 25;
    self = [self initWithFrame:CGRectMake(center.x - size/2, center.y - size/2, size, size)];
    if(self) {
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(-5, -5, 35, 35)];
        bg.backgroundColor = JR_RGBA(0, 0, 0, 0.7f);
        bg.layer.cornerRadius = 4;
        [self addSubview:bg];
        bg.hidden = YES;
        self.bg = bg;
        
        CALayer *imageLayer = [CALayer layer];
        imageLayer.contentsScale = [UIScreen mainScreen].scale;
        imageLayer.frame = self.bounds;
        imageLayer.contents =(__bridge id _Nullable)([UIImage imageNamed:@"refresh_indicator"].CGImage);
        imageLayer.contentsGravity = kCAGravityResizeAspect;
        [self.layer addSublayer:imageLayer];
        self.imageLayer = imageLayer;
        
        self.hidden = YES;
        self.isAnimating = NO;
    }
    return self;
}

- (void)showRoundCornerBG:(BOOL)show
{
    self.bg.hidden = !show;
}

- (void)startAnimating
{
    self.hidden = NO;
    self.isAnimating = YES;
    
    CABasicAnimation *animationImage = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animationImage.fromValue = [NSNumber numberWithFloat:JR_DEGREES_TO_RADIANS(360)];
    animationImage.toValue = [NSNumber numberWithFloat:JR_DEGREES_TO_RADIANS(0)];
    animationImage.duration = 1.0;
    animationImage.removedOnCompletion = NO;
    animationImage.fillMode = kCAFillModeForwards;
    animationImage.repeatCount = MAXFLOAT;
    
    [self.imageLayer addAnimation:animationImage forKey:@"a"];
}

- (void)stopAnimating
{
    self.hidden = YES;
    self.isAnimating = NO;
    
    [self.imageLayer removeAllAnimations];
}

@end
