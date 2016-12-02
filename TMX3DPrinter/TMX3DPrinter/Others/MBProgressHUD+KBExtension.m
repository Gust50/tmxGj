//
//  MBProgressHUD+KBExtension.m
//  ClshUser
//
//  Created by kobe on 16/6/7.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "MBProgressHUD+KBExtension.h"

@implementation MBProgressHUD (KBExtension)

+(void)show:(NSString *)text
       icon:(NSString *)icon
       view:(UIView *)view
{
    if (view==nil) view=[[UIApplication sharedApplication].windows lastObject];
    //提示框
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText=text;
    hud.labelFont=[UIFont systemFontOfSize:14];
    //设置图片
    hud.customView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:icon]];
    hud.mode=MBProgressHUDModeCustomView;
    //影藏的时候从父控件移除控件
    hud.removeFromSuperViewOnHide= YES;
    [hud hide:YES afterDelay:0.8];
}

+(void)showSuccess:(NSString *)success
            toView:(UIView *)view
{
    [self show:success icon:@"success" view:view];
}

+(void)showError:(NSString *)error
          toView:(UIView *)view
{
    [self show:error icon:@"error" view:view];
}

+(MBProgressHUD *)showMessage:(NSString *)message
                       toView:(UIView *)view
{
    if (view==nil) view=[[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText=message;
    hud.labelFont=[UIFont systemFontOfSize:14];
    
    hud.removeFromSuperViewOnHide=YES;
    hud.dimBackground=NO;
    return hud;
}

+(void)showSuccess:(NSString *)success{
    [self showSuccess:success toView:nil];
}

+(void)showError:(NSString *)error{
    [self showError:error toView:nil];
}

+(MBProgressHUD *)showMessage:(NSString *)message{
    return [self showMessage:message toView:nil];
}

+(void)hideHUDForView:(UIView *)view{
    [self hideHUDForView:view animated:YES];
}

+(void)hideHUD{
    [self hideHUDForView:nil];
}

@end
