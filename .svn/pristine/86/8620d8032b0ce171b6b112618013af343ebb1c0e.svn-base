//
//  TMXReplyCommonCell.m
//  TMX3DPrinter
//
//  Created by kobe on 16/9/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXReplyCommonCell.h"
#import "TMXHomeModelDetailModel.h"
#import "TMXAllCommentModel.h"

@interface TMXReplyCommonCell ()
@property (nonatomic, strong) UILabel *replyLab;
@property (nonatomic, assign) CGFloat replyHeight;
@end

@implementation TMXReplyCommonCell

#pragma mark <lazyLoad>
-(UILabel *)replyLab{
    if (!_replyLab) {
        _replyLab=[UILabel new];
        _replyLab.font=[UIFont systemFontOfSize:12*AppScale];
        _replyLab.textAlignment=NSTextAlignmentLeft;
        _replyLab.numberOfLines=0;
        _replyLab.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
        [_replyLab addGestureRecognizer:tap];
    }
    return _replyLab;
}

#pragma mark <init>
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    self.replyHeight=0.0;
    [self addSubview:self.replyLab];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    [_replyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf.mas_top);
    }];
}

#pragma mark <otherResponse>
-(void)tapGesture:(UITapGestureRecognizer *)gesture{
    if (self.isAllComment) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(replyAllCommonCell:subReplyID:)]) {
            [self.delegate replyAllCommonCell:_listModel subReplyID:_subReplyID];
        }
    }else
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(replyCommonCell:subReplyID:)]) {
            [self.delegate replyCommonCell:_commonReplyModel subReplyID:_subReplyID];
        }
    }
}

#pragma mark <getter setter>
-(void)setCommonReplyModel:(TMXHomeModelDetailCommentListModel *)commonReplyModel{
    
    _commonReplyModel=commonReplyModel;
    NSString *replyContentStr=[NSString stringWithFormat:@"%@@%@:%@",commonReplyModel.fromUserName,commonReplyModel.toUserName,commonReplyModel.comment];
    
    NSMutableAttributedString *text=[[NSMutableAttributedString alloc]initWithString:replyContentStr];
    [text addAttribute:NSForegroundColorAttributeName
                 value:systemColor
                 range:NSMakeRange(0, commonReplyModel.fromUserName.length)];
    [text addAttribute:NSForegroundColorAttributeName
                 value:systemColor
                 range:NSMakeRange(commonReplyModel.fromUserName.length+1, commonReplyModel.toUserName.length)];
    _replyLab.attributedText=text;
    
    CGSize size=[NSString sizeWithStr:replyContentStr
                                 font:[UIFont systemFontOfSize:14]
                                width:SCREENWIDTH-65*AppScale];
    _replyHeight=size.height;
    
    [_replyLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_replyHeight);
    }];
}

//全部评论
-(void)setListModel:(TMXRepliesListModel *)listModel
{
    _listModel = listModel;
    NSString *replyContentStr=[NSString stringWithFormat:@"%@@%@:%@",listModel.fromUserName,listModel.toUserName,listModel.comment];
    
    NSMutableAttributedString *text=[[NSMutableAttributedString alloc]initWithString:replyContentStr];
    [text addAttribute:NSForegroundColorAttributeName
                 value:systemColor
                 range:NSMakeRange(0, listModel.fromUserName.length)];
    [text addAttribute:NSForegroundColorAttributeName
                 value:systemColor
                 range:NSMakeRange(listModel.fromUserName.length+1, listModel.toUserName.length)];
    _replyLab.attributedText=text;
    
    CGSize size=[NSString sizeWithStr:replyContentStr
                                 font:[UIFont systemFontOfSize:14]
                                width:SCREENWIDTH-65*AppScale];
    _replyHeight=size.height;
    
    [_replyLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_replyHeight);
    }];
}

-(void)setIsAllComment:(BOOL)isAllComment
{
    _isAllComment = isAllComment;
}

-(void)setSubReplyID:(NSString *)subReplyID{
    _subReplyID=subReplyID;
}

@end
