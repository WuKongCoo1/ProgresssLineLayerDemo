//
//  WKProgressBarLayer.m
//  ProgresssLineLayerDemo
//
//  Created by 吴珂 on 2017/8/31.
//  Copyright © 2017年 世纪阳天. All rights reserved.
//

#import "WKProgressBarLayer.h"

@interface WKProgressBarLayer ()
<
CAAnimationDelegate
>

@end

@implementation WKProgressBarLayer
@synthesize animatingStatus = _animatingStatus;
- (void)reset
{
    [self removeAllAnimations];
    self.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 0, self.bounds.size.height)].CGPath;
    self.speed = 1.0;
    self.beginTime = 0.0;
}

- (void)beginAnimationWithDuration:(CGFloat)duration
{
    [self startAnimtionWithBeginProgress:0 duration:duration];
}

- (void)pauseAnimation
{
    CFTimeInterval pausedTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    self.speed = 0.0;
    self.timeOffset = pausedTime;
    self.animatingStatus = WKAnimationStatusPause;
}

- (void)resumeAnimation
{
    CFTimeInterval pausedTime = [self timeOffset];
    self.speed = 1.0;
    self.timeOffset = 0.0;
    self.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.beginTime = timeSincePause;
    
    self.animatingStatus = WKAnimationStatusAnimating;
}

- (void)restartAnimationWithProgress:(CGFloat)progress duration:(NSTimeInterval)duration
{
    [self removeAllAnimations];
    [self startAnimtionWithBeginProgress:progress duration:duration];
}

#pragma mark - private method

- (void)startAnimtionWithBeginProgress:(CGFloat)beginProgress duration:(NSTimeInterval)duration
{
    [self reset];//重置动画
    //设置path
    UIBezierPath *fromPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, beginProgress * self.bounds.size.width, self.bounds.size.height)];;
    UIBezierPath *toPath = [UIBezierPath bezierPathWithRect:self.bounds];
    
    self.path = fromPath.CGPath;
    //创建动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (id)fromPath.CGPath;
    animation.toValue = (id)toPath.CGPath;
    animation.duration = duration;
    
    [animation setValue:@1 forKey:@"progress"];//用于判断是否是进度动画
    
    animation.delegate = self;  //用于判断动画结束
    [self addAnimation:animation forKey:@"progressAnimation"];
    
    self.path = toPath.CGPath;
}

#pragma mark - setter

- (void)setAnimatingStatus:(WKAnimationStatus)animatingStatus
{
    _animatingStatus = animatingStatus;
}

#pragma mark - CAAnimationDelegate
/* Called when the animation begins its active duration. */

- (void)animationDidStart:(CAAnimation *)anim
{
    if (anim == [self animationForKey:@"progressAnimation"]) {//判断进度动画
        self.animatingStatus = WKAnimationStatusAnimating;
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([anim valueForKey:@"progress"] && flag == YES) {//判断进度动画
        self.animatingStatus = WKAnimationStatusComplete;
    }
}
@end
