//
//  TMXAllCommentModel.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/19.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXAllCommentModel.h"

@implementation TMXAllCommentModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"modelList":[TMXModelListModel class]};
}

-(void)FetchTMXAllCommentModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,TMX_AllComment];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        NSLog(@"%@", response);
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            TMXAllCommentModel *model = [TMXAllCommentModel mj_objectWithKeyValues:baseModel.content];
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

@implementation TMXModelListModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"commentReplyList":[TMXCommentReplyListModel class]};
}

@end

@implementation TMXCommentReplyListModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"repliesList":[TMXRepliesListModel class]};
}

@end

@implementation TMXRepliesListModel

@end