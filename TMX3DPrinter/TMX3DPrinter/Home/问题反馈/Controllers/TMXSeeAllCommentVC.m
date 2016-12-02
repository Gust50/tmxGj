//
//  TMXSeeAllCommentVC.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/19.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXSeeAllCommentVC.h"
#import "TMXAllCommentModel.h"
#import "TMXReplyMainCell.h"
#import "TMXHeadView.h"
#import "TMXFeedbackBottomView.h"
#import "TMXHomeModelDetailModel.h"
#import "TMXReplyBottomView.h"

@interface TMXSeeAllCommentVC ()<UITableViewDelegate, UITableViewDataSource, TMXReplyMainCellDelegate, TMXReplyBottomViewDelegate, TMXFeedbackBottomViewDelegate>
{
    TMXAllCommentModel *commentModel;       ///<全部评论
    NSMutableDictionary *params;
    NSInteger pageNum;
    
    TMXHomeAddReviewModel *addReviewModel;              ///<添加评论模型
    NSMutableDictionary *addReviewParams;
    
    TMXHomeCommentReplyModel *commentReplyModel;        ///<模型评论回复
    NSMutableDictionary *commentReplyParams;
}

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) TMXFeedbackBottomView *feedbackBottomView;

@property (nonatomic, strong) TMXReplyBottomView *tMXReplyBottomView;
@property (nonatomic, strong) UIButton *replyBackgroundBtn;

@end

@implementation TMXSeeAllCommentVC
static NSString *const remarkID=@"remarkID";

#pragma mark -- 懒加载
- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UITableViewHeaderFooterView alloc] init];
        _tableView.backgroundColor = backGroundColor;
    }
    return _tableView;
}

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(TMXFeedbackBottomView *)feedbackBottomView{
    
    if (!_feedbackBottomView) {
        _feedbackBottomView=[[TMXFeedbackBottomView alloc]initWithFrame:CGRectMake(0,SCREENHEIGHT-49, SCREENWIDTH, 49)];
        _feedbackBottomView.delegate = self;
        NSString *_comment_content = NSLocalizedString(@"Comment_content", nil);
        _feedbackBottomView.placeholder = _comment_content;
        NSString *_publication = NSLocalizedString(@"Publication", nil);
        _feedbackBottomView.btnContent = _publication;
    }
    return _feedbackBottomView;
}

-(TMXReplyBottomView *)tMXReplyBottomView{
    
    if (!_tMXReplyBottomView) {
        _tMXReplyBottomView=[[TMXReplyBottomView alloc]initWithFrame:CGRectMake(0,SCREENHEIGHT-49, SCREENWIDTH, 49)];
        NSString *_comment_content = NSLocalizedString(@"Comment_content", nil);
        _tMXReplyBottomView.placeholderContent = _comment_content;
    }
    return _tMXReplyBottomView;
}


-(UIButton *)replyBackgroundBtn{
    if (!_replyBackgroundBtn) {
        _replyBackgroundBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        [_replyBackgroundBtn addTarget:self action:@selector(replyBackgroundBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _replyBackgroundBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *_userComment = NSLocalizedString(@"UserComment", nil);
    [self.navigationItem setTitle:_userComment];
    self.view.backgroundColor = backGroundColor;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.feedbackBottomView];
    commentModel = [TMXAllCommentModel new];
    params = [NSMutableDictionary dictionary];
    commentReplyModel = [TMXHomeCommentReplyModel new];
    commentReplyParams = [NSMutableDictionary dictionary];
    addReviewModel = [TMXHomeAddReviewModel new];
    addReviewParams = [NSMutableDictionary dictionary];
    
    [_tableView registerClass:[TMXReplyMainCell class] forCellReuseIdentifier:remarkID];
    
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer.hidden=YES;
    [self.tableView.mj_header beginRefreshing];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self enableOpenLeftDrawer:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self enableOpenLeftDrawer:YES];
}

#pragma mark - loadData
- (void)loadNewData
{
    pageNum = 1;
    params[@"pageNumber"] = @(1);
    params[@"pageSize"] = @(10);
    params[@"modelId"] = @(self.modelId);
    [commentModel FetchTMXAllCommentModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            commentModel = result;
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:commentModel.modelList];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            if (commentModel.modelList.count < 10) {
                self.tableView.mj_footer.hidden = YES;
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                self.tableView.mj_footer.hidden = NO;
                [self.tableView.mj_footer resetNoMoreData];
            }
        }else
        {
            [self.tableView.mj_header endRefreshing];
        }
    }];
}

//加载更多数据
- (void)loadMoreData
{
    pageNum++;
    params[@"pageNumber"] = @(pageNum);
    if (pageNum > commentModel.pageNumber) {
        [commentModel FetchTMXAllCommentModel:params callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                commentModel = result;
                [self.dataSource addObjectsFromArray:commentModel.modelList];
                [self.tableView.mj_footer endRefreshing];
                [self.tableView reloadData];
                
                if (commentModel.modelList.count < 10) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    [self.tableView.mj_footer endRefreshing];
                }
            }
        }];
    }else
    {
        [self.tableView.mj_footer endRefreshing];
    }
}

//添加评论
- (void)loadAddReviewData
{
    addReviewParams[@"type"] = @(1);
    addReviewParams[@"userId"] = [FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
    addReviewParams[@"modelId"] = @(self.modelId);
    [addReviewModel FetchTMXHomeAddReviewModel:addReviewParams callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:NSLocalizedString(@"Comment_Suc", nil)];
            [self loadNewData];
        }else
        {
            [MBProgressHUD showError:NSLocalizedString(@"Comment_Fail", nil)];
        }
    }];
}

//评论回复
- (void)loadCommentReplyData
{
    [commentReplyModel FetchTMXHomeAddReviewModel:commentReplyParams callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:NSLocalizedString(@"Reply_Suc", nil)];
            [self loadNewData];
        }else
        {
            [MBProgressHUD showError:NSLocalizedString(@"Reply_Fail", nil)];
        }
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TMXReplyMainCell *remarkCell=[tableView dequeueReusableCellWithIdentifier:remarkID forIndexPath:indexPath];
    remarkCell.isAllComment = YES;
    remarkCell.modelListModel = self.dataSource[indexPath.row];
    remarkCell.selectionStyle = UITableViewCellSelectionStyleNone;
    remarkCell.delegate = self;
    return remarkCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TMXHeadView *headView = [[TMXHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40*AppScale)];
    headView.userIcon = @"UserRemarkIcon";
    headView.describe = NSLocalizedString(@"UserComment", nil);
    NSString *have = NSLocalizedString(@"Haved", nil);
    NSString *com = NSLocalizedString(@"UseCom", nil);
    headView.leng = have;
    headView.subDescribe = [NSString stringWithFormat:@"%@%ld%@", have,commentModel.totalRows,com];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40*AppScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TMXModelListModel *listModel = self.dataSource[indexPath.row];
    return [self caculatorCurrentCellHeigh:listModel];
}

//当前cell的高度
- (CGFloat)caculatorCurrentCellHeigh:(TMXModelListModel *)model
{
    //显示二级评论的最大宽度
    CGFloat maxWidth=SCREENWIDTH-65*AppScale;
    
    //1.计算一级评论的内容高度
    CGFloat mainReplyContentHeight=0.0;
    mainReplyContentHeight=[NSString sizeWithStr:model.comment
                                            font:[UIFont systemFontOfSize:14]
                                           width:SCREENWIDTH-20].height;
    //2.计算谁回复了此评论的高度最大值是5个
    CGFloat replyusernameStringHeight=0.0;
    //3.计算二级评论的高度
    if (model.commentReplyList.count!=0) {
        
        NSString *replyuserNameString;
        NSInteger maxNumber=5;
        CGFloat replySubcellHeight=0.0;
        NSInteger tempCount=0;
        //遍历二级评论的所有数据
        for ( TMXCommentReplyListModel *subListModel in model.commentReplyList) {
            
            if (tempCount<maxNumber) {
                if (tempCount==0) {
                    replyuserNameString=subListModel.fromUserName;
                }else{
                    replyuserNameString=[NSString stringWithFormat:@"%@、%@",subListModel.fromUserName,replyuserNameString];
                }
                tempCount++;
            }
            //计算二级评论回复的内容高度
            CGFloat subReplyContentHeight=[NSString sizeWithStr:subListModel.comment
                                                           font:[UIFont systemFontOfSize:14]
                                                          width:maxWidth].height;
            //计算三级评论的高度
            if (subListModel.repliesList.count!=0) {
                CGFloat commonReplyContentHeight=0.0;
                for ( TMXRepliesListModel *commonModel in subListModel.repliesList) {
                    NSString *replyContentStr=[NSString stringWithFormat:@"%@@%@:%@",commonModel.fromUserName,commonModel.toUserName,commonModel.comment];
                    //三级评论的回复内容的高度
                    commonReplyContentHeight+=[NSString sizeWithStr:replyContentStr
                                                               font:[UIFont systemFontOfSize:14]
                                                              width:maxWidth].height;
                }
                
                //二级评论的总高度 top=5 bottom=10 textMargin=5 tableViewMargin=10
                replySubcellHeight+=subReplyContentHeight+60*AppScale+commonReplyContentHeight;
                
            }else{
                //二级评论的总高度 top=5 bottom=10 textMargin=5 tableViewMargin=10
                replySubcellHeight+=subReplyContentHeight+60*AppScale;
            }
            
        }
        NSString *wait = NSLocalizedString(@"Wait", nil);
        replyuserNameString=[NSString stringWithFormat:@"%@%@",replyuserNameString, wait];
        //赋值谁回复了此评论的高度最大值是5个
        replyusernameStringHeight=[NSString sizeWithStr:replyuserNameString
                                                   font:[UIFont systemFontOfSize:13*AppScale]
                                                  width:SCREENWIDTH-20-12*AppScale].height;
        //一级评论的总高度
        return (replySubcellHeight+mainReplyContentHeight+65*AppScale+replyusernameStringHeight+.5);
    }else{
        //一级评论的总高度
        return (mainReplyContentHeight+60*AppScale);
    }
}

#pragma mark <TMXReplyMainCellDelegate>
-(void)replyAllMainCell:(TMXModelListModel *)model
{
    [self.view addSubview:self.replyBackgroundBtn];
    [self.view addSubview:self.tMXReplyBottomView];
    _tMXReplyBottomView.placeholderContent=model.userName;
    _tMXReplyBottomView.delegate=self;
    [commentReplyParams removeAllObjects];
    commentReplyParams[@"userId"] = [FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
    commentReplyParams[@"commentId"] = @(model.commentId);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.1*(NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _tMXReplyBottomView.isFirstResponse=YES;
    });
}

-(void)replyAllCommonCellToMainCell:(TMXRepliesListModel *)model
                         subReplyID:(NSString *)subReplyID
{
    [self.view addSubview:self.replyBackgroundBtn];
    [self.view addSubview:self.tMXReplyBottomView];
    _tMXReplyBottomView.delegate=self;
    _tMXReplyBottomView.placeholderContent=model.fromUserName;
    [commentReplyParams removeAllObjects];
    commentReplyParams[@"userId"] = [FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
    commentReplyParams[@"commentId"] = @(model.commentId);
    commentReplyParams[@"toUserId"] = @(model.fromUserId);
    commentReplyParams[@"parentId"] = subReplyID;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.1*(NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _tMXReplyBottomView.isFirstResponse=YES;
    });
}

-(void)replyAllSubCellToMainCell:(TMXCommentReplyListModel *)model
{
    [self.view addSubview:self.replyBackgroundBtn];
    [self.view addSubview:self.tMXReplyBottomView];
    _tMXReplyBottomView.delegate=self;
    _tMXReplyBottomView.placeholderContent=model.fromUserName;
    [commentReplyParams removeAllObjects];
    commentReplyParams[@"userId"] = [FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
    commentReplyParams[@"commentId"] = @(model.commentId);
    commentReplyParams[@"toUserId"] = @(model.fromUserId);
    commentReplyParams[@"parentId"] = @(model.replyId);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.1*(NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _tMXReplyBottomView.isFirstResponse=YES;
    });
}

#pragma mark <TMXFeedbackBottomViewDelegate>
- (void)TMXFeedbackBottomView:(NSString *)content textField:(KBTextField *)textField
{
    addReviewParams[@"comment"] = content;
    [self loadAddReviewData];
    textField.text = nil;
}

#pragma mark <TMXReplyBottomViewDelegate>
-(void)replyContent:(NSString *)content textField:(KBTextField *)textField{
    
    commentReplyParams[@"comment"] = content;
    [self loadCommentReplyData];
    [_replyBackgroundBtn removeFromSuperview];
    [_tMXReplyBottomView removeFromSuperview];
    textField.text = nil;
    [self.view endEditing:YES];
}

-(void)replyBackgroundBtn:(UIButton *)btn{
    [_replyBackgroundBtn removeFromSuperview];
    [_tMXReplyBottomView removeFromSuperview];
    [self.view endEditing:YES];
}

#pragma mark - setter getter
-(void)setModelId:(NSInteger)modelId
{
    _modelId = modelId;
}

@end
