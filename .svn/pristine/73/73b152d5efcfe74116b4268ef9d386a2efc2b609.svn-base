//
//  TMXAccountPrintTaskModel.m
//  TMX3DPrinter
//
//  Created by kobe on 16/6/17.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXAccountPrintTaskModel.h"

@implementation TMXAccountPrintTaskModel
+(NSDictionary *)mj_objectClassInArray{
    return @{@"fileList":[TMXAccountPrintTaskListModel class]};
}

-(void)FetchTMXAccountPrintTaskData:(NSDictionary *)params
                           callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_PrinterTask];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    NSLog(@"----------111222------------------------>");
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        NSLog(@"-----------测试数据中-------------%@---------->",response);
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            TMXAccountPrintTaskModel *model=[TMXAccountPrintTaskModel mj_objectWithKeyValues:baseModel.content];
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

@implementation TMXAccountPrintTaskListModel

@end

@implementation TMXAccountUpdatePrintTaskModel

-(void)FetchTMXAccountUpdatePrintTaskData:(NSDictionary *)params
                                 callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_PrinterProgress];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        NSLog(@"---------------------------%@",response);
        if (baseModel.code==ResponseSuccess) {
            TMXAccountUpdatePrintTaskModel *model=[TMXAccountUpdatePrintTaskModel mj_objectWithKeyValues:baseModel.content];
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

@implementation TMXAccountPrintTaskDelectFileModel

-(void)FetchTMXAccountPrintDelectFileData:(NSDictionary *)params
                                 callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_PrintDelectFile];
    
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
