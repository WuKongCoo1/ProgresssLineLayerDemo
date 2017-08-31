//
//  WKProgressBarLayer.h
//  ProgresssLineLayerDemo
//
//  Created by 吴珂 on 2017/8/31.
//  Copyright © 2017年 世纪阳天. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WKAnimationStatus) {
    WKAnimationStatusIdle,//空闲
    WKAnimationStatusAnimating,//动画中
    WKAnimationStatusPause,//暂停
    WKAnimationStatusComplete//完成
};

@interface WKProgressBarLayer : CAShapeLayer

@property (nonatomic, assign, readonly) WKAnimationStatus animatingStatus;//状态

/**
 开始动画

 @param duration 动画最大时长
 */
- (void)beginAnimationWithDuration:(CGFloat)duration;

/**
 暂停
 */
- (void)pauseAnimation;

/**
 恢复
 */
- (void)resumeAnimation;


/**
 重新开始动画

 @param progress 从哪个进度开始
 @param duration 动画最大时长
 */
- (void)restartAnimationWithProgress:(CGFloat)progress duration:(NSTimeInterval)duration;
@end
