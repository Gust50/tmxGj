//
//  TMXScanQRCodeModel.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/23.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXScanQRCodeModel.h"

@implementation TMXScanQRCodeModel

-(void)FetchTMXScanQRCodeModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_ScanQRCode];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        
        if (baseModel.code==ResponseSuccess) {
            TMXScanQRCodeModel *model = [TMXScanQRCodeModel mj_objectWithKeyValues:baseModel.content];
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

@implementation TMXAddPrinterToPrinterListModel

-(void)FetchTMXAddPrinterToPrinterListModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_AddPrinter];
    
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
