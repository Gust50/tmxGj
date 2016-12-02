//
//  TMXLikeVC.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/8/29.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXLikeVC.h"
#import "TMXHomeDisplayModelCell.h"
#import "AppDelegate.h"
#import "TMXHomeModelDetailVC.h"
#import "TMXLikeModel.h"
#import "KBLeftMenuBar.h"
#import "TMXPrinterListViewController.h"
#import "TMXLoginVC.h"


@interface TMXLikeVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,KBLeftMenuBarDelegate>
{
    TMXLikeModel *likeModel;        ///<喜欢模型
    NSMutableDictionary *params;    ///<参数
    NSInteger pageNum;              ///<当前页码
    KBLeftMenuBar *leftMenuBar;
    
}
@property (nonatomic, strong) UICollectionView *collectView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIButton *printerBtn;
@end

@implementation TMXLikeVC
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
    pageNum = 1;
    [self.collectView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:NSLocalizedString(@"Like", nil)];
    self.collectView.backgroundColor=backGroundColor;
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.view addSubview:self.collectView];
    likeModel = [[TMXLikeModel alloc] init];
    params = [NSMutableDictionary dictionary];
    
    [_collectView registerClass:[TMXHomeDisplayModelCell class] forCellWithReuseIdentifier:modelCellID];
    
    [self configureLeftBarButtonWithTitle:nil icon:@"MenuIcon" action:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationSelectRow" object:nil userInfo:@{@"select":@"4"}];
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
#warning 修改处
//    [self.view addSubview:leftMenuBar];
    [self.view addSubview:self.printerBtn];

}

#pragma mark - loadData
- (void)loadNewData
{
    pageNum = 1;
    params[@"pageNumber"] = @(pageNum);
    params[@"pageSize"] = @(10);
    [likeModel FetchTMXLikeModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            likeModel = result;
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:likeModel.modelList];
            [self.collectView reloadData];
            [self.collectView.mj_header endRefreshing];
            
            if (likeModel.modelList.count < 10) {
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
    
    if (pageNum <= likeModel.totalPage) {
        [likeModel FetchTMXLikeModel:params callBack:^(BOOL isSuccess, id result) {
            
            if (isSuccess) {
                likeModel = result;
                [self.dataSource addObjectsFromArray:likeModel.modelList];
                [self.collectView.mj_footer endRefreshing];
                [self.collectView reloadData];
                
                if (likeModel.modelList.count < 10) {
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
    modelCell.isProfile = NO;
    modelCell.likeListModel = self.dataSource[indexPath.item];
    return modelCell;
}

#pragma mark <UICollectionViewDelegate>
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREENWIDTH-15*AppScale)/2, 170*AppScale);
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
    return UIEdgeInsetsMake(5*AppScale, 5*AppScale, 0, 5*AppScale);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [leftMenuBar hideLeftMenuBarItems];
    TMXHomeModelDetailVC *tMXHomeModelDetailVC=[TMXHomeModelDetailVC new];
    tMXHomeModelDetailVC.isProfile = NO;
    TMXLikeListModel *listModel = self.dataSource[indexPath.item];
    tMXHomeModelDetailVC.modelId = listModel.likeID;
    [self.navigationController pushViewController:tMXHomeModelDetailVC animated:YES];
}

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
