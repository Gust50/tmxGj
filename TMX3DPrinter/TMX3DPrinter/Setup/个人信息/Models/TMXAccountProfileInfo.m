//
//  TMXAccountProfileInfo.m
//  TMX3DPrinter
//
//  Created by kobe on 16/6/17.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXAccountProfileInfo.h"

@implementation TMXAccountProfileInfo

-(void)FetchTMXAccountProfileInfoData:(NSDictionary *)params
                             callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_Profile];
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            
            TMXAccountProfileInfo *model=[TMXAccountProfileInfo mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];

}


-(void)FetchTMXAccountUpdateProfileInfoData:(NSDictionary *)params callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_UpdateProfile];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            
            TMXAccountProfileInfo *model=[TMXAccountProfileInfo mj_objectWithKeyValues:baseModel.content];
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



@implementation TMXAccountUploadImageModel

-(void)FetchTMXAccountIconData:(NSDictionary *)params
                      callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_UpLoadImages];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            
            TMXAccountUploadImageModel * model = [TMXAccountUploadImageModel mj_objectWithKeyValues:baseModel.content];
            //            TMXAccountProfileInfo *model=[TMXAccountProfileInfo mj_objectWithKeyValues:baseModel.content];
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
