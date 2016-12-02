//
//  KBAnimationTool.m
//  KBAnimationExample
//
//  Created by kobe on 16/9/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "KBAnimationTool.h"

@implementation KBAnimationTool

+(CABasicAnimation *)scaleAnimationWithDuration:(CFTimeInterval)duration
                                      fromValue:(CGFloat)fromValue
                                        toValue:(CGFloat)toValue{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [animation setFromValue:@(fromValue)];
    [animation setToValue:@(toValue)];
    [animation setAutoreverses:NO];
    [animation setDuration:duration];
    return animation;
}

+(CABasicAnimation *)opacityAnimationWithDuration:(CFTimeInterval)duration
                                        fromValue:(CGFloat)fromValue
                                          toValue:(CGFloat)toValue{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    [animation setFromValue:@(fromValue)];
    [animation setToValue:@(toValue)];
    [animation setDuration:duration];
    return animation;
}

+(CAKeyframeAnimation *)moveLineAnimationWithDuraion:(CFTimeInterval)duration
                                           fromPoint:(CGPoint)fromPoint
                                             toPoint:(CGPoint)toPoint
                                            delegate:(id)delegate{
    
    CAKeyframeAnimation *keyFrameAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    [keyFrameAnimation setDuration:duration];
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, fromPoint.x, fromPoint.y);
    CGPathAddLineToPoint(path, nil, toPoint.x, toPoint.y);
    keyFrameAnimation.path=path;
    keyFrameAnimation.fillMode=kCAFillModeForwards;
    keyFrameAnimation.removedOnCompletion=NO;
    keyFrameAnimation.delegate=delegate;
    keyFrameAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    CGPathRelease(path);
    return keyFrameAnimation;
}

+(CAAnimationGroup *)groupAnimationWithDuration:(CFTimeInterval)duration
                                     animations:(NSArray *)animations{
    CAAnimationGroup *animationGroup=[[CAAnimationGroup alloc]init];
    animationGroup.animations=animations;
    animationGroup.duration=duration;
    return animationGroup;
}
@end
