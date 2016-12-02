//
//  KBAnimationTool.h
//  KBAnimationExample
//
//  Created by kobe on 16/9/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface KBAnimationTool : NSObject

+(CABasicAnimation *)scaleAnimationWithDuration:(CFTimeInterval)duration
                                      fromValue:(CGFloat)fromValue
                                        toValue:(CGFloat)toValue;

+(CABasicAnimation *)opacityAnimationWithDuration:(CFTimeInterval)duration
                                        fromValue:(CGFloat)fromValue
                                          toValue:(CGFloat)toValue;

+(CAKeyframeAnimation *)moveLineAnimationWithDuraion:(CFTimeInterval)duration
                                           fromPoint:(CGPoint)fromPoint
                                             toPoint:(CGPoint)toPoint delegate:(id)delegate;
+(CAAnimationGroup *)groupAnimationWithDuration:(CFTimeInterval)duration
                                     animations:(NSArray *)animations;

@end
