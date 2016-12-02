//
//  TMXHomeSearchModel.h
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMXHomeSearchModel : NSObject

@property (nonatomic, strong)NSArray *searchResult;     ///<搜索结果

/**
 *  模型搜索
 *
 *  @param keywords    关键字
 *  @param completion 返回
 */
-(void)FetchTMXHomeSearchModel:(NSDictionary *)params
                           callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXHomeSearchListModel : NSObject

@property (nonatomic, assign)NSInteger searchID;            ///<模型id
@property (nonatomic, copy)NSString *name;                  ///<模型名称
@property (nonatomic, copy)NSString *ownerName;             ///<发布者昵称
@property (nonatomic, copy)NSString *image;                 ///<模型图片
@property (nonatomic, copy)NSString *updatedDate;           ///<更新时间
@property (nonatomic, assign)NSInteger favoriteCnt;         ///<收藏次数
@property (nonatomic, assign)NSInteger modelCommentCount;   ///<评论次数

@end