//
//  TMXUploadByUserModel.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/22.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXUploadByUserModel.h"

@implementation TMXUploadByUserModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"modelList":[TMXUploadByUserListModel class]};
}

-(void)FetchTMXUploadByUserModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_UploadByUser];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            TMXUploadByUserModel *model = [TMXUploadByUserModel mj_objectWithKeyValues:baseModel.content];
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

@implementation TMXUploadByUserListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"modelId":@"id"};
}

@end
