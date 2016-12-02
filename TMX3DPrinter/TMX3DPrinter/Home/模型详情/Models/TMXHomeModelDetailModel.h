//
//  TMXHomeModelDetailModel.h
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMXHomeModelDetailModel : NSObject
@property (nonatomic, assign)NSInteger detailID;            ///<模型id
@property (nonatomic, assign)BOOL isProblem;               ///<是否问题模型
@property (nonatomic, copy)NSString *image;                 ///<模型预览图
@property (nonatomic, copy)NSString *name;                  ///<模型名称
@property (nonatomic, copy)NSString *intruduction;          ///<介绍
@property (nonatomic, assign)NSInteger ownerId;             ///<发布者id
@property (nonatomic, copy)NSString *ownerAvatar;           ///<发布者头像
@property (nonatomic, copy)NSString *ownerName;             ///<发布者昵称
@property (nonatomic, copy)NSString *updatedDate;           ///<更新时间
@property (nonatomic, assign)NSInteger viewCnt;             ///<浏览数
@property (nonatomic, assign)NSInteger upvoteCnt;           ///<喜欢数
@property (nonatomic, assign)NSInteger favoriteCnt;         ///<收藏数
@property (nonatomic, assign)NSInteger modelCommentCount;   ///<评论数
@property (nonatomic, assign)BOOL isUpvoteModel;           ///<是否已喜欢
@property (nonatomic, assign)BOOL isFavoriteModel;         ///<是否已收藏
@property (nonatomic, strong)NSArray *imageList;            ///<模型图片列表
@property (nonatomic, strong)NSArray *stlFileList;          ///<模型文件列表
@property (nonatomic, strong)NSArray *modelCommentList;     ///<模型评论（前10条）


/**
 *  模型详情
 *
 *  @param modelId    模型id
 *  @param userId     用户id，登录后用户必传，未登录不用传值
 *  @param completion 返回
 */
-(void)FetchTMXHomeModelDetailModel:(NSDictionary *)params
                      callBack:(void(^)(BOOL isSuccess,id result))completion;

@end


/**
 *  文件列表
 */
@interface TMXHomeModelDetailFileListModel : NSObject

@property (nonatomic, assign)NSInteger fileId;              ///<文件id
@property (nonatomic, copy)NSString *fileSize;              ///<文件大小
@property (nonatomic, copy)NSString *fileName;              ///<文件名
@property (nonatomic, copy)NSString *image;                 ///<预览图地址
@property (nonatomic, copy)NSString *latestPrintDate;       ///<最新打印时间
@property (nonatomic, copy)NSString *filamentUsed;          ///<耗材
@property (nonatomic, copy)NSString *fileUrl;               ///<stl文件地址
@property (nonatomic, copy)NSString *printTime;             ///<耗时

@end



/**
 *  评论列表
 */
@interface TMXHomeModelDetailCommentMainListModel : NSObject

@property (nonatomic, assign)NSInteger commentId;           ///<评论id
@property (nonatomic, assign)NSInteger modelId;             ///<模型id
@property (nonatomic, copy)NSString *comment;               ///<评论内容
@property (nonatomic, copy)NSString *createdDate;           ///<创建时间
@property (nonatomic, copy)NSString *userName;              ///<用户名
@property (nonatomic, copy)NSString *userAvatar;            ///<用户头像
@property (nonatomic, strong) NSArray *commentReplyList;    ///<二级评论

@end

/**
 *  评论列表的二级评论
 */
@interface  TMXHomeModelDetailCommentSubListModel: NSObject

@property (nonatomic, copy) NSString *comment;
@property (nonatomic, assign) NSInteger commentId;
@property (nonatomic, copy) NSString *createdDate;
@property (nonatomic, assign) NSInteger fromUserId;
@property (nonatomic, copy) NSString *fromUserName;
@property (nonatomic, assign) NSInteger replyId;
@property (nonatomic, assign) NSInteger toUserId;
@property (nonatomic, copy) NSString *toUserName;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, strong) NSArray *repliesList;

@end

/**
 *  评论列表三级评论
 */
@interface TMXHomeModelDetailCommentListModel : NSObject

@property (nonatomic, copy) NSString *comment;
@property (nonatomic, assign) NSInteger commentId;
@property (nonatomic, copy) NSString *createdDate;
@property (nonatomic, assign) NSInteger fromUserId;
@property (nonatomic, copy) NSString *fromUserName;
@property (nonatomic, assign) NSInteger replyId;
@property (nonatomic, assign) NSInteger toUserId;
@property (nonatomic, copy) NSString *toUserName;

@end

@interface TMXHomeCollectModel : NSObject

/**
 *  收藏模型
 *
 *  @param modelId    模型id
 *  @param userId     用户id
 *  @param completion 返回
 */
-(void)FetchTMXHomeCollectModel:(NSDictionary *)params
                           callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXHomeLikeModel : NSObject

/**
 *  喜欢模型
 *
 *  @param modelId    模型id
 *  @param userId     用户id
 *  @param completion 返回
 */
-(void)FetchTMXHomeLikeModel:(NSDictionary *)params
                       callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXHomeCancelCollectModel : NSObject

/**
 *  取消收藏模型
 *
 *  @param modelId    模型id
 *  @param userId     用户id
 *  @param completion 返回
 */
-(void)FetchTMXHomeCancelCollectModel:(NSDictionary *)params
                       callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXHomeCancelLikeModel : NSObject

/**
 *  取消喜欢模型
 *
 *  @param modelId    模型id
 *  @param userId     用户id
 *  @param completion 返回
 */
-(void)FetchTMXHomeCancelLikeModel:(NSDictionary *)params
                    callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXHomeAddReviewModel : NSObject

/**
 *  提交评论
 *
 *  @param modelId    模型id
 *  @param userId     用户id
 *  @param comment    评论内容
 *  @param type       1为评论，2为问题反馈
 *  @param completion 返回
 */
-(void)FetchTMXHomeAddReviewModel:(NSDictionary *)params
                          callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXHomeCommentReplyModel : NSObject

/**
 *  评论回复
 *
 *  @param commentId  模型评论id
 *  @param userId     用户id
 *  @param comment    评论内容
 *  @param toUserId   被回复人ID（对模型评论进行评论时此值不传，对评论的回复进行回复时传）
 *  @param parentId   回复id（对模型评论进行评论时此值不传，对评论的回复进行回复时传）
 *  @param completion 返回
 */
-(void)FetchTMXHomeAddReviewModel:(NSDictionary *)params
                         callBack:(void(^)(BOOL isSuccess,id result))completion;

@end