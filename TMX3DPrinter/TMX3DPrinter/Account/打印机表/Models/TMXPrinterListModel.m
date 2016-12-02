//
//  TMXPrinterListModel.m
//  TMX3DPrinter
//
//  Created by 吴桃波 on 16/9/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXPrinterListModel.h"

@implementation TMXPrinterListModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"printerList":[TMXPrinterListListModel class], @"sharePrinterList":[TMXPrinterListShareListModel class]};
}

-(void)FetchTMXPrinterListModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_PrinterList];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        
        if (baseModel.code==ResponseSuccess) {
            TMXPrinterListModel *model=[TMXPrinterListModel mj_objectWithKeyValues:baseModel.content];
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

@implementation TMXPrinterListListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"printerListID":@"id"};
}

@end

@implementation TMXPrinterListShareListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"sharePrinterListID":@"id"};
}

@end

@implementation TMXPrinterUpdateIsDefaultModel

-(void)FetchTMXPrinterUpdateIsDefaultModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_UpdateIsDefault];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        
        if (baseModel.code==ResponseSuccess) {
            TMXPrinterUpdateIsDefaultModel *model=[TMXPrinterUpdateIsDefaultModel mj_objectWithKeyValues:baseModel.content];
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

@implementation TMXUnBindPrinterShareModel

-(void)FetchTMXUnBindPrinterShareModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_UnbindPrinterShare];
    
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

@implementation TMXPrinterInfoModel

-(void)FetchTMXHigherSetupModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_HighterSet];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        
        if (baseModel.code==ResponseSuccess) {
            TMXPrinterInfoModel *model = [TMXPrinterInfoModel mj_objectWithKeyValues:baseModel.content];
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