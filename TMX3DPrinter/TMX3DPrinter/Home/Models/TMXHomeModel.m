//
//  TMXHomeModel.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXHomeModel.h"

@implementation TMXHomeModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"carouselList":[TMXHomeCarouselListModel class], @"categoryList":[TMXHomeCategoryListModel class], @"categoryModelList":[TMXHomeCategoryModelListModel class]};
}

-(void)FetchTMXHomeModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header, TMX_Home];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            TMXHomeModel *model = [TMXHomeModel mj_objectWithKeyValues:baseModel.content];
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

@implementation TMXHomeCarouselListModel
@end

@implementation TMXHomeCategoryListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"categoryID":@"id"};
}

@end

@implementation TMXHomeCategoryModelListModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"modelList":[TMXHomeCategoryModelListListModel class]};
}

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"categoryModelID":@"id"};
}
@end


@implementation TMXHomeCategoryModelListListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"listListID":@"id"};
}

@end