//
//  TMXHomeClassifyListModel.h
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMXHomeClassifyListModel : NSObject

@property (nonatomic, assign)NSInteger classifyID;      ///<模型分类id
@property (nonatomic, copy)NSString *name;              ///<分类名称
@property (nonatomic, copy)NSString *faceImg;           ///<分类封面图
@property (nonatomic, assign)NSInteger totalPage;       ///<总个数
@property (nonatomic, strong)NSArray *modelList;

/**
 *  模型分类展览
 *
 *  @param categoryId    分类id，不传或null时为列出全部
 *  @param pageNumber    第几页
 *  @param pageSize      一页显示几个
 *  @param completion 返回
 */
-(void)FetchTMXHomeClassifyListModel:(NSDictionary *)params
                      callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXHomeClassifyListListModel : NSObject

@property (nonatomic, assign)NSInteger classifyListID;       ///<模型id
@property (nonatomic, copy)NSString *name;                   ///<分类名称
@property (nonatomic, copy)NSString *image;                  ///<模型封面图
@property (nonatomic, copy)NSString *ownerName;              ///<模型创造者
@property (nonatomic, copy)NSString *updatedDate;            ///<更新时间
@property (nonatomic, assign)NSInteger favoriteCnt;          ///<收藏次数
@property (nonatomic, assign)NSInteger modelCommentCount;    ///<评论次数
@property (nonatomic, assign)BOOL delFlag;                   ///<删除标识

@end
