//
//  TMXReplyCommonCell.h
//  TMX3DPrinter
//
//  Created by kobe on 16/9/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMXHomeModelDetailCommentListModel, TMXRepliesListModel;

@protocol TMXReplyCommonCellDelegate <NSObject>
-(void)replyCommonCell:(TMXHomeModelDetailCommentListModel *)model
            subReplyID:(NSString *)subReplyID;      ///<三级评论回复代理

-(void)replyAllCommonCell:(TMXRepliesListModel *)model
            subReplyID:(NSString *)subReplyID;      ///<三级全部评论回复代理
@end

@interface TMXReplyCommonCell : UITableViewCell
@property (nonatomic, strong) TMXHomeModelDetailCommentListModel *commonReplyModel;  ///<三级评论模型数据
@property (nonatomic, strong) TMXRepliesListModel *listModel;               ///<全部评论三级评价

@property (nonatomic, weak) id<TMXReplyCommonCellDelegate>delegate;
@property (nonatomic, strong)NSString *subReplyID;        ///<二级评论ID

@property (nonatomic, assign)BOOL isAllComment;     ///<是否是全部评论

@end
