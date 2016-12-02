//
//  TMXHomeSearchModel.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXHomeSearchModel.h"

@implementation TMXHomeSearchModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"searchResult":[TMXHomeSearchListModel class]};
}

-(void)FetchTMXHomeSearchModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_Search];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            TMXHomeSearchModel *model = [TMXHomeSearchModel mj_objectWithKeyValues:baseModel.content];
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

@implementation TMXHomeSearchListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"searchID":@"id"};
}

@end