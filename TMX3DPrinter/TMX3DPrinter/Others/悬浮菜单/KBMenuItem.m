//
//  KBMenuItem.m
//  KBAnimationExample
//
//  Created by kobe on 16/9/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "KBMenuItem.h"
#import "KBAnimationTool.h"
@interface KBMenuItem ()
{
    CGPoint originalPoint;  ///<记录控件前平移的位置
}
@end


@implementation KBMenuItem

-(instancetype)initWithNormalImg:(NSString *)normalImg highlightImg:(NSString *)highlight size:(CGSize)size target:(id)target action:(SEL)action{
    if (self==[super init]) {
        [self setImage:[UIImage imageNamed:normalImg] forState:0];
        [self setImage:[UIImage imageNamed:highlight] forState:UIControlStateHighlighted];
        [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        self.frame=CGRectMake(0, 0, size.width, size.height);
        self.layer.cornerRadius=size.width/2;
        self.layer.masksToBounds=YES;
    }
    return self;
}

+(KBMenuItem *)menuItemWithNormalImg:(NSString *)normalImg highlightImg:(NSString *)highlight size:(CGSize)size target:(id)target action:(SEL)action{
    KBMenuItem *item=[[KBMenuItem alloc]initWithNormalImg:normalImg highlightImg:highlight size:size target:target action:action];
    return item;
}

-(void)showMenuItemWithPoint:(CGPoint)point{
    
    originalPoint=self.center;
    CABasicAnimation *scaleAnimation=[KBAnimationTool scaleAnimationWithDuration:0.4 fromValue:0.1 toValue:1.0];
    CABasicAnimation *opacityAnimation=[KBAnimationTool opacityAnimationWithDuration:0.4 fromValue:0.3 toValue:1.0];
    CAKeyframeAnimation *keyFrameAnimation=[KBAnimationTool moveLineAnimationWithDuraion:0.4 fromPoint:self.center toPoint:point delegate:self];
    CAAnimationGroup *groupAnimation=[KBAnimationTool groupAnimationWithDuration:0.4 animations:@[scaleAnimation,keyFrameAnimation,opacityAnimation]];
    [self.layer addAnimation:groupAnimation forKey:nil];
    self.center=point;
}

-(void)hideMenuItem{
    
    CABasicAnimation *scaleAnimation=[KBAnimationTool scaleAnimationWithDuration:0.4 fromValue:0.1 toValue:1.0];
    CABasicAnimation *opacityAnimation=[KBAnimationTool opacityAnimationWithDuration:0.4 fromValue:0.1 toValue:1.0];
    CAKeyframeAnimation *keyFrameAnimation=[KBAnimationTool moveLineAnimationWithDuraion:0.4 fromPoint:self.center toPoint:originalPoint delegate:self];
    CAAnimationGroup *groupAnimation=[KBAnimationTool groupAnimationWithDuration:0.4 animations:@[scaleAnimation,keyFrameAnimation,opacityAnimation]];
    [self.layer addAnimation:groupAnimation forKey:nil];
    self.center=originalPoint;
    
}
@end
