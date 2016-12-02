//
//  TMXAccountProfileInfo.h
//  TMX3DPrinter
//
//  Created by kobe on 16/6/17.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMXAccountProfileInfo : NSObject

@property (nonatomic ,copy) NSString *avatar;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *birthDay;
@property (nonatomic, copy) NSString *signature;          ///<签名
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *bindedQQ;          ///<是否绑定QQ
@property (nonatomic, copy) NSString *bindedWeChat;

/**
 *  获取个人信息接口
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)FetchTMXAccountProfileInfoData:(NSDictionary *)params
                       callBack:(void(^)(BOOL isSuccess,id result))completion;

/**
 *  修改个人信息
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)FetchTMXAccountUpdateProfileInfoData:(NSDictionary *)params
                             callBack:(void(^)(BOOL isSuccess,id result))completion;


@end





@interface TMXAccountUploadImageModel :NSObject

@property (nonatomic,copy)NSString * src;
@property (nonatomic,copy)NSString * url;

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
