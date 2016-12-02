//
//  TMXAccountModel.m
//  TMX3DPrinter
//
//  Created by kobe on 16/6/17.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXAccountModel.h"
#import "TMXAccountModel.h"

@implementation TMXAccountModel

@end


@implementation TMXAccountLoginModel


-(void)FetchTMXAccountLoginData:(NSDictionary *)params
                       callBack:(void (^)(BOOL, id _Nonnull))completion{
    
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_AppLogin];
    NSString *jsonString=[NSObject jsonTypeStringWithData:params];
    NSString *encrypt=[KBRSA encryptString:jsonString publicKey:[FetchAppPublicKeyModel shareAppPublicKeyManager].publicKey];
    NSMutableDictionary *needParams=[NSMutableDictionary dictionary];
    
    needParams[@"username"]=[NSString decodeString:params[@"username"]];
    needParams[@"body"]=encrypt;
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            
            TMXLoginInfoModel *model=[TMXLoginInfoModel mj_objectWithKeyValues:baseModel.content];
            [FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel=model;
            [FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin=YES;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"LoginSuccess" object:nil userInfo:@{@"isSuccess":@(YES)}];
            completion(YES,@"登录成功");
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}


-(void)FetchTMXAccountLogoutData:(NSDictionary *)params
                        callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_AppLogout];
    
    NSMutableDictionary *encryDict=[NSMutableDictionary dictionary];
    encryDict[@"userId"]=[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
    encryDict[@"token"]=[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.token;
    
    NSString *jsonString=[NSObject jsonTypeStringWithData:encryDict];
    NSString *encrypt=[KBRSA encryptString:jsonString publicKey:[FetchAppPublicKeyModel shareAppPublicKeyManager].publicKey];
    NSMutableDictionary *needParams=[NSMutableDictionary dictionary];
    needParams[@"userId"]=[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
    needParams[@"body"]=encrypt;
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            
            [FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin=NO;
            
            //取出之前保存的密码
            NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"]];
            params[@"password"]=nil;
            
            //记住登录账号和密码
            [[NSUserDefaults standardUserDefaults]setObject:params forKey:@"userInfo"];
            [[NSUserDefaults standardUserDefaults]synchronize];
             [[NSNotificationCenter defaultCenter]postNotificationName:@"LoginSuccess" object:nil userInfo:@{@"isSuccess":@(NO)}];
            completion(YES,@"注销成功");
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}


-(void)FetchTMXAccountFeedBackData:(NSDictionary *)params
                          callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_TalkToUs];
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        
        if (baseModel.code==ResponseSuccess) {
            
            completion(YES,@"反馈成功");
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];

}

-(void)FetchTMXAccountIconData:(NSDictionary *)params callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_UpLoadImages];
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            
            completion(YES,baseModel.message);
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}
@end
