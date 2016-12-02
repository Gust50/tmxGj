//
//  TMXHomeModel.h
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMXHomeModel : NSObject

@property (nonatomic, strong)NSArray *carouselList;         ///<轮播列表
@property (nonatomic, strong)NSArray *categoryList;         ///<模型分类列表
@property (nonatomic, strong)NSArray *categoryModelList;    ///<分类模型列表


/**
 *  首页
 *
 *  @param pageNumber    第几页
 *  @param pageSize      一页显示几个
 *  @param completion 返回
 */
-(void)FetchTMXHomeModel:(NSDictionary *)params
                      callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXHomeCarouselListModel : NSObject

@property (nonatomic, copy)NSString *image;         ///<轮播图片
@property (nonatomic, copy)NSString *url;           ///<点击图片跳转url

@end

@interface TMXHomeCategoryListModel : NSObject

@property (nonatomic, assign)NSInteger categoryID;  ///<分类id
@property (nonatomic, copy)NSString *name;          ///<分类名称
@property (nonatomic, copy)NSString *bigIcon;       ///<分类大图标

@end

@interface TMXHomeCategoryModelListModel : NSObject

@property (nonatomic, assign)NSInteger categoryModelID;  ///<分类id
@property (nonatomic, copy)NSString *name;               ///<分类名称
@property (nonatomic, copy)NSString *faceImg;            ///<分类封面图
@property (nonatomic, copy)NSString *smallIcon;          ///<分类小图标
@property (nonatomic, strong)NSArray *modelList; ///<分类模型列表

@end

@interface TMXHomeCategoryModelListListModel : NSObject

@property (nonatomic, assign)NSInteger listListID;          ///<模型id
@property (nonatomic, copy)NSString *image;                 ///<模型封面图
@property (nonatomic, copy)NSString *name;                  ///<模型名称
@property (nonatomic, copy)NSString *ownerName;             ///<模型创造者
@property (nonatomic, copy)NSString *updatedDate;           ///<更新时间
@property (nonatomic, assign)BOOL delFlag;                 ///<删除标识
@property (nonatomic, assign)NSInteger favoriteCnt;         ///<收藏次数
@property (nonatomic, assign)NSInteger modelCommentCount;   ///<评论次数

@end
