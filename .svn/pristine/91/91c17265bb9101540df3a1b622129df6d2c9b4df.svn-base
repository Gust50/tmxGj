//
//  TMXReplyMainCell.m
//  TMX3DPrinter
//
//  Created by kobe on 16/9/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXReplyMainCell.h"
#import "TMXReplySubCell.h"
#import "TMXHomeModelDetailModel.h"
#import "TMXAllCommentModel.h"

@interface TMXReplyMainCell ()<UITableViewDelegate, UITableViewDataSource,TMXReplySubCellDelegate>
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UIButton *replyBtn;
@property (nonatomic, strong) UILabel *replyContent;
@property (nonatomic, strong) UILabel *replyUserNameLab;
@property (nonatomic, strong) UIImageView *replyUserNameIcon;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, assign) CGFloat replyContentHeiht;
@property (nonatomic, assign) CGFloat replyUserNameHeight;
@property (nonatomic, assign) CGFloat tableViewHeight;

@property (nonatomic, strong) NSArray *subReplyDataSource;      ///<datasource
@property (nonatomic, strong) NSArray *subReplyAllDataSource;   ///<datasource
@property (nonatomic, assign) BOOL isDisplay;
@property (nonatomic, assign) BOOL isAllDisplay;
@end

@implementation TMXReplyMainCell
static NSString *const replySubID=@"replySubID";

#pragma mark <lazyLoad>
-(UIImageView *)icon{
    if (!_icon) {
        _icon=[UIImageView new];
        _icon.layer.masksToBounds=YES;
        _icon.layer.cornerRadius=40*AppScale/2.0;
    }
    return _icon;
}

-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab=[UILabel new];
//        _nameLab.text=@"天马行空";
        _nameLab.font = [UIFont systemFontOfSize:13*AppScale];
    }
    return _nameLab;
}

-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab=[UILabel new];
//        _timeLab.text = @"08-08 12：30";
        _timeLab.font = [UIFont systemFontOfSize:11*AppScale];
        _timeLab.textColor = [UIColor lightGrayColor];
    }
    return _timeLab;
}

-(UIButton *)replyBtn{
    if (!_replyBtn) {
        _replyBtn=[UIButton buttonWithType:0];
        NSString *_reply = NSLocalizedString(@"Reply", nil);
        [_replyBtn setTitle:_reply forState:0];
        [_replyBtn setTitleColor:RGBColor(234, 97, 1) forState:0];
        [_replyBtn addTarget:self action:@selector(replyMainBtn:) forControlEvents:UIControlEventTouchUpInside];
        _replyBtn.titleLabel.font = [UIFont systemFontOfSize:12*AppScale];
        
    }
    return _replyBtn;
}
-(UILabel *)replyContent{
    if (!_replyContent) {
        _replyContent=[UILabel new];
//        _replyContent.text = @"科技十多个hi乱说的卡号发来绿山咖啡局；欧尼";
        _replyContent.font = [UIFont systemFontOfSize:12*AppScale];
        _replyContent.numberOfLines=0;
    }
    return _replyContent;
}

-(UILabel *)replyUserNameLab{
    if (!_replyUserNameLab) {
        _replyUserNameLab=[UILabel new];
        _replyUserNameLab.font = [UIFont systemFontOfSize:11*AppScale];
        _replyUserNameLab.numberOfLines = 0;
    }
    return _replyUserNameLab;
}

-(UIImageView *)replyUserNameIcon{
    if (!_replyUserNameIcon) {
        _replyUserNameIcon=[UIImageView new];
        _replyUserNameIcon.image=[UIImage imageNamed:@"CommentBackIcon"];
    }
    return _replyUserNameIcon;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.showsHorizontalScrollIndicator=NO;
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.scrollEnabled=NO;
    }
    return _tableView;
}

-(UIView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine=[UIView new];
        _bottomLine.backgroundColor=[UIColor lightGrayColor];
    }
    return _bottomLine;
}

-(NSArray *)subReplyDataSource{
    if (!_subReplyDataSource) {
        _subReplyDataSource=[NSArray array];
    }
    return _subReplyDataSource;
}

-(NSArray *)subReplyAllDataSource{
    if (!_subReplyAllDataSource) {
        _subReplyAllDataSource=[NSArray array];
    }
    return _subReplyAllDataSource;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        
        self.replyContentHeiht=0.0;
        self.tableViewHeight=0.0;
        self.replyUserNameHeight=0.0;
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.icon];
    [self addSubview:self.nameLab];
    [self addSubview:self.timeLab];
    [self addSubview:self.replyBtn];
    [self addSubview:self.replyContent];
    
    //如果存在二级评论
    if (self.isAllComment) {
        if (_isAllDisplay) {
            
            [self addSubview:self.replyUserNameLab];
            [self addSubview:self.replyUserNameIcon];
            [self addSubview:self.tableView];
            [_tableView registerClass:[TMXReplySubCell class] forCellReuseIdentifier:replySubID];
            _tableView.tableFooterView=[UIView new];
        }
    }else
    {
        if (_isDisplay) {
            
            [self addSubview:self.replyUserNameLab];
            [self addSubview:self.replyUserNameIcon];
            [self addSubview:self.tableView];
            [_tableView registerClass:[TMXReplySubCell class] forCellReuseIdentifier:replySubID];
            _tableView.tableFooterView=[UIView new];
        }
    }
    
    [self updateConstraints];
}


#pragma mark <UITableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.isAllComment) {
        return _subReplyAllDataSource.count;
    }else
    {
        return _subReplyDataSource.count;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TMXReplySubCell *subCell=[tableView dequeueReusableCellWithIdentifier:replySubID forIndexPath:indexPath];
    subCell.selectionStyle = UITableViewCellSelectionStyleNone;
    subCell.delegate=self;
    if (self.isAllComment) {
        TMXCommentReplyListModel *subMoel=_subReplyAllDataSource[indexPath.row];
        
        subCell.isAllComment = YES;
        subCell.replyListModel=subMoel;
    }else
    {
        TMXHomeModelDetailCommentSubListModel *subMoel=_subReplyDataSource[indexPath.row];
        subCell.isAllComment = NO;
        subCell.subRelyModel=subMoel;
    }
    return subCell;
}

#pragma mark <UITableViewDelegate>

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isAllComment) {
        TMXCommentReplyListModel *subMoel=_subReplyAllDataSource[indexPath.row];
        return [self caculatorSubAllCellHeight:subMoel];
    }else
    {
        TMXHomeModelDetailCommentSubListModel *subMoel=_subReplyDataSource[indexPath.row];
        return [self caculatorSubCellHeight:subMoel];
    }
}

//计算当前cell的高度
-(CGFloat)caculatorSubCellHeight:(TMXHomeModelDetailCommentSubListModel *)model{
    
    //二级评论的最大宽度
    CGFloat maxWidth=SCREENWIDTH-65*AppScale;

    //1.计算二级评论内容的高度
    CGFloat subReplyContentHeight=0.0;
    subReplyContentHeight=[NSString sizeWithStr:model.comment
                                           font:[UIFont systemFontOfSize:14]
                                          width:maxWidth].height;
    //2.计算三级评论的高度
    if (model.repliesList.count!=0) {
        CGFloat commonReplyCellHeiht=0.0;
        for (TMXHomeModelDetailCommentListModel *commonListModel in model.repliesList) {
            NSString *commonReplycontent=[NSString stringWithFormat:@"%@@%@:%@",commonListModel.fromUserName,commonListModel.toUserName,commonListModel.comment];
            commonReplyCellHeiht+=[NSString sizeWithStr:commonReplycontent
                                         font:[UIFont systemFontOfSize:14]
                                        width:maxWidth].height;
        }
        //返回二级评论的高度
        return subReplyContentHeight+60*AppScale+commonReplyCellHeiht;
    }else{
        
        //返回二级评论的高度
        return subReplyContentHeight+60*AppScale;
    }
}

//计算全部评论cell的高度
- (CGFloat)caculatorSubAllCellHeight:(TMXCommentReplyListModel *)model
{
    //二级评论的最大宽度
    CGFloat maxWidth=SCREENWIDTH-65*AppScale;
    
    //1.计算二级评论内容的高度
    CGFloat subReplyContentHeight=0.0;
    subReplyContentHeight=[NSString sizeWithStr:model.comment
                                           font:[UIFont systemFontOfSize:14]
                                          width:maxWidth].height;
    //2.计算三级评论的高度
    if (model.repliesList.count!=0) {
        CGFloat commonReplyCellHeiht=0.0;
        for (TMXRepliesListModel *commonListModel in model.repliesList) {
            NSString *commonReplycontent=[NSString stringWithFormat:@"%@@%@:%@",commonListModel.fromUserName,commonListModel.toUserName,commonListModel.comment];
            commonReplyCellHeiht+=[NSString sizeWithStr:commonReplycontent
                                                   font:[UIFont systemFontOfSize:14]
                                                  width:maxWidth].height;
        }
        //返回二级评论的高度
        return subReplyContentHeight+60*AppScale+commonReplyCellHeiht;
    }else{
        
        //返回二级评论的高度
        return subReplyContentHeight+60*AppScale;
    }
}

#pragma mark <TMXReplySubCellDelegate>
-(void)replySubCell:(TMXHomeModelDetailCommentSubListModel *)model{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(replySubCellToMainCell:)]) {
        [self.delegate replySubCellToMainCell:model];
    }
    
}

-(void)replyCommonCellToSubCell:(TMXHomeModelDetailCommentListModel *)model subReplyID:(NSString *)subReplyID{
    if (self.delegate && [self.delegate respondsToSelector:@selector(replyCommonCellToMainCell:subReplyID:)]) {
        [self.delegate replyCommonCellToMainCell:model subReplyID:subReplyID];
    }
}
//全部评论
-(void)replyAllSubCell:(TMXCommentReplyListModel *)model
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(replyAllSubCellToMainCell:)]) {
        [self.delegate replyAllSubCellToMainCell:model];
    }
}

-(void)replyAllCommonCellToSubCell:(TMXRepliesListModel *)model
                        subReplyID:(NSString *)subReplyID
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(replyAllCommonCellToMainCell:subReplyID:)]) {
        [self.delegate replyAllCommonCellToMainCell:model subReplyID:subReplyID];
    }
}

-(void)replyMainBtn:(UIButton *)btn{
    if (self.isAllComment) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(replyAllMainCell:)]) {
            [self.delegate replyAllMainCell:_modelListModel];
        }
    }else
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(replyMainCell:)]) {
            [self.delegate replyMainCell:_mainReplyModel];
        }
    }
    
}

-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    
    //top
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(5*AppScale);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(40*AppScale, 40*AppScale));
    }];
    
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_icon.mas_top);
        make.left.equalTo(_icon.mas_right).with.offset(5*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];;
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_icon.mas_bottom);
        make.left.equalTo(_icon.mas_right).with.offset(5*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
    [_replyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_icon.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.size.mas_equalTo(CGSizeMake(60*AppScale, 30*AppScale));
    }];
    
    //content
    [_replyContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_icon.mas_bottom).with.offset(5*AppScale);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
    }];
    [_replyContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(_replyContentHeiht));
    }];
    if (self.isAllComment) {
        if (_isAllDisplay) {
            //replyUserNameContent
            [_replyUserNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_replyContent.mas_bottom).with.offset(5*AppScale);
                make.left.equalTo(_replyUserNameIcon.mas_right).with.offset(10*AppScale);
                make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
            }];
            
            [_replyUserNameLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(@(_replyUserNameHeight));
            }];
            
            [_replyUserNameIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_replyContent.mas_bottom).with.offset(9*AppScale);
                make.left.equalTo(weakSelf.mas_left).with.offset(12*AppScale);
                make.size.mas_equalTo(CGSizeMake(12*AppScale, 12*AppScale));
            }];
            
            //tableView
            [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_replyUserNameLab.mas_bottom).with.offset(10*AppScale);
                make.left.equalTo(weakSelf.mas_left).with.offset(0);
                make.right.equalTo(weakSelf.mas_right).with.offset(0);
            }];
            
            [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(@(_tableViewHeight));
            }];
        }
    }else
    {
        if (_isDisplay) {
            //replyUserNameContent
            [_replyUserNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_replyContent.mas_bottom).with.offset(5*AppScale);
                make.left.equalTo(_replyUserNameIcon.mas_right).with.offset(10*AppScale);
                make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
            }];
            
            [_replyUserNameLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(@(_replyUserNameHeight));
            }];
            
            [_replyUserNameIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_replyContent.mas_bottom).with.offset(9*AppScale);
                make.left.equalTo(weakSelf.mas_left).with.offset(12*AppScale);
                make.size.mas_equalTo(CGSizeMake(12*AppScale, 12*AppScale));
            }];
            
            //tableView
            [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_replyUserNameLab.mas_bottom).with.offset(10*AppScale);
                make.left.equalTo(weakSelf.mas_left).with.offset(0);
                make.right.equalTo(weakSelf.mas_right).with.offset(0);
            }];
            
            [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(@(_tableViewHeight));
            }];
        }
    }
    
}

#pragma mark  <getter setter>
-(void)setMainReplyModel:(TMXHomeModelDetailCommentMainListModel *)mainReplyModel{
    
    [self removeAllSuperView];
    _mainReplyModel=mainReplyModel;
    [_icon sd_setImageWithURL:[NSURL URLWithString:mainReplyModel.userAvatar] placeholderImage:nil];
    _nameLab.text=mainReplyModel.userName;
    _replyContent.text=mainReplyModel.comment;
    NSDate *date = [[KBDateFormatter shareInstance]dateFromTimeInterval:([mainReplyModel.createdDate doubleValue]/1000.0)];
    _timeLab.text = [NSDate caculatorTime:date];
    [self caculatorHeight:_mainReplyModel];

}

- (void)setIsAllComment:(BOOL)isAllComment
{
    _isAllComment = isAllComment;
    [self.tableView reloadData];
}

-(void)setModelListModel:(TMXModelListModel *)modelListModel
{
    [self removeAllSuperView];
    _modelListModel = modelListModel;
    [_icon sd_setImageWithURL:[NSURL URLWithString:modelListModel.userAvatar] placeholderImage:nil];
    _nameLab.text=modelListModel.userName;
    _replyContent.text=modelListModel.comment;
    NSDate *date = [[KBDateFormatter shareInstance]dateFromTimeInterval:([modelListModel.createdDate doubleValue]/1000.0)];
    _timeLab.text = [NSDate caculatorTime:date];
    [self caculatorAllHeight:modelListModel];
}

-(void)removeAllSuperView{
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UILabel class]] || [view isKindOfClass:[UIImageView class]] || [view isKindOfClass:[UIButton class]] || [view isKindOfClass:[UITableView class]]) {
            [view removeFromSuperview];
        }
    }
}

//计算二级评论的高度
-(void)caculatorHeight:(TMXHomeModelDetailCommentMainListModel *)model{
    
    //1.计算一级评论内容的高度
    _replyContentHeiht=[NSString sizeWithStr:model.comment
                                        font:[UIFont systemFontOfSize:14]
                                       width:SCREENWIDTH-20].height;
    //计算二级评论的高度
    if (model.commentReplyList.count!=0) {
        CGFloat replySubCellHeight=0.0;
        NSString *replyUserNameStr;
        NSInteger tempCount=0;
        self.subReplyDataSource=model.commentReplyList;
        
        for (TMXHomeModelDetailCommentSubListModel *tempModel in model.commentReplyList) {
            if (tempCount<5) {
                if (tempCount==0) {
                    replyUserNameStr=tempModel.fromUserName;
                }else{
                    replyUserNameStr=[NSString stringWithFormat:@"%@、%@",tempModel.fromUserName,replyUserNameStr];
                }
                tempCount++;
            }
            //计算二级评论内容的高度
            CGSize size=[NSString sizeWithStr:tempModel.comment
                                         font:[UIFont systemFontOfSize:14]
                                        width:SCREENWIDTH-65*AppScale];
            
            //计算三级评论的高度
            if (tempModel.repliesList.count!=0) {
                CGFloat temp=0.0;
                for (TMXHomeModelDetailCommentListModel *commonTempModel in tempModel.repliesList) {
                    NSString *replyContentStr=[NSString stringWithFormat:@"%@@%@:%@",commonTempModel.fromUserName,commonTempModel.toUserName,commonTempModel.comment];
                    //caculator replyContent hight
                    CGSize size=[NSString sizeWithStr:replyContentStr
                                                 font:[UIFont systemFontOfSize:14]
                                                width:SCREENWIDTH-65*AppScale];
                    temp+=size.height;
                }
                replySubCellHeight+=size.height+temp+60*AppScale;
            }else{
                replySubCellHeight+=size.height+60*AppScale;
            }
        }
        NSString *wait = NSLocalizedString(@"Wait", nil);
        replyUserNameStr=[NSString stringWithFormat:@"%@%@",replyUserNameStr, wait];
        _replyUserNameHeight=[NSString sizeWithStr:replyUserNameStr
                                              font:[UIFont systemFontOfSize:13*AppScale]
                                             width:SCREENWIDTH-20-12*AppScale].height;
        NSMutableAttributedString *text=[[NSMutableAttributedString alloc]initWithString:replyUserNameStr];
        [text addAttribute:NSForegroundColorAttributeName
                     value:systemColor
                     range:NSMakeRange(0,replyUserNameStr.length-7)];
        _tableViewHeight=replySubCellHeight;
        self.isDisplay=YES;
        //重新布局
        [self initUI];
        [_tableView reloadData];
        _replyUserNameLab.attributedText=text;
        
    }
    else{
        self.isDisplay=NO;
        [self initUI];
    }
}

//计算所有评论二级评论的高度
-(void)caculatorAllHeight:(TMXModelListModel *)model
{
    //1.计算一级评论内容的高度
    _replyContentHeiht=[NSString sizeWithStr:model.comment
                                        font:[UIFont systemFontOfSize:14]
                                       width:SCREENWIDTH-20].height;
    //计算二级评论的高度
    if (model.commentReplyList.count!=0) {
        CGFloat replySubCellHeight=0.0;
        NSString *replyUserNameStr;
        NSInteger tempCount=0;
        self.subReplyAllDataSource=model.commentReplyList;
        
        for (TMXCommentReplyListModel *tempModel in model.commentReplyList) {
            if (tempCount<5) {
                if (tempCount==0) {
                    replyUserNameStr=tempModel.fromUserName;
                }else{
                    replyUserNameStr=[NSString stringWithFormat:@"%@、%@",tempModel.fromUserName,replyUserNameStr];
                }
                tempCount++;
            }
            //计算二级评论内容的高度
            CGSize size=[NSString sizeWithStr:tempModel.comment
                                         font:[UIFont systemFontOfSize:14]
                                        width:SCREENWIDTH-65*AppScale];
            
            //计算三级评论的高度
            if (tempModel.repliesList.count!=0) {
                CGFloat temp=0.0;
                for (TMXRepliesListModel *commonTempModel in tempModel.repliesList) {
                    NSString *replyContentStr=[NSString stringWithFormat:@"%@@%@:%@",commonTempModel.fromUserName,commonTempModel.toUserName,commonTempModel.comment];
                    //caculator replyContent hight
                    CGSize size=[NSString sizeWithStr:replyContentStr
                                                 font:[UIFont systemFontOfSize:14]
                                                width:SCREENWIDTH-65*AppScale];
                    temp+=size.height;
                }
                replySubCellHeight+=size.height+temp+60*AppScale;
            }else{
                replySubCellHeight+=size.height+60*AppScale;
            }
        }
        NSString *wait = NSLocalizedString(@"Wait", nil);
        replyUserNameStr=[NSString stringWithFormat:@"%@%@",replyUserNameStr, wait];
        _replyUserNameHeight=[NSString sizeWithStr:replyUserNameStr
                                              font:[UIFont systemFontOfSize:13*AppScale]
                                             width:SCREENWIDTH-20-12*AppScale].height;
        NSMutableAttributedString *text=[[NSMutableAttributedString alloc]initWithString:replyUserNameStr];
        [text addAttribute:NSForegroundColorAttributeName
                     value:systemColor
                     range:NSMakeRange(0,replyUserNameStr.length-7)];
        _tableViewHeight=replySubCellHeight;
        self.isAllDisplay=YES;
        //重新布局
        [self initUI];
        [_tableView reloadData];
        _replyUserNameLab.attributedText=text;
        
    }
    else{
        self.isAllDisplay=NO;
        [self initUI];
    }
}

@end
