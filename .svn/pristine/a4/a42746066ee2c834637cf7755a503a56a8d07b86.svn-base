//
//  TMXAccountRegisterModel.h
//  TMX3DPrinter
//
//  Created by kobe on 16/6/17.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMXAccountRegisterModel : NSObject


/**
 *  注册新用户
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)FetchTMXAccountRegisterData:(NSDictionary *)params
                               callBack:(void(^)(BOOL isSuccess,id result))completion;

/**
 *  发送验证码
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)PostTMXAccountPhoneNumData:(NSDictionary *)params
                           callBack:(void(^)(BOOL isSuccess,id result))completion;


/**
 *  验证用户名
 *
 *  @param params     参数
 *  @param completion 返回
 */
-(void)FetchTMXAccountCheckNameData:(NSDictionary *)params
                       callBack:(void(^)(BOOL isSuccess,id result))completion;
/**
 *  验证手机号码
 *
 *  @param params     参数
 *  @param completion 返回
 */
-(void)FetchTMXAccountCheckPhoneNumData:(NSDictionary *)params
                           callBack:(void(^)(BOOL isSuccess,id result))completion;

/**
 *  重置手机密码
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)FetchTMXAccountResetPhoneNumData:(NSDictionary *)params
                               callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXSendEmailTokenModel : NSObject

@property (nonatomic, assign)BOOL result;   ///<返回true则验证码已发送，否则发送失败
/**
 *  发送邮箱验证
 *
 *  @param email      邮箱
 *  @param type       1：表示注册 2：表示重置密码
 *  @param completion 返回
 */
-(void)FetchTMXSendEmailTokenModel:(NSDictionary *)params
                            callBack:(void(^)(BOOL isSuccess,id result))completion;


/**
 *  注册邮箱
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)FetchTMXAccountRegisterEmailData:(NSDictionary *)params
                               callBack:(void(^)(BOOL isSuccess,id result))completion;

/**
 *  重置密码
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)FetchTMXAccountResetPasswordData:(NSDictionary *)params
                               callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXCheckEmailModel : NSObject

@property (nonatomic, assign)BOOL result;   ///<返回true则邮箱可用，否则不可用

/**
 *  检测邮箱
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)FetchTMXCheckEmailModel:(NSDictionary *)params
                               callBack:(void(^)(BOOL isSuccess,id result))completion;

@end
