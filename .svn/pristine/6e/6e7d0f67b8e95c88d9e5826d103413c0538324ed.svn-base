//
//  TMXHomeVC.m
//  TMX3DPrinterHD
//
//  Created by kobe on 16/8/19.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXHomeVC.h"
#import "TMXHomeDisplayModelCell.h"
#import "TMXHomeJqueryHeaderView.h"
#import "TMXHomeHeaderView.h"
#import "TMXHomeScrollViewCell.h"
#import "TMXHomeDisplayAdvertCell.h"
#import "AppDelegate.h"
#import "TMXHomeNavigationView.h"
#import "TMXHomeModelDetailVC.h"
#import "TMXHomeSearchVC.h"
#import "TMXHomeClassifyListVC.h"
#import "TMXHomeModel.h"
#import "KBLeftMenuBar.h"
#import "TMXPrinterListViewController.h"
#import "TMXLoginVC.h"
#import "TMXAdvertiseWebVC.h"

@interface TMXHomeVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, TMXHomeNavigationViewDelegate, TMXHomeScrollViewCellDelegate, TMXHomeHeaderViewDelegate, TMXHomeJqueryHeaderViewDelegate, UIWebViewDelegate,KBLeftMenuBarDelegate>
{
    TMXHomeNavigationView *nav;
    TMXHomeModel *homeModel;        ///<首页
    KBLeftMenuBar *leftMenuBar;
    MBProgressHUD *hud;
}
@property (nonatomic, strong) UICollectionView *collectView;
@property (nonatomic, strong) UIButton *printerBtn;
@end

@implementation TMXHomeVC
static NSString *const modelCellID=@"modelCellID";
static NSString *const jqueryID=@"jqueryID";
static NSString *const headerID=@"headerID";
static NSString *const scrollID=@"scrollID";
static NSString *const advertID=@"advertID";

#pragma mark <lazyLoad>
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

#pragma mark <lifeCycle>

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(234, 97, 1) colorWithAlphaComponent:1]];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectView.backgroundColor=backGroundColor;
    [self initCollectView];
    homeModel = [[TMXHomeModel alloc] init];
    
    [self configureLeftBarButtonWithTitle:nil icon:@"MenuIcon" action:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationSelectRow" object:nil userInfo:@{@"select":@"0"}];
        [ShareApp.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }];
    
    [self configureRightBarButtonWithTitle:nil icon:@"MailIcon" action:^{
        
    }];
    
    
    //设置导航工具栏
    nav=[[TMXHomeNavigationView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH-70, 30)];
    nav.delegate = self;
//    self.navigationItem.titleView=nav;
    
    UIBarButtonItem *custom=[[UIBarButtonItem alloc]initWithCustomView:nav];
    self.navigationItem.rightBarButtonItem=custom;

    
    
    leftMenuBar=[[KBLeftMenuBar alloc]initWithMenuItemsNormalImg:@[@"toy_block",@"model",@"painting"] highlightImg:@[@"toy_block",@"model",@"painting"] size:CGSizeMake(35, 35)];
    leftMenuBar.delegate=self;
    leftMenuBar.center=CGPointMake(250*AppScale, 530*AppScale);
    leftMenuBar.isShow=NO;
#warning 修改处
//    [self.view addSubview:leftMenuBar];
    [self.view addSubview:self.printerBtn];
    
    [self loadData];
    
    hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.backgroundColor=[UIColor clearColor];
    hud.color=[UIColor clearColor];
    hud.activityIndicatorColor=systemColor;
    
    _collectView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateNewData)];
    _collectView.mj_footer.hidden=YES;
}



-(void)updateNewData{
    
    [homeModel FetchTMXHomeModel:nil callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            homeModel = result;
            [_collectView.mj_header endRefreshing];
            [self.collectView reloadData];
        }else
        {
            [_collectView.mj_header endRefreshing];
            hud.labelText=NSLocalizedString(@"Load_Fail", nil);
        }
    }];
}

#pragma mark - loadData
-(void)loadData
{
    [homeModel FetchTMXHomeModel:nil callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            homeModel = result;
            [hud hide:YES];
            [self.collectView reloadData];
        }else
        {
            hud.labelText=NSLocalizedString(@"Load_Fail", nil);
            [hud hide:YES afterDelay:2];
        }
    }];
}

//搜索模型
#pragma mark - TMXHomeNavigationViewDelegate
-(void)selectModel:(TMXHomeNavigationView *)navView
{
    TMXHomeSearchVC *searchVC = [[TMXHomeSearchVC alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

-(void)initCollectView{
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.view addSubview:self.collectView];
    
    [_collectView registerClass:[TMXHomeDisplayModelCell class] forCellWithReuseIdentifier:modelCellID];
    [_collectView registerClass:[TMXHomeDisplayAdvertCell class] forCellWithReuseIdentifier:advertID];
    [_collectView registerClass:[TMXHomeScrollViewCell class] forCellWithReuseIdentifier:scrollID];
    [_collectView registerClass:[TMXHomeJqueryHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:jqueryID];
    [_collectView registerClass:[TMXHomeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID];
    
}


#pragma mark <UICollectionViewDataSource>
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1+homeModel.categoryModelList.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else
    {
        TMXHomeCategoryModelListModel *model = homeModel.categoryModelList[section-1];
        return model.modelList.count;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
        TMXHomeScrollViewCell *scrollCell=[collectionView dequeueReusableCellWithReuseIdentifier:scrollID forIndexPath:indexPath];
        scrollCell.delegate = self;
        scrollCell.homeModel = homeModel;
        return scrollCell;
    }else{
        
        TMXHomeDisplayModelCell *modelCell=[collectionView dequeueReusableCellWithReuseIdentifier:modelCellID forIndexPath:indexPath];
        modelCell.isProfile = NO;
        if (homeModel.categoryModelList.count) {
            TMXHomeCategoryModelListModel *model = homeModel.categoryModelList[indexPath.section-1];
            if (model.modelList.count) {
                TMXHomeCategoryModelListListModel *listModel = [model.modelList objectAtIndexCheck:indexPath.item];
                modelCell.categryListModel = listModel;
            }
        }
        return modelCell;
//        if (indexPath.item==0) {
//            TMXHomeDisplayAdvertCell *advertCell=[collectionView dequeueReusableCellWithReuseIdentifier:advertID forIndexPath:indexPath];
//            TMXHomeCategoryModelListModel *model=[homeModel.categoryModelList objectAtIndexCheck:indexPath.section-1];
//            advertCell.advUrl=model.faceImg;
//            TMXHomeCategoryModelListModel *tempModel=homeModel.categoryModelList[indexPath.section-1];
//            advertCell.categoryID=tempModel.categoryModelID;
//            advertCell.showAdvertiseBlock=^(NSInteger categoryID){
//                [leftMenuBar hideLeftMenuBarItems];
//                TMXHomeClassifyListVC *classifyListVC = [[TMXHomeClassifyListVC alloc] init];
//                classifyListVC.categoryId = categoryID;
//                [self.navigationController pushViewController:classifyListVC animated:YES];
//            };
//            return advertCell;
//        }else{
//            
//        }
    }
}

#pragma mark <UICollectionViewDelegate>
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return CGSizeMake(SCREENWIDTH, 100*AppScale);
    }else{
        return CGSizeMake((SCREENWIDTH-15*AppScale)/2, 170*AppScale);
//        if (indexPath.item==0) {
//            return CGSizeMake(SCREENWIDTH, 100);
//        }else{
//            return CGSizeMake((SCREENWIDTH-15*AppScale)/2, 170*AppScale);
//        }
    }
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            TMXHomeJqueryHeaderView *jqueryHeaderView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:jqueryID forIndexPath:indexPath];
            jqueryHeaderView.delegate = self;
            NSMutableArray *jqueryArray = [NSMutableArray array];
            for (TMXHomeCarouselListModel *model in homeModel.carouselList) {
                [jqueryArray addObject:model.image];
            }
            jqueryHeaderView.jqueryArray = jqueryArray;
            
            return jqueryHeaderView;
        }
    }else{
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            TMXHomeHeaderView *headerView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
            headerView.delegate = self;
            if (homeModel.categoryModelList.count) {
                headerView.categoryModelListModel = homeModel.categoryModelList[indexPath.section-1];
            }
             return headerView;
        }
    }
     return nil;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return CGSizeMake(SCREENWIDTH, 125);
    }else{
        return CGSizeMake(SCREENWIDTH, 40*AppScale);
    }
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

    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 10*AppScale, 0);
    }else
    {
        return UIEdgeInsetsMake(5*AppScale, 5*AppScale, 10*AppScale, 5*AppScale);
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    [leftMenuBar hideLeftMenuBarItems];
    if (indexPath.section==0) {
        
    }else{
//        if (indexPath.row==0) {
//            
//        }else{
//            
//        }
        if (homeModel.categoryModelList.count) {
            TMXHomeCategoryModelListModel *model = homeModel.categoryModelList[indexPath.section-1];
            if (model.modelList.count) {
                TMXHomeCategoryModelListListModel *listModel = [model.modelList objectAtIndexCheck:indexPath.item];
                TMXHomeModelDetailVC *tMXHomeModelDetailVC=[TMXHomeModelDetailVC new];
                tMXHomeModelDetailVC.isProfile = NO;
                tMXHomeModelDetailVC.modelId = listModel.listListID;
                [self.navigationController pushViewController:tMXHomeModelDetailVC animated:YES];
            }
        }
    }
}

#pragma mark - TMXHomeJqueryHeaderViewDelegate
-(void)clickJquery:(NSInteger)tag
{
    [leftMenuBar hideLeftMenuBarItems];
    NSMutableArray *jqueryArray = [NSMutableArray array];
    for (TMXHomeCarouselListModel *model in homeModel.carouselList) {
        [jqueryArray addObject:model.url];
    }    
    TMXAdvertiseWebVC *webVC=[TMXAdvertiseWebVC new];
    webVC.webUrl=[jqueryArray objectAtIndexCheck:tag];
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - TMXHomeScrollViewCellDelegate
- (void)clickClassifyList:(NSInteger)categoryID
{
    [leftMenuBar hideLeftMenuBarItems];
    TMXHomeClassifyListVC *classifyListVC = [[TMXHomeClassifyListVC alloc] init];
    classifyListVC.categoryId = categoryID;
    [self.navigationController pushViewController:classifyListVC animated:YES];
}

#pragma mark - TMXHomeHeaderViewDelegate
- (void)clickMoreModel:(NSInteger)categoryID name:(NSString *)name
{
    [leftMenuBar hideLeftMenuBarItems];
    TMXHomeClassifyListVC *classifyListVC = [[TMXHomeClassifyListVC alloc] init];
    classifyListVC.categoryId = categoryID;
    classifyListVC.name = name;
    [self.navigationController pushViewController:classifyListVC animated:YES];
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
