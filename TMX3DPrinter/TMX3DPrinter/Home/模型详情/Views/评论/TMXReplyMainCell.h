//
//  TMXReplyMainCell.h
//  TMX3DPrinter
//
//  Created by kobe on 16/9/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TMXHomeModelDetailCommentMainListModel,TMXHomeModelDetailCommentSubListModel,TMXHomeModelDetailCommentListModel, TMXModelListModel, TMXCommentReplyListModel, TMXRepliesListModel;

@protocol  TMXReplyMainCellDelegate<NSObject>
-(void)replyMainCell:(TMXHomeModelDetailCommentMainListModel *)model;
-(void)replyCommonCellToMainCell:(TMXHomeModelDetailCommentListModel *)model
                      subReplyID:(NSString *)subReplyID;
-(void)replySubCellToMainCell:(TMXHomeModelDetailCommentSubListModel *)model;

-(void)replyAllMainCell:(TMXModelListModel *)model;
-(void)replyAllCommonCellToMainCell:(TMXRepliesListModel *)model
                      subReplyID:(NSString *)subReplyID;
-(void)replyAllSubCellToMainCell:(TMXCommentReplyListModel *)model;
@end

@interface TMXReplyMainCell : UITableViewCell

@property (nonatomic, strong) TMXHomeModelDetailCommentMainListModel *mainReplyModel;   ///<一级评论模型
@property (nonatomic, strong)TMXModelListModel *modelListModel;                      ///<全部评价一级评论

@property (nonatomic, weak) id<TMXReplyMainCellDelegate>delegate;

@property (nonatomic, assign)BOOL isAllComment;     ///<是否是全部评论

@end
