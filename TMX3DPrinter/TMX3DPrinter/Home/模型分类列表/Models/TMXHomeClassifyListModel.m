//
//  TMXHomeClassifyListModel.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXHomeClassifyListModel.h"

@implementation TMXHomeClassifyListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"classifyID":@"id"};
}

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"modelList":[TMXHomeClassifyListListModel class]};
}

-(void)FetchTMXHomeClassifyListModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_HomeClissify];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            TMXHomeClassifyListModel *model = [TMXHomeClassifyListModel mj_objectWithKeyValues:baseModel.content];
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

@implementation TMXHomeClassifyListListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"classifyListID":@"id"};
}

@end
