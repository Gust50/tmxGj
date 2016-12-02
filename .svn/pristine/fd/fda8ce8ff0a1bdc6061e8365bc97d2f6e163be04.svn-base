//
//  TMXReplySubCell.m
//  TMX3DPrinter
//
//  Created by kobe on 16/9/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXReplySubCell.h"
#import "TMXReplyCommonCell.h"
#import "TMXHomeModelDetailModel.h"
#import "TMXAllCommentModel.h"

@interface TMXReplySubCell ()<UITableViewDelegate,UITableViewDataSource,TMXReplyCommonCellDelegate>
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UIButton *replyBtn;
@property (nonatomic, strong) UILabel *replyContent;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) CGFloat replyContentHeiht;
@property (nonatomic, assign) CGFloat tableViewHeight;

@property (nonatomic, strong) NSArray *commonReplyDataSource;
@property (nonatomic, strong) NSArray *commonReplyAllDataSource;
@property (nonatomic ,assign) BOOL isDisplay;
@property (nonatomic ,assign) BOOL isAllDisplay;
@end

@implementation TMXReplySubCell
static NSString *const replyCommonID=@"replyCommonID";

#pragma mark <lazyLoad>
-(UIImageView *)icon{
    if (!_icon) {
        _icon=[UIImageView new];
        _icon.layer.masksToBounds=YES;
        _icon.layer.cornerRadius=40.0*AppScale/2;
    }
    return _icon;
}

-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab=[UILabel new];
//        _nameLab.text=@"天马行空";
        _nameLab.textColor=systemColor;
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
        [_replyBtn setTitleColor:[UIColor orangeColor] forState:0];
        _replyBtn.titleLabel.font = [UIFont systemFontOfSize:12*AppScale];
        [_replyBtn addTarget:self action:@selector(replyBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _replyBtn;
}
-(UILabel *)replyContent{
    if (!_replyContent) {
        _replyContent=[UILabel new];
//        _replyContent.text = @"科技十多个hi乱说的卡号发来绿山咖啡局；欧尼";
        _replyContent.font = [UIFont systemFontOfSize:12*AppScale];
    }
    return _replyContent;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.showsHorizontalScrollIndicator=NO;
        _tableView.scrollEnabled=NO;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(NSArray *)commonReplyDataSource{
    if (!_commonReplyDataSource) {
        _commonReplyDataSource=[NSArray array];
    }
    return _commonReplyDataSource;
}

-(NSArray *)commonReplyAllDataSource{
    if (!_commonReplyAllDataSource) {
        _commonReplyAllDataSource=[NSArray array];
    }
    return _commonReplyAllDataSource;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initUI];
        //init data
        self.replyContentHeiht=0.0;
        self.tableViewHeight=0.0;
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.icon];
    [self addSubview:self.nameLab];
    [self addSubview:self.timeLab];
    [self addSubview:self.replyBtn];
    [self addSubview:self.replyContent];
    if (self.isAllComment) {
        if (_isAllDisplay) {
            [self addSubview:self.tableView];
            [_tableView registerClass:[TMXReplyCommonCell class] forCellReuseIdentifier:replyCommonID];
            _tableView.tableFooterView=[UIView new];
        }
    }else
    {
        if (_isDisplay) {
            [self addSubview:self.tableView];
            [_tableView registerClass:[TMXReplyCommonCell class] forCellReuseIdentifier:replyCommonID];
            _tableView.tableFooterView=[UIView new];
        }
    }
    
    [self updateConstraints];
}

#pragma mark <UITableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.isAllComment) {
        return _commonReplyAllDataSource.count;
    }else
    {
        return _commonReplyDataSource.count;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TMXReplyCommonCell *commonCell=[tableView dequeueReusableCellWithIdentifier:replyCommonID forIndexPath:indexPath];
    commonCell.selectionStyle = UITableViewCellSelectionStyleNone;
    commonCell.delegate=self;
    if (self.isAllComment) {
        TMXRepliesListModel *tempModel=_commonReplyAllDataSource[indexPath.row];
        commonCell.isAllComment = YES;
        commonCell.listModel=tempModel;
        commonCell.subReplyID=[NSString stringWithFormat:@"%ld",_replyListModel.replyId];
    }else
    {
        TMXHomeModelDetailCommentListModel *tempModel=_commonReplyDataSource[indexPath.row];
        commonCell.isAllComment = NO;
        commonCell.commonReplyModel=tempModel;
        commonCell.subReplyID=[NSString stringWithFormat:@"%ld",_subRelyModel.replyId];
    }
    return commonCell;
}

#pragma mark <UITableViewDelegate>

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isAllComment) {
        TMXRepliesListModel *commonReplyModel=_commonReplyAllDataSource[indexPath.row];
        return [self caculatorCurrentAllHeight:commonReplyModel];
    }else
    {
        TMXHomeModelDetailCommentListModel *commonReplyModel=_commonReplyDataSource[indexPath.row];
        return [self caculatorCurrentHeight:commonReplyModel];
    }
    
}

-(CGFloat)caculatorCurrentHeight:(TMXHomeModelDetailCommentListModel *)model{
    NSString *replyContentStr=[NSString stringWithFormat:@"%@@%@:%@",model.fromUserName,model.toUserName,model.comment];
    //caculator replyContent hight
    CGSize size=[NSString sizeWithStr:replyContentStr
                                 font:[UIFont systemFontOfSize:14]
                                width:SCREENWIDTH-65*AppScale];
    return size.height;
}
//全部评论
-(CGFloat)caculatorCurrentAllHeight:(TMXRepliesListModel *)model{
    NSString *replyContentStr=[NSString stringWithFormat:@"%@@%@:%@",model.fromUserName,model.toUserName,model.comment];
    //caculator replyContent hight
    CGSize size=[NSString sizeWithStr:replyContentStr
                                 font:[UIFont systemFontOfSize:14]
                                width:SCREENWIDTH-65*AppScale];
    return size.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


#pragma mark <TMXReplyCommonCellDelegate>

-(void)replyCommonCell:(TMXHomeModelDetailCommentListModel *)model subReplyID:(NSString *)subReplyID{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(replyCommonCellToSubCell:subReplyID:)]) {
        [self.delegate replyCommonCellToSubCell:model subReplyID:subReplyID];
    }
}

//全部评论
-(void)replyAllCommonCell:(TMXRepliesListModel *)model subReplyID:(NSString *)subReplyID
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(replyAllCommonCellToSubCell:subReplyID:)]) {
        [self.delegate replyAllCommonCellToSubCell:model subReplyID:subReplyID];
    }
}

#pragma mark <otherResponse>
-(void)replyBtn:(UIButton *)btn{
    
    if (self.isAllComment) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(replyAllSubCell:)]) {
            [self.delegate replyAllSubCell:_replyListModel];
        }
    }else
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(replySubCell:)]) {
            [self.delegate replySubCell:_subRelyModel];
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
    }];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_icon.mas_bottom);
        make.left.equalTo(_icon.mas_right).with.offset(5*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
    [_replyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_icon.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.size.mas_equalTo(CGSizeMake(60*AppScale, 20*AppScale));
    }];
    
    //content
    [_replyContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_icon.mas_bottom).with.offset(5*AppScale);
        make.left.equalTo(_icon.mas_right).with.offset(5*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
    }];
    [_replyContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(_replyContentHeiht));
    }];
    
    
    if (self.isAllComment) {
        if (_isAllDisplay) {
            //tableView
            [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_replyContent.mas_bottom);
                make.left.equalTo(_icon.mas_right).with.offset(5*AppScale);
                make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
            }];
            
            [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(@(_tableViewHeight));
            }];
        }
    }else
    {
        if (_isDisplay) {
            //tableView
            [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_replyContent.mas_bottom);
                make.left.equalTo(_icon.mas_right).with.offset(5*AppScale);
                make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
            }];
            
            [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(@(_tableViewHeight));
            }];
        }
    }
    
}


#pragma mark <gettet settet>
-(void)setSubRelyModel:(TMXHomeModelDetailCommentSubListModel *)subRelyModel{
    
    [self removeAllSuperView];
    _subRelyModel=subRelyModel;
   
    _replyContent.text=subRelyModel.comment;
    _nameLab.text=subRelyModel.fromUserName;
    NSDate *date = [[KBDateFormatter shareInstance]dateFromTimeInterval:([subRelyModel.createdDate doubleValue]/1000.0)];
    _timeLab.text = [NSDate caculatorTime:date];
     [_icon sd_setImageWithURL:[NSURL URLWithString:subRelyModel.avatar] placeholderImage:nil];
    [self caculatorHeiht:_subRelyModel];
}

-(void)setReplyListModel:(TMXCommentReplyListModel *)replyListModel
{
    [self removeAllSuperView];
    _replyListModel = replyListModel;
    _replyContent.text=replyListModel.comment;
    _nameLab.text=replyListModel.fromUserName;
    NSDate *date = [[KBDateFormatter shareInstance]dateFromTimeInterval:([replyListModel.createdDate doubleValue]/1000.0)];
    _timeLab.text = [NSDate caculatorTime:date];
    [_icon sd_setImageWithURL:[NSURL URLWithString:replyListModel.avatar] placeholderImage:nil];
    [self caculatorAllHeiht:_replyListModel];
}

-(void)setIsAllComment:(BOOL)isAllComment
{
    _isAllComment = isAllComment;
    [self.tableView reloadData];
}

-(void)removeAllSuperView{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

-(void)caculatorHeiht:(TMXHomeModelDetailCommentSubListModel *)model{
    //1.计算二级评论内容的高度
    CGSize size=[NSString sizeWithStr:model.comment
                                 font:[UIFont systemFontOfSize:14]
                                width:SCREENWIDTH-65*AppScale];
    _replyContentHeiht=size.height;
    
    if (model.repliesList.count!=0) {
        self.commonReplyDataSource=model.repliesList;
        //caculator tableView height
        CGFloat temp=0.0;
        for (TMXHomeModelDetailCommentListModel *tempModel in model.repliesList) {
            NSString *replyContentStr=[NSString stringWithFormat:@"%@@%@:%@",tempModel.fromUserName,tempModel.toUserName,tempModel.comment];
            //caculator replyContent hight
            CGSize size=[NSString sizeWithStr:replyContentStr
                                         font:[UIFont systemFontOfSize:14]
                                        width:SCREENWIDTH-65*AppScale];
            temp+=size.height;
        }
        self.isDisplay=YES;
        _tableViewHeight=temp;
        [self initUI];
        [_tableView reloadData];
        
    }else{
        
        self.isDisplay=NO;
        [self initUI];
        
    }
}
//全部评论
-(void)caculatorAllHeiht:(TMXCommentReplyListModel *)model{
    //1.计算二级评论内容的高度
    CGSize size=[NSString sizeWithStr:model.comment
                                 font:[UIFont systemFontOfSize:14]
                                width:SCREENWIDTH-65*AppScale];
    _replyContentHeiht=size.height;
    
    if (model.repliesList.count!=0) {
        self.commonReplyAllDataSource=model.repliesList;
        //caculator tableView height
        CGFloat temp=0.0;
        for (TMXRepliesListModel *tempModel in model.repliesList) {
            NSString *replyContentStr=[NSString stringWithFormat:@"%@@%@:%@",tempModel.fromUserName,tempModel.toUserName,tempModel.comment];
            //caculator replyContent hight
            CGSize size=[NSString sizeWithStr:replyContentStr
                                         font:[UIFont systemFontOfSize:14]
                                        width:SCREENWIDTH-65*AppScale];
            temp+=size.height;
        }
        self.isAllDisplay=YES;
        _tableViewHeight=temp;
        [self initUI];
        [_tableView reloadData];
        
    }else{
        
        self.isAllDisplay=NO;
        [self initUI];
        
    }
}
@end
