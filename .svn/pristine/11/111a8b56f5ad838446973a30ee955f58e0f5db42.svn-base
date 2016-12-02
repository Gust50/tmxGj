//
//  TMXAccountModel.h
//  TMX3DPrinter
//
//  Created by kobe on 16/6/17.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface TMXAccountModel : NSObject



@end

@interface TMXAccountLoginModel : NSObject

/**
 *  登录
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)FetchTMXAccountLoginData:(NSDictionary *)params
               callBack:(void(^)(BOOL isSuccess,id result))completion;

/**
 *  注销
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)FetchTMXAccountLogoutData:(NSDictionary *)params
                       callBack:(void(^)(BOOL isSuccess,id result))completion;

/**
 *  用户信息反馈
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)FetchTMXAccountFeedBackData:(NSDictionary *)params
                        callBack:(void(^)(BOOL isSuccess,id result))completion;

/**
 *  上传用户头像
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)FetchTMXAccountIconData:(NSDictionary *)params
                          callBack:(void(^)(BOOL isSuccess,id result))completion;
@end


NS_ASSUME_NONNULL_END