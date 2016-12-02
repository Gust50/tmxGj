//
//  TMXGetPrinterSateModel.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/13.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXGetPrinterSateModel.h"

@implementation TMXGetPrinterSateModel

-(void)FetchTMXGetPrinterSateModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_GetSetState];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        
        if (baseModel.code==ResponseSuccess) {
            TMXGetPrinterSateModel *model = [TMXGetPrinterSateModel mj_objectWithKeyValues:baseModel.content];
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

@implementation TMXUpEnergySavingStateModel

-(void)FetchTMXUpEnergySavingStateModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_GetEnergyState];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
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

@implementation TMXUpInductionDoorStateModel

-(void)FetchTMXUpInductionDoorStateModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_GetDoorState];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
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

@implementation TMXCheckVersionModel

-(void)FetchTMXCheckVersionModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_CheckVersion];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        
        if (baseModel.code==ResponseSuccess) {
            TMXCheckVersionModel *model = [TMXCheckVersionModel mj_objectWithKeyValues:baseModel.content];
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
