//
//  TMXFeedbackModel.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/20.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXFeedbackModel.h"

@implementation TMXFeedbackModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"modelList":[TMXFeedbackListModel class]};
}

-(void)FetchTMXFeedbackModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_Feedback];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            TMXFeedbackModel *model = [TMXFeedbackModel mj_objectWithKeyValues:baseModel.content];
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

@implementation TMXFeedbackListModel


@end
