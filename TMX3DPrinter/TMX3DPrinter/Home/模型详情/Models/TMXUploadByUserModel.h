//
//  TMXUploadByUserModel.h
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/22.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMXUploadByUserModel : NSObject

@property (nonatomic, strong)NSArray *modelList;        ///<模型列表
@property (nonatomic, assign)NSInteger totalPage;       ///<共有几页

/**
 *  查看用户上传的模型列表
 *
 *  @param pageNumber    第几页
 *  @param pageSize     一页显示几个
 *  @param completion   返回
 */
-(void)FetchTMXUploadByUserModel:(NSDictionary *)params
                   callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXUploadByUserListModel : NSObject

@property (nonatomic, assign)NSInteger modelId;     ///<模型id
@property (nonatomic, copy)NSString *image;         ///<模型预览图
@property (nonatomic, copy)NSString *name;          ///<模型名称
@property (nonatomic, copy)NSString *ownerAvatar;   ///<发布者头像
@property (nonatomic, copy)NSString *ownerName;     ///<发布者昵称
@property (nonatomic, copy)NSString *updatedDate;   ///<更新时间
@property (nonatomic, assign)NSInteger favoriteCnt;     ///<收藏数
@property (nonatomic, assign)NSInteger modelCommentCount;///<评论数

@end
