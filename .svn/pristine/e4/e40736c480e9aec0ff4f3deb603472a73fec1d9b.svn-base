//
//  TMXProfileModel.h
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMXProfileModel : NSObject

@property (nonatomic, strong)NSArray *modelList;    ///<我的模型列表
@property (nonatomic, assign)NSInteger totalPage;   ///<共有几页

/**
 *  我的模型
 *
 *  @param pageNumber    第几页
 *  @param pageSize     一页显示几个
 *  @param userId     用户id
 *  @param completion 返回
 */
-(void)FetchTMXProfileModel:(NSDictionary *)params
                       callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXProfileListModel : NSObject

@property (nonatomic, assign)NSInteger profileID;           ///<模型id
@property (nonatomic, copy)NSString *name;                  ///<模型名称
@property (nonatomic, copy)NSString *ownerName;             ///<发布者昵称
@property (nonatomic, copy)NSString *image;                 ///<模型图片
@property (nonatomic, copy)NSString *updatedDate;           ///<更新时间
@property (nonatomic, assign)NSInteger favoriteCnt;         ///<收藏次数
@property (nonatomic, assign)NSInteger modelCommentCount;   ///<评论次数
@property (nonatomic, assign)BOOL isShare;                  ///<是否公开模型

@end

@interface TMXProfileEditOpenStatuModel : NSObject

@property (nonatomic, assign)BOOL isShare;                  ///<是否公开

/**
 *  获取模型公开状态
 *
 *  @param modelId   模型id
 *  @param completion 返回
 */
-(void)FetchTMXProfileEditOpenStatuModel:(NSDictionary *)params
                             callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXProfileEditDeleteModel : NSObject

/**
 *  删除模型
 *
 *  @param userId    用户id
 *  @param modelId   模型id
 *  @param completion 返回
 */
-(void)FetchTMXProfileEditDeleteModel:(NSDictionary *)params
                             callBack:(void(^)(BOOL isSuccess,id result))completion;

@end