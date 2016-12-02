//
//  TMXAllCommentModel.h
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/19.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMXAllCommentModel : NSObject

@property (nonatomic, strong)NSArray *modelList;        ///<模型评论一级
@property (nonatomic, assign)NSInteger pageNumber;      ///<页码
@property (nonatomic, assign)NSInteger pageSize;        ///<一页多少行
@property (nonatomic, assign)NSInteger totalRows;       ///<总记录数

/**
 *  全部评论
 *
 *  @param pageNumber    第几页
 *  @param pageSize      一页显示几个
 *  @param modelId       模型id
 *  @param completion 返回
 */
-(void)FetchTMXAllCommentModel:(NSDictionary *)params
                callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXModelListModel : NSObject

@property (nonatomic, copy)NSString *comment;           ///<评论内容
@property (nonatomic, assign)NSInteger commentId;       ///<评论id
@property (nonatomic, copy)NSString *createdDate;       ///<创建时间
@property (nonatomic, assign)NSInteger modelId;         ///<模型id
@property (nonatomic, copy)NSString *userAvatar;        ///<评论人头像
@property (nonatomic, copy)NSString *userName;          ///<评论人名称
@property (nonatomic, assign)NSInteger userId;          ///<用户id
@property (nonatomic, strong)NSArray *commentReplyList; ///<模型评论回复（二级）


@end

@interface TMXCommentReplyListModel : NSObject

@property (nonatomic, copy)NSString *comment;           ///<评论内容
@property (nonatomic, assign)NSInteger commentId;       ///<评论id
@property (nonatomic, copy)NSString *createdDate;       ///<创建时间
@property (nonatomic, copy)NSString *avatar;            ///<评论人头像
@property (nonatomic, copy)NSString *fromUserName;      ///<评论人名称
@property (nonatomic, assign)NSInteger fromUserId;
@property (nonatomic, assign)NSInteger replyId;         ///<id
@property (nonatomic, strong)NSArray *repliesList;      ///<三级评论回复（三级）

@end

@interface TMXRepliesListModel : NSObject

@property (nonatomic, copy)NSString *comment;           ///<内容
@property (nonatomic, assign)NSInteger commentId;       ///<顶级id
@property (nonatomic, copy)NSString *createdDate;       ///<创建时间
@property (nonatomic, copy)NSString *toUserName;        ///<被回复人用户名
@property (nonatomic, copy)NSString *fromUserName;      ///<回复人用户名
@property (nonatomic, assign)NSInteger fromUserId;      ///<回复人id
@property (nonatomic, assign)NSInteger replyId;         ///<id
@property (nonatomic, assign)NSInteger toUserId;        ///<被回复人id

@end