//
//  TMXHomeModelDetailVC.m
//  TMX3DPrinter
//
//  Created by kobe on 16/8/29.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXHomeModelDetailVC.h"
#import "TMXHomeDetailDescribeCell.h"
#import "TMXHomeIntroductModelCell.h"
#import "TMXHomeUpLoadUserInfoCell.h"
#import "TMXHomeModelListCell.h"
#import "TMXHomeModelRemarkCell.h"
#import "TMXHomeModelHeaderView.h"
#import "TMXHomeDetailToolBar.h"
#import "TMXPrinteringVC.h"
#import "TMXProfileEditVC.h"
#import "PrinterListViewController.h"
#import "TMXHomeDetailShareView.h"
#import "TMXHomeModelDetailModel.h"
#import "TMXReplyMainCell.h"
#import "TMXReplyBottomView.h"
#import "TMXAccountPrinterModel.h"
#import "TMXProblemFeedbackVC.h"
#import "TMXLoginVC.h"
#import "TMXSeeAllCommentVC.h"
#import "TMXUploadModelByUserVC.h"
#import "TMXPrinterTaskListViewController.h"
#import "TMXWaitPrintViewController.h"

@interface TMXHomeModelDetailVC ()<UITableViewDelegate,UITableViewDataSource, TMXHomeDetailToolBarDelegate, TMXHomeModelHeaderViewDelegate, TMXHomeDetailShareViewDelegate, TMXHomeDetailDescribeCellDelegate,TMXReplyMainCellDelegate,TMXReplyBottomViewDelegate>
{
    TMXHomeDetailToolBar *toolBar;
    TMXHomeDetailShareView *shareView;                  ///<分享视图
    TMXHomeModelDetailModel *detailModel;               ///<模型详情
    NSMutableDictionary *params;                        ///<参数
    TMXHomeCollectModel *collectModel;                  ///<收藏模型
    TMXHomeLikeModel *likeModel;                        ///<喜欢模型
    TMXHomeCancelCollectModel *cancelCollectModel;      ///<取消收藏模型
    TMXHomeCancelLikeModel *cancelLikeModel;            ///<取消喜欢模型
    TMXHomeAddReviewModel *addReviewModel;              ///<添加评论模型
    NSMutableDictionary *addReviewParams;
    TMXHomeCommentReplyModel *commentReplyModel;        ///<模型评论回复
    NSMutableDictionary *commentReplyParams;
    
    NSInteger selectPrinterID;                            ///<通知选择打印机ID
    NSString *selectPrinterName;                          ///<通知选择打印机名
    BOOL isAddReview;                                    ///<判断是添加评论还是回复评论
    MBProgressHUD *hud;
    TMXAccountPrintModel *tMXAccountPrintModel;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TMXReplyBottomView *tMXReplyBottomView;
@property (nonatomic, strong) UIButton *replyBackgroundBtn;
@end

@implementation TMXHomeModelDetailVC

static NSString *const describeID=@"describeID";
static NSString *const introductID=@"introductID";
static NSString *const modelListID=@"modelListID";
static NSString *const userInfoID=@"userInfoID";
static NSString *const remarkID=@"remarkID";
static NSString *const headerID=@"headerID";

#pragma mark <lazyLoad>
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64-49) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.showsVerticalScrollIndicator=NO;
    }
    return _tableView;
}

-(TMXReplyBottomView *)tMXReplyBottomView{
    
    if (!_tMXReplyBottomView) {
        _tMXReplyBottomView=[[TMXReplyBottomView alloc]initWithFrame:CGRectMake(0,SCREENHEIGHT-49, SCREENWIDTH, 49)];
        NSString *_comment = NSLocalizedString(@"Comment_content", nil);
        _tMXReplyBottomView.placeholderContent = _comment;
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

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *_detail = NSLocalizedString(@"Detail", nil);
    [self.navigationItem setTitle:_detail];
    self.view.backgroundColor = backGroundColor;
    [self initTableView];
    [self initToolBar];
    detailModel = [[TMXHomeModelDetailModel alloc] init];
    params = [NSMutableDictionary dictionary];
    collectModel = [[TMXHomeCollectModel alloc] init];
    likeModel = [[TMXHomeLikeModel alloc] init];
    cancelCollectModel = [[TMXHomeCancelCollectModel alloc] init];
    cancelLikeModel = [[TMXHomeCancelLikeModel alloc] init];
    addReviewModel = [TMXHomeAddReviewModel new];
    addReviewParams = [NSMutableDictionary dictionary];
    commentReplyModel = [TMXHomeCommentReplyModel new];
    commentReplyParams = [NSMutableDictionary dictionary];
    params[@"modelId"] = @(self.modelId);
    params[@"userId"] = [FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
    
//    self.navigationItem.rightBarButtonItem=[UIBarButtonItem normalImage:@"ShareIcon_white" selectImage:@"ShareIcon_white" target:self action:@selector(modelDetailShare)];
    [self loadData];
    
    tMXAccountPrintModel=[TMXAccountPrintModel new];
    hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.backgroundColor=[UIColor clearColor];
    hud.color=[UIColor clearColor];
    hud.activityIndicatorColor=systemColor;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self enableOpenLeftDrawer:NO];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectPrinterID:) name:@"selectPrinterID" object:nil];
    [self loadData];
}

//模型文件列表选择的打印机ID
- (void)selectPrinterID:(NSNotification *)info
{
    NSDictionary *dic = info.userInfo;
    selectPrinterID = [dic[@"printerId"] integerValue];
    selectPrinterName= dic[@"printerName"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self enableOpenLeftDrawer:YES];
    
}
#pragma mark - loadData
- (void)loadData
{
    [detailModel FetchTMXHomeModelDetailModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            detailModel = result;
            if (detailModel.modelCommentCount > 10) {
                [self initFooterView];
            }else
            {
                self.tableView.tableFooterView = [[UIView alloc] init];
            }
            toolBar.isLike = detailModel.isUpvoteModel;
            [hud hide:YES];
            [self.tableView reloadData];
        }else
        {
            hud.labelText=NSLocalizedString(@"Load_Fail", nil);
            [hud hide:YES afterDelay:2];
        }
    }];
}

//收藏模型
- (void)loadCollectData
{
    [collectModel FetchTMXHomeCollectModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:NSLocalizedString(@"Collect_Suc", nil)];
            [self loadData];
        }else
        {
            [MBProgressHUD showError:NSLocalizedString(@"Collect_Fail", nil)];
        }
    }];
    
}

//喜欢模型
- (void)loadLikeData
{
    [likeModel FetchTMXHomeLikeModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:NSLocalizedString(@"Like_Suc", nil)];
            [self loadData];
        }else
        {
            [MBProgressHUD showError:NSLocalizedString(@"Like_Fail", nil)];
        }
    }];
}

//取消收藏模型
- (void)loadCancelCollectData
{
    [cancelCollectModel FetchTMXHomeCancelCollectModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:NSLocalizedString(@"CaCollect_Suc", nil)];
            [self loadData];
        }else
        {
            [MBProgressHUD showError:NSLocalizedString(@"CaCollect_Fail", nil)];
        }
    }];
}

//取消喜欢模型
- (void)loadCancelLikeData
{
    [cancelLikeModel FetchTMXHomeCancelLikeModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:NSLocalizedString(@"CaLike_Suc", nil)];
            [self loadData];
        }else
        {
            [MBProgressHUD showError:NSLocalizedString(@"CaLike_Fail", nil)];
        }
    }];
}
//添加评论
- (void)loadAddReviewData
{
    [addReviewModel FetchTMXHomeAddReviewModel:addReviewParams callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:NSLocalizedString(@"Comment_Suc", nil)];
            [self loadData];
        }else
        {
            [MBProgressHUD showError:NSLocalizedString(@"Comment_Fail", nil)];
        }
    }];
    
}

//评论回复
- (void)loadCommentReplyData:(NSDictionary *)needParams
{
    [commentReplyModel FetchTMXHomeAddReviewModel:needParams callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:NSLocalizedString(@"Reply_Suc", nil)];
            [self loadData];
        }else
        {
            [MBProgressHUD showError:NSLocalizedString(@"Reply_Fail", nil)];
        }
    }];
}

//分享
//- (void)modelDetailShare
//{
//    if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
//        shareView = [[TMXHomeDetailShareView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//        shareView.delegate = self;
//        [[[UIApplication sharedApplication]keyWindow]addSubview:shareView];
//    }else
//    {
//        TMXLoginVC *login=[[TMXLoginVC alloc]initWithNibName:@"TMXLoginVC" bundle:nil];
//        [ShareApp.drawerController setCenterViewController:login withCloseAnimation:YES completion:nil];
//    }
//    
//}

-(void)initTableView{
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.view addSubview:self.tableView];
    
    [_tableView registerClass:[TMXHomeDetailDescribeCell class] forCellReuseIdentifier:describeID];
    [_tableView registerClass:[TMXHomeIntroductModelCell class] forCellReuseIdentifier:introductID];
    [_tableView registerClass:[TMXHomeModelListCell class] forCellReuseIdentifier:modelListID];
    [_tableView registerClass:[TMXHomeUpLoadUserInfoCell class] forCellReuseIdentifier:userInfoID];
    [_tableView registerClass:[TMXReplyMainCell class] forCellReuseIdentifier:remarkID];
    [_tableView registerClass:[TMXHomeModelHeaderView class] forHeaderFooterViewReuseIdentifier:headerID];
}

- (void)initFooterView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40*AppScale)];
    view.backgroundColor = [UIColor whiteColor];
    UIButton *seeMoreComment = [UIButton buttonWithType:UIButtonTypeCustom];
    seeMoreComment.frame = CGRectMake(0, 0, SCREENWIDTH, 40*AppScale);
    seeMoreComment.backgroundColor = [UIColor whiteColor];
    NSString *_moreComments = NSLocalizedString(@"MoreComments", nil);
    [seeMoreComment setTitle:_moreComments forState:UIControlStateNormal];
    [seeMoreComment setTitleColor:systemColor forState:UIControlStateNormal];
    seeMoreComment.titleLabel.font = [UIFont systemFontOfSize:12*AppScale];
    [seeMoreComment addTarget:self action:@selector(searchAllComment) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:seeMoreComment];
    self.tableView.tableFooterView = view;
}

//查看全部评论
- (void)searchAllComment
{
    if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
        TMXSeeAllCommentVC *allCommentVC = [TMXSeeAllCommentVC new];
        allCommentVC.modelId = self.modelId;
        [self.navigationController pushViewController:allCommentVC animated:YES];
    }else
    {
        TMXLoginVC *login=[[TMXLoginVC alloc]initWithNibName:@"TMXLoginVC" bundle:nil];
        [ShareApp.drawerController setCenterViewController:login withCloseAnimation:YES completion:nil];
    }

}

- (void)initToolBar
{
    toolBar = [[TMXHomeDetailToolBar alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-49, SCREENWIDTH, 49)];
    toolBar.delegate = self;
    if (_isProfile) {
        [toolBar.feedBackBtn setTitle:NSLocalizedString(@"Edit", nil) forState:UIControlStateNormal];
    }else
    {
        NSString *_opinionFeedback = NSLocalizedString(@"OpinionFeedback", nil);
        [toolBar.feedBackBtn setTitle:_opinionFeedback forState:UIControlStateNormal];
    }
    [self.view addSubview:toolBar];
}

#pragma mark <UITableViewDataSource>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==4) {
        if (detailModel.modelCommentCount>10) {
            return 10;
        }else
        {
            return detailModel.modelCommentList.count;
        }
    }else if (section == 2)
    {
        return detailModel.stlFileList.count;
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        TMXHomeDetailDescribeCell *describeCell=[tableView dequeueReusableCellWithIdentifier:describeID forIndexPath:indexPath];
        describeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        describeCell.detailModel = detailModel;
        describeCell.delegate = self;
        return describeCell;
    }else if (indexPath.section==1){
        TMXHomeIntroductModelCell *introductCell=[tableView dequeueReusableCellWithIdentifier:introductID forIndexPath:indexPath];
        introductCell.selectionStyle = UITableViewCellSelectionStyleNone;
        introductCell.modelInfo = detailModel.intruduction;
        return introductCell;
    }else if (indexPath.section==2){
        TMXHomeModelListCell *modelListCell=[tableView dequeueReusableCellWithIdentifier:modelListID forIndexPath:indexPath];
        TMXHomeModelDetailFileListModel *fileListModel = [detailModel.stlFileList objectAtIndexCheck:indexPath.row];
        modelListCell.fileListModel = fileListModel;
        WS(weakSelf);
        //打印
        modelListCell.modelDetailPrinterBlock = ^(){
            
            
            if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin)
            {
                NSMutableDictionary *printerParams=[NSMutableDictionary dictionary];
                printerParams[@"fileId"]=@(fileListModel.fileId);
                
                //如果选择了打印机就使用选择的打印机
                if (selectPrinterID==0) {
                    [printerParams removeObjectForKey:@"printerId"];
                }else{
//                    printerModel.printerId=[NSString stringWithFormat:@"%ld",(long)selectPrinterID];
                    printerParams[@"printerId"]=@(selectPrinterID);
                }
                
                [tMXAccountPrintModel FetchTMXPrintModelData:printerParams callBack:^(BOOL isSuccess, id result) {
                    if (isSuccess)
                    {
                        TMXAccountPrintModel *printerModel=[[TMXAccountPrintModel alloc]init];
                        printerModel=result;
                        [[MBProgressHUD showMessage:NSLocalizedString(@"Loading", nil)]hide:YES afterDelay:0.88];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)1.0*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                            
                            if (printerModel.gotoPage==Printing) {
                                TMXPrinteringVC *printeringVC = [TMXPrinteringVC new];
                                printeringVC.printerId=printerModel.printerId;
                                [weakSelf.navigationController pushViewController:printeringVC animated:YES];
                            }else if (printerModel.gotoPage==PrintTask){
                                TMXPrinterTaskListViewController *tMXPrinterTaskListViewController=[TMXPrinterTaskListViewController new];
                                tMXPrinterTaskListViewController.printerId=[printerModel.printerId integerValue];
                                [weakSelf.navigationController pushViewController:tMXPrinterTaskListViewController animated:YES];
                            }else if (printerModel.gotoPage==PriterTask_Share){
                                TMXWaitPrintViewController *tMXWaitPrintViewController=[TMXWaitPrintViewController new];
                                tMXWaitPrintViewController.printerId=[printerModel.printerId integerValue];
                                [weakSelf.navigationController pushViewController:tMXWaitPrintViewController animated:YES];
                            }
                        });
                        
                    }else
                    {
                        [MBProgressHUD showError:result];
                    }
                }];
            }else
            {
                //跳转登录界面
                TMXLoginVC *loginVC=[TMXLoginVC new];
                loginVC.isDismissVC=YES;
                [self.parentViewController presentViewController:loginVC animated:YES completion:nil];
            }
        };
        modelListCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return modelListCell;
    }else if (indexPath.section==3){
        TMXHomeUpLoadUserInfoCell *userInfoCell=[tableView dequeueReusableCellWithIdentifier:userInfoID forIndexPath:indexPath];
        userInfoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        userInfoCell.detailModel = detailModel;
        return userInfoCell;
    }else{
        TMXHomeModelDetailCommentMainListModel *tempMainModel=[detailModel.modelCommentList objectAtIndexCheck:indexPath.row];
        TMXReplyMainCell *remarkCell=[tableView dequeueReusableCellWithIdentifier:remarkID forIndexPath:indexPath];
        remarkCell.isAllComment = NO;
        remarkCell.mainReplyModel=tempMainModel;
        remarkCell.delegate=self;
        remarkCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return remarkCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        TMXUploadModelByUserVC *userVC = [TMXUploadModelByUserVC new];
        userVC.userID = detailModel.ownerId;
        userVC.ownerName = detailModel.ownerName;
        [self.navigationController pushViewController:userVC animated:YES];
    }
}

#pragma mark <UITableViewDataSource>
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 250*AppScale;
    }else if (indexPath.section==1){
        CGSize size = [NSString sizeWithStr:detailModel.intruduction font:[UIFont systemFontOfSize:11*AppScale] width:SCREENWIDTH-20*AppScale];
        //需要计算文字高度
        return 55*AppScale+size.height;
    }else if (indexPath.section==2){
        return 80*AppScale;
    }else if (indexPath.section==3){
        return 50*AppScale;
    }else{
        
        TMXHomeModelDetailCommentMainListModel *tempMainModel=detailModel.modelCommentList[indexPath.row];
        return [self caculatorCurrentCellHeigh:tempMainModel];
    }

}
//当前cell的高度
-(CGFloat)caculatorCurrentCellHeigh:(TMXHomeModelDetailCommentMainListModel *)model{
    
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
        for ( TMXHomeModelDetailCommentSubListModel *subListModel in model.commentReplyList) {
            
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
                for ( TMXHomeModelDetailCommentListModel *commonModel in subListModel.repliesList) {
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return CGFLOAT_MIN;
    }else if (section==1){
        return CGFLOAT_MIN;
    }else if (section==2){
        return 35*AppScale;
    }else if (section==3){
        return 35*AppScale;
    }else{
        return 35*AppScale;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    if (section == 4) {
        return CGFLOAT_MIN;
    }
    return 10*AppScale;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    TMXHomeModelHeaderView *headerView=[tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    headerView.contentView.backgroundColor = [UIColor whiteColor];
    if (section==2) {
        headerView.iconUrl = @"ModelFileListIcon";
        NSString *_file = NSLocalizedString(@"File", nil);
        headerView.title = _file;
        headerView.isHideArrow = NO;
        headerView.subTitle = selectPrinterName;
        headerView.delegate = self;
        return headerView;
    }else if (section == 3)
    {
        headerView.iconUrl = @"UserInfoIcon";
        NSString *_information = NSLocalizedString(@"Information", nil);
        headerView.title = _information;
        headerView.isHideArrow = YES;
         headerView.subTitle = @"";
        return headerView;
    }else if (section == 4)
    {
        headerView.iconUrl = @"UserRemarkIcon";
        NSString *_userComment = NSLocalizedString(@"UserComment", nil);
        headerView.title = _userComment;
        headerView.isHideArrow = YES;
        NSString *com = NSLocalizedString(@"UserComment", nil);
        headerView.leng = @"";
        headerView.subTitle = [NSString stringWithFormat:@"%ld %@",detailModel.modelCommentCount,com];
        return headerView;
    }
    return nil;
}

-(void)replyBackgroundBtn:(UIButton *)btn{
    [_replyBackgroundBtn removeFromSuperview];
    [_tMXReplyBottomView removeFromSuperview];
    [self.view endEditing:YES];
}

#pragma mark - TMXHomeDetailDescribeCellDelegate
-(void)collectModel
{
    if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
        if (detailModel.isFavoriteModel) {
            [self loadCancelCollectData];
        }else
        {
            [self loadCollectData];
        }
    }else
    {
        TMXLoginVC *login=[[TMXLoginVC alloc]initWithNibName:@"TMXLoginVC" bundle:nil];
        [ShareApp.drawerController setCenterViewController:login withCloseAnimation:YES completion:nil];
    }
    
}

#pragma mark - TMXHomeDetailToolBarDelegate
-(void)clickLikeBtn
{
    if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
        if (detailModel.isUpvoteModel) {
            [self loadCancelLikeData];
        }else
        {
            [self loadLikeData];
        }
    }else
    {
        TMXLoginVC *login=[[TMXLoginVC alloc]initWithNibName:@"TMXLoginVC" bundle:nil];
        [ShareApp.drawerController setCenterViewController:login withCloseAnimation:YES completion:nil];
    }
    
}
-(void)clickRemarkBtn
{
    if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
        [self.view addSubview:self.replyBackgroundBtn];
        [self.view addSubview:self.tMXReplyBottomView];
        _tMXReplyBottomView.delegate=self;
        isAddReview = YES;
        //添加评论传1，反馈传2
        addReviewParams[@"type"] = @(1);
        addReviewParams[@"userId"] = [FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
        addReviewParams[@"modelId"] = @(self.modelId);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.1*(NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _tMXReplyBottomView.isFirstResponse=YES;
        });
    }else
    {
        TMXLoginVC *login=[[TMXLoginVC alloc]initWithNibName:@"TMXLoginVC" bundle:nil];
        [ShareApp.drawerController setCenterViewController:login withCloseAnimation:YES completion:nil];
    }
    
}
-(void)clickFeedbackBtn
{
    if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
        if (_isProfile) {
            TMXProfileEditVC *editVC = [[TMXProfileEditVC alloc] init];
            editVC.modelId = self.modelId;
            editVC.isModelOpen = self.isModelOpen;
            [self.navigationController pushViewController:editVC animated:YES];
        }else
        {
            TMXProblemFeedbackVC *feedbackVC = [[TMXProblemFeedbackVC alloc] init];
            feedbackVC.modelId = self.modelId;
            [self.navigationController pushViewController:feedbackVC animated:YES];
        }
    }else
    {
        TMXLoginVC *login=[[TMXLoginVC alloc]initWithNibName:@"TMXLoginVC" bundle:nil];
        [ShareApp.drawerController setCenterViewController:login withCloseAnimation:YES completion:nil];
    }
}

#pragma mark <TMXReplyMainCellDelegate>
-(void)replyMainCell:(TMXHomeModelDetailCommentMainListModel *)model{
    if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
        [self.view addSubview:self.replyBackgroundBtn];
        [self.view addSubview:self.tMXReplyBottomView];
        _tMXReplyBottomView.delegate=self;
        isAddReview = NO;
        _tMXReplyBottomView.placeholderContent=model.userName;
        [commentReplyParams removeAllObjects];
        commentReplyParams[@"userId"] = [FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
        commentReplyParams[@"commentId"] = @(model.commentId);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.1*(NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _tMXReplyBottomView.isFirstResponse=YES;
        });
    }else
    {
        TMXLoginVC *login=[[TMXLoginVC alloc]initWithNibName:@"TMXLoginVC" bundle:nil];
        [ShareApp.drawerController setCenterViewController:login withCloseAnimation:YES completion:nil];
    }
    
}


-(void)replyCommonCellToMainCell:(TMXHomeModelDetailCommentListModel *)model subReplyID:(NSString *)subReplyID{
    if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
        [self.view addSubview:self.replyBackgroundBtn];
        [self.view addSubview:self.tMXReplyBottomView];
        _tMXReplyBottomView.delegate=self;
        isAddReview = NO;
        _tMXReplyBottomView.placeholderContent=model.fromUserName;
        [commentReplyParams removeAllObjects];
        commentReplyParams[@"userId"] = [FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
        commentReplyParams[@"commentId"] = @(model.commentId);
        commentReplyParams[@"toUserId"] = @(model.fromUserId);
        commentReplyParams[@"parentId"] = subReplyID;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.1*(NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _tMXReplyBottomView.isFirstResponse=YES;
        });
    }else
    {
        TMXLoginVC *login=[[TMXLoginVC alloc]initWithNibName:@"TMXLoginVC" bundle:nil];
        [ShareApp.drawerController setCenterViewController:login withCloseAnimation:YES completion:nil];
    }
    
}


-(void)replySubCellToMainCell:(TMXHomeModelDetailCommentSubListModel *)model{
    
    if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
        [self.view addSubview:self.replyBackgroundBtn];
        [self.view addSubview:self.tMXReplyBottomView];
        _tMXReplyBottomView.delegate=self;
        isAddReview = NO;
        _tMXReplyBottomView.placeholderContent=model.fromUserName;
        [commentReplyParams removeAllObjects];
        commentReplyParams[@"userId"] = [FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
        commentReplyParams[@"commentId"] = @(model.commentId);
        commentReplyParams[@"toUserId"] = @(model.fromUserId);
        commentReplyParams[@"parentId"] = @(model.replyId);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.1*(NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _tMXReplyBottomView.isFirstResponse=YES;
        });
    }else
    {
        TMXLoginVC *login=[[TMXLoginVC alloc]initWithNibName:@"TMXLoginVC" bundle:nil];
        [ShareApp.drawerController setCenterViewController:login withCloseAnimation:YES completion:nil];
    }
    
}

#pragma mark <TMXReplyBottomViewDelegate>
-(void)replyContent:(NSString *)content textField:(KBTextField *)textField{
    if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
        addReviewParams[@"comment"] = content;
        commentReplyParams[@"comment"] = content;
        if (isAddReview) {
            [self loadAddReviewData];
        }else
        {
            [self loadCommentReplyData:commentReplyParams];
        }
        [_replyBackgroundBtn removeFromSuperview];
        [_tMXReplyBottomView removeFromSuperview];
        textField.text = nil;
        [self.view endEditing:YES];
    }else
    {
        TMXLoginVC *login=[[TMXLoginVC alloc]initWithNibName:@"TMXLoginVC" bundle:nil];
        [ShareApp.drawerController setCenterViewController:login withCloseAnimation:YES completion:nil];
    }
    
}

#pragma mark - setter getter
-(void)setIsProfile:(BOOL)isProfile
{
    _isProfile = isProfile;
    [self.tableView reloadData];
}

-(void)setModelId:(NSInteger )modelId
{
    _modelId = modelId;
}

- (void)setIsModelOpen:(BOOL)isModelOpen
{
    _isModelOpen = isModelOpen;
}


#pragma mark - TMXHomeModelHeaderViewDelegate
-(void)clickSelectPrinter
{
    if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
        PrinterListViewController *printerVC = [[PrinterListViewController alloc] init];
        [self.navigationController pushViewController:printerVC animated:YES];
    }else
    {
        TMXLoginVC *login=[[TMXLoginVC alloc]initWithNibName:@"TMXLoginVC" bundle:nil];
        [ShareApp.drawerController setCenterViewController:login withCloseAnimation:YES completion:nil];
    }
    
}

#pragma mark - TMXHomeDetailShareViewDelegate
-(void)clickModelShare
{
    
}

-(void)clickCaseShare
{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    UIAlertAction * photographAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Photograph", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction * myPhotoAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"MyPhoto", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];


    [cancelAction setValue:systemColor forKey:@"_titleTextColor"];
    [photographAction setValue:systemColor forKey:@"_titleTextColor"];
    [myPhotoAction setValue:systemColor forKey:@"_titleTextColor"];
    
    
    [alertVC addAction:cancelAction];
    [alertVC addAction:photographAction];
    [alertVC addAction:myPhotoAction];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}


@end
