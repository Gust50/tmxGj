//
//  TMXHomeSearchVC.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/8/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXHomeSearchVC.h"
#import "TMXHomeDisplayModelCell.h"
#import "TMXHomeModelDetailVC.h"
#import "TMXHomeSearchModel.h"

@interface TMXHomeSearchVC ()<UISearchBarDelegate, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    TMXHomeSearchModel *searchModel;    ///<搜索模型
    NSMutableDictionary *params;        ///<传入参数
}

@property (nonatomic, strong)UISearchBar *searchBar;
@property (nonatomic, strong)UICollectionView *collectView;

@end

@implementation TMXHomeSearchVC
static NSString *const modelCellID=@"modelCellID";

#pragma mark - lazyLoad
-(UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, 40)];
        _searchBar.delegate = self;
        NSString *_search = NSLocalizedString(@"Search", nil);
        _searchBar.placeholder = _search;
    }
    return _searchBar;
}

-(UICollectionView *)collectView{
    if (!_collectView) {
        UICollectionViewFlowLayout *flowLayout=[UICollectionViewFlowLayout new];
        flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
        _collectView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 104, SCREENWIDTH, SCREENHEIGHT-104) collectionViewLayout:flowLayout];
        _collectView.showsVerticalScrollIndicator=NO;
        _collectView.delegate=self;
        _collectView.dataSource=self;
        _collectView.backgroundColor = backGroundColor;
    }
    return _collectView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backGroundColor;
    NSString *_search = NSLocalizedString(@"Search", nil);
    [self.navigationItem setTitle:_search];
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.collectView];
    self.collectView.hidden = YES;
    searchModel = [[TMXHomeSearchModel alloc] init];
    params = [NSMutableDictionary dictionary];
    
    //注册cell
    [_collectView registerClass:[TMXHomeDisplayModelCell class] forCellWithReuseIdentifier:modelCellID];
    
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
- (void)loadData
{
    params[@"keywords"] = self.searchBar.text;
    [searchModel FetchTMXHomeSearchModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            searchModel = result;
            [self.collectView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark - <UISearchBarDelegate>
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    self.searchBar.showsCancelButton = YES;
    for (id obj in [searchBar subviews]) {
        if ([obj isKindOfClass:[UIView class]]) {
            for (id obj2 in [obj subviews]) {
                if ([obj2 isKindOfClass:[UIButton class]]) {
                    UIButton *btn = (UIButton *)obj2;
                    NSString *_search = NSLocalizedString(@"Search", nil);
                    [btn setTitle:_search forState:UIControlStateNormal];
                    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }
            }
        }
    }
    return YES;
}

//点击搜索框上的 取消按钮时 调用
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    self.collectView.hidden = NO;
    [self loadData];
    [searchBar resignFirstResponder];
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    self.searchBar.showsCancelButton = NO;
    
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.collectView.hidden = NO;
    [self loadData];
    [searchBar resignFirstResponder];
    
}

#pragma mark <UICollectionViewDataSource>
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return searchModel.searchResult.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TMXHomeDisplayModelCell *modelCell=[collectionView dequeueReusableCellWithReuseIdentifier:modelCellID forIndexPath:indexPath];
    modelCell.isProfile = NO;
    modelCell.searchListModel = searchModel.searchResult[indexPath.item];
    return modelCell;
}

#pragma mark <UICollectionViewDelegate>
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREENWIDTH-15*AppScale)/2, 150*AppScale);
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
    TMXHomeSearchListModel *listModel = searchModel.searchResult[indexPath.item];
    tMXHomeModelDetailVC.modelId = listModel.searchID;
    [self.navigationController pushViewController:tMXHomeModelDetailVC animated:YES];
}

@end
