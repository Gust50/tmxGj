//
//  TMXWaitPrinterModel.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/9.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXWaitPrinterModel.h"

@implementation TMXWaitPrinterModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"printQueueList":[TMXWaitPrinterListModel class]};
}

-(void)FetchTMXWaitPrinterModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_WaitPrinterTask];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        NSLog(@"%@", response);
        if (baseModel.code==ResponseSuccess) {
            TMXWaitPrinterModel *model=[TMXWaitPrinterModel mj_objectWithKeyValues:baseModel.content];
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

@implementation TMXWaitPrinterListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"waitPrinterID":@"id"};
}

@end

@implementation TMXWaitPrinterCancelModel

-(void)FetchTMXWaitPrinterCancelModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_WaitCancelTask];
    
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
