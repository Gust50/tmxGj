//
//  TMXLikeModel.h
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMXLikeModel : NSObject

@property (nonatomic, strong)NSArray *modelList;     ///<喜欢模型列表
@property (nonatomic, assign)NSInteger totalPage;    ///<共有几页

/**
 *  喜欢模型
 *
 *  @param pageNumber    第几页
 *  @param pageSize     一页显示几个
 *  @param completion   返回
 */
-(void)FetchTMXLikeModel:(NSDictionary *)params
                   callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXLikeListModel : NSObject

@property (nonatomic, assign)NSInteger likeID;          ///<模型id
@property (nonatomic, copy)NSString *image;             ///<模型预览图
@property (nonatomic, copy)NSString *name;              ///<模型名称
@property (nonatomic, copy)NSString *ownerName;         ///<发布者昵称
@property (nonatomic, copy)NSString *updatedDate;       ///<更新时间
@property (nonatomic, assign)NSInteger favoriteCnt;     ///<收藏数
@property (nonatomic, assign)NSInteger modelCommentCount;///<评论数

@end
