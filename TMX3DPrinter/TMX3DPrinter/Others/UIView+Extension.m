//
//  UIView+Extension.m
//  新浪微博
//
//  Created by jose on 15-3-12.
//  Copyright (c) 2015年 jose. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

//代码实现get和set的方法，不用系统自带的实现方法

//x
-(void)setX:(CGFloat)x{
    CGRect frame=self.frame;
    frame.origin.x=x;
    self.frame=frame;
}
-(CGFloat)x{
    return self.frame.origin.x;
}

//y
-(void)setY:(CGFloat)y{
    CGRect frame=self.frame;
    frame.origin.y=y;
    self.frame=frame;
}
-(CGFloat)y{
    return self.frame.origin.y;
}

//width
-(void)setWidth:(CGFloat)width{
    CGRect frame=self.frame;
    frame.size.width=width;
    self.frame=frame;
}
-(CGFloat)width{
    return self.frame.size.width;
}

//height
-(void)setHeight:(CGFloat)height{
    CGRect frame=self.frame;
    frame.size.height=height;
    self.frame=frame;
}

-(CGFloat)height{
    return self.frame.size.height;
}

//size
-(void)setSize:(CGSize)size{
    CGRect frame=self.frame;
    frame.size=size;
    self.frame=frame;
}

-(CGSize)size{
    return self.frame.size;
}

- (UIResponder *)getViewController:(UIResponder *)responder {
    UIResponder *nextResponder = [responder nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else {
        return [self getViewController:nextResponder];
    }
    return nil;
}

- (void)setCommonStyle {
    [self.layer setMasksToBounds:YES];
    [self.layer setBackgroundColor:[UIColor colorWithRed:254.0/255 green:255.0/255 blue:255.0/255 alpha:1.0].CGColor];
    [self.layer setBorderColor:[UIColor colorWithRed:206.0/255 green:207.0/255 blue:208.0/255 alpha:1.0].CGColor];
    [self.layer setBorderWidth:.8];
    [self.layer setCornerRadius:2.4];
}

- (void)setSubViewCommonStyle {
    [self.layer setMasksToBounds:YES];
    [self.layer setBackgroundColor:[UIColor colorWithRed:254.0/255 green:255.0/255 blue:255.0/255 alpha:1.0].CGColor];
    [self.layer setBorderColor:[UIColor colorWithRed:206.0/255 green:207.0/255 blue:208.0/255 alpha:1.0].CGColor];
    [self.layer setBorderWidth:.8];
    [self.layer setCornerRadius:2.4];
}
@end
