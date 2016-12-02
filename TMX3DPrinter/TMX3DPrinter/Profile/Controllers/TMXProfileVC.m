//
//  TMXProfileVC.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/8/29.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXProfileVC.h"
#import "TMXHomeDisplayModelCell.h"
#import "AppDelegate.h"
#import "TMXHomeModelDetailVC.h"
#import "TMXProfileModel.h"
#import "KBLeftMenuBar.h"
#import "TMXPrinterListViewController.h"
#import "TMXLoginVC.h"

@interface TMXProfileVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,KBLeftMenuBarDelegate>
{
    TMXProfileModel *profileModel;  ///<我的模型
    NSMutableDictionary *params;    ///<参数
    NSInteger pageNum;              ///<当前页数
    KBLeftMenuBar *leftMenuBar;
}
@property (nonatomic, strong) UICollectionView *collectView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIButton *printerBtn;
@end

@implementation TMXProfileVC
static NSString *const modelCellID=@"modelCellID";

#pragma mark <lazyLoad>
-(UICollectionView *)collectView{
    if (!_collectView) {
        UICollectionViewFlowLayout *flowLayout=[UICollectionViewFlowLayout new];
        flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
        _collectView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64) collectionViewLayout:flowLayout];
        _collectView.showsVerticalScrollIndicator=NO;
        _collectView.delegate=self;
        _collectView.dataSource=self;
    }
    return _collectView;
}

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(UIButton *)printerBtn{
    if (!_printerBtn) {
        _printerBtn=[UIButton buttonWithType:0];
        _printerBtn.frame=CGRectMake(0, 0, 50, 50);
        _printerBtn.backgroundColor=[UIColor orangeColor];
        _printerBtn.layer.masksToBounds=YES;
        _printerBtn.layer.cornerRadius=25.0;
        _printerBtn.center=CGPointMake(280*AppScale, 530*AppScale);
        [_printerBtn setBackgroundImage:[UIImage imageNamed:@"printer_background"] forState:0];
        [_printerBtn setImage:[UIImage imageNamed:@"printer"] forState:0];
        [_printerBtn addTarget:self action:@selector(skipPrinterList) forControlEvents:UIControlEventTouchUpInside];
    }
    return _printerBtn;
}


#pragma mark <lifeCycle>

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(234, 97, 1) colorWithAlphaComponent:1]];
    [self.collectView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:NSLocalizedString(@"Profile", nil)];
    
    self.collectView.backgroundColor=backGroundColor;
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.view addSubview:self.collectView];
    profileModel = [[TMXProfileModel alloc] init];
    params = [NSMutableDictionary dictionary];
    
    
    [_collectView registerClass:[TMXHomeDisplayModelCell class] forCellWithReuseIdentifier:modelCellID];
    
    [self configureLeftBarButtonWithTitle:nil icon:@"MenuIcon" action:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationSelectRow" object:nil userInfo:@{@"select":@"6"}];
        [ShareApp.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }];
    
    self.collectView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.collectView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.collectView.mj_footer.hidden=YES;
    [self.collectView.mj_header beginRefreshing];
    
    leftMenuBar=[[KBLeftMenuBar alloc]initWithMenuItemsNormalImg:@[@"toy_block",@"model",@"painting"] highlightImg:@[@"toy_block",@"model",@"painting"] size:CGSizeMake(35, 35)];
    leftMenuBar.delegate=self;
    leftMenuBar.center=CGPointMake(250*AppScale, 530*AppScale);
    leftMenuBar.isShow=NO;
//    [self.view addSubview:leftMenuBar];
    [self.view addSubview:self.printerBtn];
}

#pragma mark - loadData
- (void)loadNewData
{
    pageNum = 1;
    params[@"pageNumber"] = @(1);
    params[@"pageSize"] = @(10);
    params[@"userId"] = [FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
    [profileModel FetchTMXProfileModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            profileModel = result;
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:profileModel.modelList];
            [self.collectView reloadData];
            [self.collectView.mj_header endRefreshing];
            
            if (profileModel.modelList.count < 10) {
                self.collectView.mj_footer.hidden = YES;
                [self.collectView.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                self.collectView.mj_footer.hidden=NO;
                [self.collectView.mj_footer resetNoMoreData];
            }
        }else
        {
            [self.collectView.mj_header endRefreshing];
        }
    }];
}

//加载更多数据
-(void)loadMoreData
{
    pageNum++;
    params[@"pageNumber"]=@(pageNum);
    if (pageNum <= profileModel.totalPage) {
        [profileModel FetchTMXProfileModel:params callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                profileModel = result;
                [self.dataSource addObjectsFromArray:profileModel.modelList];
                [self.collectView.mj_footer endRefreshing];
                [self.collectView reloadData];
                
                if (profileModel.modelList.count < 10) {
                    [self.collectView.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    [self.collectView.mj_footer endRefreshing];
                }
            }
        }];
    }else
    {
        [self.collectView.mj_footer endRefreshingWithNoMoreData];
    }
    
}

#pragma mark <UICollectionViewDataSource>
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TMXHomeDisplayModelCell *modelCell=[collectionView dequeueReusableCellWithReuseIdentifier:modelCellID forIndexPath:indexPath];
    modelCell.isProfile = YES;
    modelCell.profileListModel = self.dataSource[indexPath.item];
    return modelCell;
}

#pragma mark <UICollectionViewDelegate>
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREENWIDTH-10)/2, 170*AppScale);
}

//row
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5*AppScale;
}

//column
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5*AppScale;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [leftMenuBar hideLeftMenuBarItems];
    TMXHomeModelDetailVC *tMXHomeModelDetailVC=[TMXHomeModelDetailVC new];
    tMXHomeModelDetailVC.isProfile = YES;
    TMXProfileListModel *listModel = self.dataSource[indexPath.row];
    tMXHomeModelDetailVC.modelId = listModel.profileID;
    tMXHomeModelDetailVC.isModelOpen = listModel.isShare;
    [self.navigationController pushViewController:tMXHomeModelDetailVC animated:YES];
}

#pragma mark <touch>
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [leftMenuBar hideLeftMenuBarItems];
}

#pragma mark <KBLeftMenuBarDelegate>
-(void)clickLeftMenuBarItem:(NSInteger)index{
    NSLog(@"%@",@(index));
}

//跳转打印机
- (void)skipPrinterList
{
    
    if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
        KBNavigationVC *navigation=[[KBNavigationVC alloc]initWithRootViewController:[TMXPrinterListViewController new]];
        [ShareApp.drawerController setCenterViewController:navigation withCloseAnimation:YES completion:nil];
    }else{
        
        TMXLoginVC *login=[[TMXLoginVC alloc]initWithNibName:@"TMXLoginVC" bundle:nil];
        [ShareApp.drawerController setCenterViewController:login withCloseAnimation:YES completion:nil];
    }
}
@end
