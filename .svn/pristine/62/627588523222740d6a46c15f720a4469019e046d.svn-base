//
//  TMXAddPrinterModel.m
//  TMX3DPrinter
//
//  Created by kobe on 16/7/5.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXAddPrinterModel.h"

@implementation TMXAddPrinterModel
-(void)FetchTMXAddPrinterData:(NSDictionary *)params
                     callBack:(void (^)(BOOL, id))completion{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_BindPrinter];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        
        NSLog(@"____________添加打印机________________________%@",response);
        if (baseModel.code==ResponseSuccess) {
            TMXAddPrinterModel *model=[TMXAddPrinterModel mj_objectWithKeyValues:baseModel.content];
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


@implementation TMXAddPrinterStatusModel

-(void)FetchTMXPrinterStatusData:(NSDictionary *)params
                        callBack:(void (^)(BOOL, id))completion{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_PrinterStatus];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        
        NSLog(@">>>>>>>>>>>>>>>>>>>>>>查询打印机住状态>>>>>>>>>>>>>>>>>%@",response);
        if (baseModel.code==ResponseSuccess) {
          
            TMXAddPrinterStatusModel *model=[TMXAddPrinterStatusModel mj_objectWithKeyValues:baseModel.content];
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


@implementation TMXAddPrinterApikeyModel

-(void)FetchTMXPrinterApikeyData:(NSDictionary *)params
                        callBack:(void (^)(BOOL, id))completion{
    
     NSString *Url=[NSString stringWithFormat:@"%@",@"http://192.168.100.1/api/plugin/tmxmanager"];
    LRLog(@"-------------------->重置打印机>>>>>>>>>>>>>>>>>>>");
    [[KBHttpTool shareKBHttpToolManager]get:Url params:params success:^(id response) {
        
        LRLog(@"请求结果是.........%@",response);
        TMXAddPrinterApikeyModel *model=[TMXAddPrinterApikeyModel mj_objectWithKeyValues:response];
        completion(YES,model);
        
    } failure:^(NSError *error) {
        LRLog(@"请求失败的结果是.........%@",error);
    }];
}
@end
