//
//  TMXUploadModelByUserVC.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/22.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXUploadModelByUserVC.h"
#import "TMXUploadByUserModel.h"
#import "TMXHomeDisplayModelCell.h"
#import "TMXHomeModelDetailVC.h"

@interface TMXUploadModelByUserVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    TMXUploadByUserModel *userModel;        ///<查看用户上传的模型
    NSMutableDictionary *params;
    NSInteger pageNum;              ///<当前页码
}

@property (nonatomic, strong) UICollectionView *collectView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation TMXUploadModelByUserVC
static NSString *const modelCellID=@"modelCellID";

-(UICollectionView *)collectView{
    if (!_collectView) {
        UICollectionViewFlowLayout *flowLayout=[UICollectionViewFlowLayout new];
        flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
        _collectView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) collectionViewLayout:flowLayout];
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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(234, 97, 1) colorWithAlphaComponent:1]];
    [self.collectView.mj_header beginRefreshing];
    [self enableOpenLeftDrawer:NO];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self enableOpenLeftDrawer:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backGroundColor;
    self.collectView.backgroundColor=backGroundColor;
    NSString *mode = NSLocalizedString(@"Mod", nil);
    NSString *str = [NSString stringWithFormat:@"%@%@", self.ownerName, mode];
    [self.navigationItem setTitle:str];
    [self.view addSubview:self.collectView];
    userModel = [TMXUploadByUserModel new];
    params = [NSMutableDictionary dictionary];
    
    [_collectView registerClass:[TMXHomeDisplayModelCell class] forCellWithReuseIdentifier:modelCellID];
    
    self.collectView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.collectView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.collectView.mj_footer.hidden=YES;
    [self.collectView.mj_header beginRefreshing];
    
}

#pragma mark - loadData
- (void)loadNewData
{
    pageNum = 1;
    params[@"pageNumber"] = @(pageNum);
    params[@"pageSize"] = @(10);
    params[@"userId"] = @(self.userID);
    [userModel FetchTMXUploadByUserModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            userModel = result;
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:userModel.modelList];
            [self.collectView reloadData];
            [self.collectView.mj_header endRefreshing];
            
            if (userModel.modelList.count < 10) {
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
    
    if (pageNum <= userModel.totalPage) {
        [userModel FetchTMXUploadByUserModel:params callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                userModel = result;
                [self.dataSource addObjectsFromArray:userModel.modelList];
                [self.collectView.mj_footer endRefreshing];
                [self.collectView reloadData];
                
                if (userModel.modelList.count < 10) {
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
    modelCell.UploadByUserListModel = self.dataSource[indexPath.item];
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
    
    TMXHomeModelDetailVC *tMXHomeModelDetailVC=[TMXHomeModelDetailVC new];
    tMXHomeModelDetailVC.isProfile = NO;
    TMXUploadByUserListModel *listModel = self.dataSource[indexPath.item];
    tMXHomeModelDetailVC.modelId = listModel.modelId;
    [self.navigationController pushViewController:tMXHomeModelDetailVC animated:YES];
}

#pragma mark - setter getter
-(void)setOwnerName:(NSString *)ownerName
{
    _ownerName = ownerName;
}

-(void)setUserID:(NSInteger)userID
{
    _userID = userID;
}

@end
