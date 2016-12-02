//
//  TMXHomeScrollViewCell.m
//  TMX3DPrinter
//
//  Created by kobe on 16/8/25.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXHomeScrollViewCell.h"
#import "KBtopImgBottomTextBtn.h"
#import "TMXHomeModel.h"

@interface TMXHomeScrollViewCell ()<UIScrollViewDelegate, KBtopImgBottomTextBtnDelegate>
{
    NSInteger count;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation TMXHomeScrollViewCell

#pragma mark <lazyLoad>
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView=[UIScrollView new];
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.delegate=self;
    }
    return _scrollView;
}

-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl=[UIPageControl new];
        _pageControl.currentPageIndicatorTintColor=systemColor;
        _pageControl.pageIndicatorTintColor=[UIColor lightGrayColor];
    }
    return _pageControl;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    [self updateConstraints];
    
}

-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.top.equalTo(weakSelf.mas_top);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(_pageControl.mas_top);
    }];
    
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.height.mas_equalTo(@(20*AppScale));
    }];
}

-(void)layoutBtn:(TMXHomeModel *)model{
    
    for (int i=0; i<[model.categoryList count]; i++) {
        KBtopImgBottomTextBtn *btn=[[KBtopImgBottomTextBtn alloc]initWithFrame:CGRectMake(i*SCREENWIDTH/4, 0, SCREENWIDTH/4, SCREENWIDTH/4)];
        btn.isHomeIcon = YES;
        TMXHomeCategoryListModel *tempModel = model.categoryList[i];
        btn.nameContent=tempModel.name;
        btn.iconUrl=tempModel.bigIcon;
        btn.classifyID = tempModel.categoryID;
        btn.textFont=[UIFont systemFontOfSize:11*AppScale];
        btn.textColor=[UIColor blackColor];
        btn.delegate = self;
        [_scrollView addSubview:btn];
        
    }
    NSInteger totalPages=0;
    if (model.categoryList.count%4==0) {
        totalPages=model.categoryList.count/4;
    }else{
        totalPages=model.categoryList.count/4+1;
    }
    _scrollView.contentSize=CGSizeMake(SCREENWIDTH*totalPages, _scrollView.bounds.size.height);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger currentPages=scrollView.contentOffset.x/SCREENWIDTH;
    _pageControl.currentPage=currentPages;
    
}

#pragma mark - KBtopImgBottomTextBtnDelegate
-(void)clickKBtopImgBottomTextBtn:(NSInteger)categoryID
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickClassifyList:)]) {
        [self.delegate clickClassifyList:categoryID];
    }
}

#pragma mark - setter getter
-(void)setHomeModel:(TMXHomeModel *)homeModel
{
    _homeModel = homeModel;
    if (homeModel.categoryList.count%4==0) {
        _pageControl.numberOfPages=homeModel.categoryList.count/4;
    }else{
         _pageControl.numberOfPages=homeModel.categoryList.count/4+1;
    }
    [self layoutBtn:homeModel];
}

@end
