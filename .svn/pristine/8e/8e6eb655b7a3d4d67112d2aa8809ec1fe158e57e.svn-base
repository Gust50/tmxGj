//
//  TMXAccountRegisterModel.m
//  TMX3DPrinter
//
//  Created by kobe on 16/6/17.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXAccountRegisterModel.h"

@implementation TMXAccountRegisterModel


-(void)FetchTMXAccountRegisterData:(NSDictionary *)params
                          callBack:(void (^)(BOOL, id))completion
{
    
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_AppRegister];
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


-(void)PostTMXAccountPhoneNumData:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_SendSmsToken];
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

-(void)FetchTMXAccountCheckNameData:(NSDictionary *)params
                           callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_AppValidateName];
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

-(void)FetchTMXAccountCheckPhoneNumData:(NSDictionary *)params
                               callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_AppValidatePhoneNum];
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

-(void)FetchTMXAccountResetPhoneNumData:(NSDictionary *)params
                               callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_ResetPassword];
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

@implementation TMXSendEmailTokenModel

//验证邮箱
-(void)FetchTMXSendEmailTokenModel:(NSDictionary *)params
                            callBack:(void(^)(BOOL isSuccess,id result))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_SendEmailToken];
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            
            TMXSendEmailTokenModel *model = [TMXSendEmailTokenModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}
//注册邮箱
-(void)FetchTMXAccountRegisterEmailData:(NSDictionary *)params
                               callBack:(void(^)(BOOL isSuccess,id result))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_Regist4Abroad];
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

//重置密码
-(void)FetchTMXAccountResetPasswordData:(NSDictionary *)params
                               callBack:(void(^)(BOOL isSuccess,id result))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_ResetPassword4Abroad];
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

@implementation TMXCheckEmailModel

-(void)FetchTMXCheckEmailModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_AppValidateEmail];
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            TMXCheckEmailModel *model = [TMXCheckEmailModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}

@end
