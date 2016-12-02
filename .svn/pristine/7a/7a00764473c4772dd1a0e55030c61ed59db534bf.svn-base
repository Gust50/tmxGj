//
//  TMXProblemFeedbackVC.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/18.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXProblemFeedbackVC.h"
#import "TMXHeadView.h"
#import "TMXProblemFeedbackCell.h"
#import "TMXHomeModelDetailModel.h"
#import "TMXFeedbackBottomView.h"
#import "TMXFeedbackModel.h"

@interface TMXProblemFeedbackVC ()<UITableViewDelegate, UITableViewDataSource,TMXFeedbackBottomViewDelegate>
{
    TMXFeedbackModel *model;                    ///<反馈意见列表
    NSMutableDictionary *feedbackParams;
    NSInteger pageNum;
    
    TMXHomeAddReviewModel *feedbackModel;       ///<反馈意见
    NSMutableDictionary *params;                ///<传入参数
}

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) TMXFeedbackBottomView *feedbackBottomView;

@end

@implementation TMXProblemFeedbackVC
static NSString *const cellID=@"TMXProblemFeedbackCell";

#pragma mark - lazyLoad
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = backGroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(TMXFeedbackBottomView *)feedbackBottomView{
    
    if (!_feedbackBottomView) {
        _feedbackBottomView=[[TMXFeedbackBottomView alloc]initWithFrame:CGRectMake(0,SCREENHEIGHT-49, SCREENWIDTH, 49)];
        _feedbackBottomView.delegate = self;
        NSString *_feedback_content = NSLocalizedString(@"Feedback_content", nil);
        _feedbackBottomView.placeholder = _feedback_content;
        NSString *_feedback = NSLocalizedString(@"Feedback", nil);
        _feedbackBottomView.btnContent = _feedback;
    }
    return _feedbackBottomView;
}

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backGroundColor;
    NSString *_problemfeedback = NSLocalizedString(@"Problemfeedback", nil);
    [self.navigationItem setTitle:_problemfeedback];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.feedbackBottomView];
    
    [self.tableView registerClass:[TMXProblemFeedbackCell class] forCellReuseIdentifier:cellID];
    self.tableView.tableFooterView = [UIView new];
    
    feedbackModel = [[TMXHomeAddReviewModel alloc] init];
    params = [NSMutableDictionary dictionary];
    model = [TMXFeedbackModel new];
    feedbackParams = [NSMutableDictionary dictionary];
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
    feedbackParams[@"pageNumber"] = @(pageNum);
    feedbackParams[@"pageSize"] = @(10);
    feedbackParams[@"modelId"] = @(self.modelId);
    [model FetchTMXFeedbackModel:feedbackParams callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            model = result;
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:model.modelList];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            if (model.modelList.count < 10) {
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
    if (pageNum > model.pageNumber) {
        [model FetchTMXFeedbackModel:params callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                model = result;
                [self.dataSource addObjectsFromArray:model.modelList];
                [self.tableView.mj_footer endRefreshing];
                [self.tableView reloadData];
                
                if (model.modelList.count < 10) {
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

- (void)loadData
{
    params[@"userId"] = [FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
    params[@"modelId"] = @(self.modelId);
    params[@"type"] = @(2);
    [feedbackModel FetchTMXHomeAddReviewModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:NSLocalizedString(@"Feed_Suc", nil)];
            [self loadNewData];
        }else
        {
            [MBProgressHUD showError:NSLocalizedString(@"Feed_Fail", nil)];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TMXProblemFeedbackCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[TMXProblemFeedbackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.listModel = self.dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TMXHeadView *headView = [[TMXHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40*AppScale)];
    headView.userIcon = @"FeedbackIcon";
    NSString *_problemfeedback = NSLocalizedString(@"Problemfeedback", nil);
    headView.describe = _problemfeedback;
    NSString *have = NSLocalizedString(@"Haved", nil);
    NSString *fed = NSLocalizedString(@"UseFed", nil);
    headView.leng = have;
    headView.subDescribe = [NSString stringWithFormat:@"%@%ld%@", have,model.totalRows,fed];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TMXFeedbackListModel *listModel = self.dataSource[indexPath.row];
    CGSize size = [NSString sizeWithStr:listModel.comment font:[UIFont systemFontOfSize:12*AppScale] width:SCREENWIDTH-20*AppScale];
    return 60*AppScale + size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40*AppScale;
}

#pragma mark <TMXFeedbackBottomViewDelegate>
-(void)TMXFeedbackBottomView:(NSString *)content textField:(KBTextField *)textField{
    params[@"comment"] = content;
    [self loadData];
    [self.view endEditing:YES];
    textField.text = nil;
}

#pragma mark - setter getter
-(void)setModelId:(NSInteger)modelId
{
    _modelId = modelId;
}

@end
