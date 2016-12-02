//
//  FetchAppPublicKey.h
//  ClshUser
//
//  Created by kobe on 16/6/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMXLoginInfoModel.h"


@interface FetchAppPublicKeyModel : NSObject

@property(nonatomic,strong)NSString *publicKey;               ///< APP公钥
@property(nonatomic,assign)BOOL isLogin;                      ///< 用户是否登录
@property(nonatomic,strong)TMXLoginInfoModel *infoModel;     ///< 用户登录信息
@property (nonatomic, strong) NSString *isCompletion;         ///<是否打印完成
/**
 *  singleton
 */
+(instancetype)shareAppPublicKeyManager;


/**
 *  get publicKey
 *
 *  @param params             params
 *  @param completion         return publicKey
 */
-(void)fetchAppPublicKey:(NSDictionary *)params
                callBack:(void(^)(BOOL isSuccess,id result))completion;

/**
 *  get EncryptParams
 *
 *  @return Dictionary
 */
-(NSDictionary *)fetchEncryptParams;


@end
