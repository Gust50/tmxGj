//
//  TMXRegisterVC.h
//  TMX3DPrinter
//
//  Created by wutaobo on 16/6/8.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TMXRegisterVCDelegate <NSObject>

-(void)returnBackAccountInfo:(NSDictionary *)dict;

@end

@interface TMXRegisterVC : TMXBaseVC

//标题
@property (nonatomic, copy) NSString *titleStr;
//判断是否隐藏版本
@property (nonatomic, assign) BOOL isHideDescribe;
//底部title
@property (nonatomic, copy) NSString *btnStr;
//密码label
@property (nonatomic, copy) NSString *passwordStr;


@property (nonatomic, assign) BOOL isForgetPassword;


@property (nonatomic, weak) id<TMXRegisterVCDelegate>delegate;


@end
