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

@interface TMXLikeVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectView;
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

#pragma mark <lifeCycle>

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(234, 97, 1) colorWithAlphaComponent:1]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"喜欢"];
    
    self.collectView.backgroundColor=backGroundColor;
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.view addSubview:self.collectView];
    
    [_collectView registerClass:[TMXHomeDisplayModelCell class] forCellWithReuseIdentifier:modelCellID];
    
    [self configureLeftBarButtonWithTitle:nil icon:@"MenuIcon" action:^{
        [ShareApp.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }];
}

#pragma mark <UICollectionViewDataSource>
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 8;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TMXHomeDisplayModelCell *modelCell=[collectionView dequeueReusableCellWithReuseIdentifier:modelCellID forIndexPath:indexPath];
    return modelCell;
}

#pragma mark <UICollectionViewDelegate>
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREENWIDTH-10)/2, 150*AppScale);
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

@end
