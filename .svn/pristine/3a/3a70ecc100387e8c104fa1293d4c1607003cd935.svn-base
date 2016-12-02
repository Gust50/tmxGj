//
//  UIBarButtonItem+KBExtension.m
//  ClgsUser
//
//  Created by kobe on 16/3/22.
//  Copyright © 2016年 com.xinmengsoft. All rights reserved.
//

#import "UIBarButtonItem+KBExtension.h"
#import "UIView+Extension.h"

@implementation UIBarButtonItem (KBExtension)


/**
 *  Custom UIBarButtonItem
 *
 *  @param normalImage normalImage
 *  @param selectImage selectImage
 *  @param target      target
 *  @param action      action
 *
 *  @return UIBarButtonItem
 */
+(UIBarButtonItem *)normalImage:(NSString *)normalImage
                    selectImage:(NSString *)selectImage
                         target:(id)target
                         action:(SEL)action
{
    
    UIButton *button=[[UIButton alloc]init];
    [button setBackgroundImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateHighlighted];
    button.size=button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}


/**
 *  Custom UIBarButtonItem
 *
 *  @param normalTitle normalTitle
 *  @param selectTitle selectTitle
 *  @param normalColor normalColor
 *  @param selectColor selectColor
 *  @param normalImage normalImage
 *  @param selectImage selectImage
 *  @param target      target
 *  @param action      action
 *  @param size        size
 *  @param font        font
 *
 *  @return            UIBarButtonItem
 */

+(UIBarButtonItem *)normalTitle:(NSString *)normalTitle
                    selectTitle:(NSString *)selectTitle
                    normalColor:(UIColor *)normalColor
                    selectColor:(UIColor *)selectColor
                    normalImage:(NSString *)normalImage
                    selectImage:(NSString *)selectImage
                         target:(id)target
                         action:(SEL)action
                           size:(CGSize)size
                      titleFont:(UIFont *)font
{
    
    UIButton *button=[[UIButton alloc]init];
    button.size=size;
    button.titleLabel.font=font;
    [button setTitle:normalTitle forState:UIControlStateNormal];
    [button setTitle:selectTitle forState:UIControlStateHighlighted];
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:selectColor forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
    
}

@end
