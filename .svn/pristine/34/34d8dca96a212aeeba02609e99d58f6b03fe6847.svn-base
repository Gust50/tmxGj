//
//  TMXReplySubCell.h
//  TMX3DPrinter
//
//  Created by kobe on 16/9/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TMXHomeModelDetailCommentSubListModel,TMXHomeModelDetailCommentListModel, TMXCommentReplyListModel, TMXRepliesListModel;

@protocol  TMXReplySubCellDelegate<NSObject>
-(void)replySubCell:(TMXHomeModelDetailCommentSubListModel *)model;
-(void)replyCommonCellToSubCell:(TMXHomeModelDetailCommentListModel *)model
                     subReplyID:(NSString *)subReplyID;
//全部评论
-(void)replyAllSubCell:(TMXCommentReplyListModel *)model;
-(void)replyAllCommonCellToSubCell:(TMXRepliesListModel *)model
                     subReplyID:(NSString *)subReplyID;

@end

@interface TMXReplySubCell : UITableViewCell

@property (nonatomic, strong) TMXHomeModelDetailCommentSubListModel *subRelyModel;     ///<二级评论模型数据
@property (nonatomic, strong) TMXCommentReplyListModel *replyListModel;                ///<全部评论二级评论
@property (nonatomic, assign)BOOL isAllComment;     ///<是否是全部评论

@property (nonatomic, weak) id<TMXReplySubCellDelegate>delegate;

@end
