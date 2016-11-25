//
//  JRRefreshCircleView.m
//  JRRefresh
//
//  Created by AlanWang on 16/11/22.
//  Copyright © 2016年 AlanWang. All rights reserved.
//

#import "JRRefreshCircleView.h"
#import "JRRefreshCircleViewBgLayer.h"
#import "JRRefreshActivityIndicator.h"
#import "JRRefreshConfig.h"


#define PulltoRefreshThreshold 50.0


@interface JRRefreshCircleView ()

@property (nonatomic, strong) JRRefreshActivityIndicator *activityIndicatorView;  //Loading Indicator
@property (nonatomic, strong) JRRefreshCircleViewBgLayer *backgroundLayer;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CALayer *imageLayer;
@property (nonatomic, assign) BOOL isLoading;


@end

@implementation JRRefreshCircleView



- (id)initWithCenter:(CGPoint)center
{
    float size = 25;
    self = [super initWithFrame:CGRectMake(center.x - size/2, center.y - size/2, size, size)];
    if(self) {
        [self _commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _commonInit];
    }
    return self;
}

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (void)_commonInit
{
    
    self.borderColor = JR_RGBA(216, 67, 77, 1);
    self.borderWidth = 2.0f;
    self.contentMode = UIViewContentModeRedraw;
    self.backgroundColor = [UIColor clearColor];
    
    //init actitvity indicator
    _activityIndicatorView = [[JRRefreshActivityIndicator alloc] initWithFrame:self.bounds];
    [self addSubview:_activityIndicatorView];
    
    //init background layer
    JRRefreshCircleViewBgLayer *backgroundLayer = [[JRRefreshCircleViewBgLayer alloc] initWithBorderWidth:self.borderWidth];
    backgroundLayer.frame = self.bounds;
    [self.layer addSublayer:backgroundLayer];
    self.backgroundLayer = backgroundLayer;
    
    if(!self.imageIcon) {
        self.imageIcon = [UIImage imageNamed:@"refresh_logo"];
    }
    
    
    //init icon layer
    CALayer *imageLayer = [CALayer layer];
    imageLayer.contentsScale = [UIScreen mainScreen].scale;
    int size = 14;
    imageLayer.frame = CGRectMake((self.bounds.size.width - size)/2, (self.bounds.size.height - size)/2, size, size);
    imageLayer.contents = (id)self.imageIcon.CGImage;
    imageLayer.contentsGravity = kCAGravityCenter;
    [self.layer addSublayer:imageLayer];
    self.imageLayer = imageLayer;
    
    //init arc draw layer
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.frame = self.bounds;
    shapeLayer.fillColor = nil;
    shapeLayer.strokeColor = self.borderColor.CGColor;
    shapeLayer.strokeEnd = 0;
    shapeLayer.shadowColor = [UIColor colorWithWhite:1 alpha:0.8].CGColor;
    shapeLayer.shadowOpacity = 0.7;
    shapeLayer.shadowRadius = 20;
    shapeLayer.contentsScale = [UIScreen mainScreen].scale;
    shapeLayer.lineWidth = self.borderWidth;
    shapeLayer.lineCap = kCALineCapRound;
    
    [self.layer addSublayer:shapeLayer];
    self.shapeLayer = shapeLayer;
    
    [self setLayerOpacity:0];
}

- (void)showRoundCornerBG:(BOOL)show
{
    [self.activityIndicatorView showRoundCornerBG:show];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.shapeLayer.frame = self.bounds;
    [self updatePath];
    
}
- (void)updatePath {
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:center radius:(self.bounds.size.width/2 - self.borderWidth)  startAngle:M_PI -JR_DEGREES_TO_RADIANS(-90) endAngle:M_PI -JR_DEGREES_TO_RADIANS(360-90) clockwise:NO];
    
    self.shapeLayer.path = bezierPath.CGPath;
}

#pragma mark - property
- (void)setProgress:(double)progress scrollView:(UIScrollView*)scrollView
{
    CGFloat oldProgress = _progress;
    _progress = MAX(0.0, MIN(1.0, progress));
    
    if(oldProgress != self.progress)
    {
        //to prevent showing in some circumstances (updating contentOffset)
        if(scrollView.isDragging || scrollView.isDecelerating || self.updatingScrollViewOffset || oldProgress > self.progress)
        {
            [self setIndicatorProgress:progress];
            
        }
    }
    
}

- (void)setIndicatorProgress:(double)progress {
    
    progress = MAX(0.0, MIN(1.0, progress));

    CGFloat oldProgress = _progress;
    _progress = progress;
    
    [self setLayerOpacity:_progress];
    
    //rotation Animation
    CABasicAnimation *animationImage = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animationImage.fromValue = [NSNumber numberWithFloat:JR_DEGREES_TO_RADIANS(0 - 360.0 * oldProgress)];
    animationImage.toValue = [NSNumber numberWithFloat:JR_DEGREES_TO_RADIANS(0 - 360.0 * _progress)];
    animationImage.duration = 0.0;
    animationImage.removedOnCompletion = NO;
    animationImage.fillMode = kCAFillModeForwards;
    
    //strokeAnimation
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = [NSNumber numberWithFloat:((CAShapeLayer *)self.shapeLayer.presentationLayer).strokeEnd];
    animation.toValue = [NSNumber numberWithFloat:self.progress];
    animation.duration = 0;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self.imageLayer addAnimation:animationImage forKey:@"animation"];
    [self.shapeLayer addAnimation:animation forKey:@"animation"];
    
}


-(void)setLayerOpacity:(CGFloat)opacity
{
    self.imageLayer.opacity = opacity;
    self.backgroundLayer.opacity = opacity;
    self.shapeLayer.opacity = opacity;
}
-(void)setLayerHidden:(BOOL)hidden
{
    self.imageLayer.hidden = hidden;
    self.shapeLayer.hidden = hidden;
    self.backgroundLayer.hidden = hidden;
}
-(void)setCenter:(CGPoint)center
{
    [super setCenter:center];
}

- (void)startLoadingAnimation
{
    if (self.isLoading)
    {
        return;
    }
    
    [self setLayerOpacity:0.0];
    
    [self.activityIndicatorView startAnimating];
}

- (void)stopLoadingAnimation
{
    self.isLoading = NO;
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction animations:^{
        self.activityIndicatorView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        self.activityIndicatorView.transform = CGAffineTransformIdentity;
        [self.activityIndicatorView stopAnimating];
    }];
}



@end
