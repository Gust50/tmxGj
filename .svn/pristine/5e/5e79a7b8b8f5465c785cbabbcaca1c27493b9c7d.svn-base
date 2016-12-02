//
//  KBGuideViewController.m
//  TMX3DPrinter
//
//  Created by kobe on 16/9/21.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "KBGuideViewController.h"

@interface KBGuideViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *startBtn;
@property (nonatomic, strong) UIButton *skipBtn;
@end

@implementation KBGuideViewController


-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        _scrollView.showsVerticalScrollIndicator=NO;
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.pagingEnabled=YES;
        _scrollView.scrollEnabled=YES;
        _scrollView.delegate=self;
    }
    return _scrollView;
}

-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT-80*AppScale, SCREENWIDTH, 30*AppScale)];
        _pageControl.currentPage=0;
        _pageControl.pageIndicatorTintColor=[UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor=systemColor;
    }
    return _pageControl;
}

-(UIButton *)startBtn{
    if (!_startBtn) {
        _startBtn=[UIButton buttonWithType:0];
        _startBtn.frame=CGRectMake(SCREENWIDTH/2-40*AppScale, SCREENHEIGHT-80, 80*AppScale, 35*AppScale);
        _startBtn.backgroundColor=systemColor;
        _startBtn.layer.cornerRadius=5.0;
        _startBtn.layer.masksToBounds=YES;
        [_startBtn setTitle:NSLocalizedString(@"Imme", nil) forState:0];
        [_startBtn setTitleColor:[UIColor whiteColor] forState:0];
        _startBtn.titleLabel.font=[UIFont systemFontOfSize:15*AppScale];
        [_startBtn addTarget:self action:@selector(touchStartBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startBtn;
}

-(UIButton *)skipBtn{
    if (!_skipBtn) {
        _skipBtn=[UIButton buttonWithType:0];
        _skipBtn.frame=CGRectMake(SCREENWIDTH-100*AppScale, 0*AppScale, 120*AppScale, 100*AppScale);
        _skipBtn.backgroundColor=[UIColor clearColor];
        [_skipBtn addTarget:self action:@selector(touchSkipBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipBtn;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:self.scrollView];
    _scrollView.contentSize=CGSizeMake(SCREENWIDTH*_guideImgArr.count, SCREENHEIGHT);
    
    for (int i=0; i<_guideImgArr.count; i++) {
//        NSString *imgName=[NSString stringWithFormat:@"第%d页.jpg",i+1];
        UIImageView *imgView=[UIImageView new];
        imgView.image=[UIImage imageNamed:_guideImgArr[i]];
        imgView.frame=CGRectMake(i*SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT);
        [_scrollView addSubview:imgView];
    }
    
//    [self.view addSubview:self.pageControl];
//    _pageControl.numberOfPages=_guideImgArr.count;
    
    [self.view addSubview:self.startBtn];
#warning appstore crash
    [self.view addSubview:self.skipBtn];
    _startBtn.hidden=YES;
}


-(void)touchStartBtn:(UIButton *)btn{
    if (self.startBtnBlock) {
        self.startBtnBlock();
    }
}

-(void)touchSkipBtn:(UIButton *)btn{
    if (self.skipBtnBlock) {
        self.skipBtnBlock();
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger currentPages=scrollView.contentOffset.x/SCREENWIDTH;
//    _pageControl.currentPage=currentPages;
    if (currentPages==_guideImgArr.count-1) {
        _startBtn.hidden=NO;
    }else{
        _startBtn.hidden=YES;
    }
}

#pragma makr <getter setter>
-(void)setGuideImgArr:(NSArray *)guideImgArr{
    _guideImgArr=guideImgArr;
}
@end
