//
//  TMXFeedbackModel.h
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/20.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMXFeedbackModel : NSObject

@property (nonatomic, strong)NSArray *modelList;
@property (nonatomic, assign)NSInteger totalRows;
@property (nonatomic, assign)NSInteger pageNumber;
@property (nonatomic, assign)NSInteger pageSize;


/**
 *  模型意见反馈列表
 *
 *  @param pageNumber    第几页
 *  @param pageSize      一页显示几个
 *  @param modelId       模型id
 *  @param completion 返回
 */
-(void)FetchTMXFeedbackModel:(NSDictionary *)params
                      callBack:(void(^)(BOOL isSuccess,id result))completion;
@end

@interface TMXFeedbackListModel : NSObject

@property (nonatomic, assign)NSInteger commentId;
@property (nonatomic, assign)NSInteger modelId;
@property (nonatomic, assign)NSInteger userId;
@property (nonatomic, copy)NSString *comment;
@property (nonatomic, copy)NSString *createdDate;
@property (nonatomic, copy)NSString *userName;
@property (nonatomic, copy)NSString *userAvatar;

@end