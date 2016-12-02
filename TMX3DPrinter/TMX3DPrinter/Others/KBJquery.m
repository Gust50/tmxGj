//
//  KBJquery.m
//  ClshUser
//
//  Created by kobe on 16/5/25.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "KBJquery.h"

@interface KBJquery()<UIScrollViewDelegate>

/** 视图滚动 */
@property(nonatomic,strong)UIScrollView *scrollView;
/** 页面 */
@property(nonatomic,strong)UIPageControl *pageControl;
/** 设置滚动的时间 */
@property(nonatomic,strong)NSTimer *timer;

@end

@implementation KBJquery

#pragma mark <lazyLoad>
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        
        _scrollView=[[UIScrollView alloc]initWithFrame:self.frame];
        _scrollView.delegate=self;
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.showsVerticalScrollIndicator=NO;
        _scrollView.pagingEnabled=YES;
        _scrollView.scrollEnabled=YES;
        
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pageClick)];
        [_scrollView addGestureRecognizer:tapGesture];
    }
    return _scrollView;
}

-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl=[[UIPageControl alloc]init];
        _pageControl.userInteractionEnabled=YES;
        _pageControl.numberOfPages=_imageArray.count;
        _pageControl.currentPage=0;
        //设置未选中时的颜色
        _pageControl.pageIndicatorTintColor=[UIColor whiteColor];
        //设置选中时的颜色
        _pageControl.currentPageIndicatorTintColor=[UIColor redColor];
        [_pageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}


#pragma mark <init>
-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
}

#pragma mark scrollview代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //偏移还再显示屏幕内
    if (scrollView.contentOffset.x<self.frame.size.width) {
        [self.scrollView setContentOffset:CGPointMake(self.frame.size.width*(_imageArray.count+1), 0) animated:NO];
    }
    //当偏移超出屏幕时
    if (scrollView.contentOffset.x>self.frame.size.width*(_imageArray.count+1)) {
        [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
    }
    //计算当前的页数
    int pageCount=scrollView.contentOffset.x/self.frame.size.width;
    if (pageCount>_imageArray.count) {
        pageCount=0;
    }
    else if (pageCount==0){
        pageCount=(int)_imageArray.count-1;
    }
    else{
        pageCount--;
    }
    self.pageControl.currentPage=pageCount;
}

//开始拖动
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
}
//结束拖动
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}


#pragma mark <otherResponse>
//点击页面
-(void)pageClick{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickScrollViewPage:index:)]) {
        [self.delegate clickScrollViewPage:self index:_pageControl.currentPage];
    }
}

//添加page的值发生改变时执行这个动作
-(void)pageChange:(UIPageControl *)page{
    
    CGFloat x=page.currentPage*self.frame.size.width;
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}

//计算图片无限循环滚动
-(void)setUpImage:(NSArray *)array{
    CGSize contentSize;
    CGPoint startPoint;
    //大于1张以上的情况
    if (array.count>1) {
        //无限滚动时候，需要多添加两张
        for (int i=0; i<array.count+2; i++) {
            UIImageView *imageview =[[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width*i,0, self.frame.size.width,self.frame.size.height)];
//#warning 图片自适应
            [imageview setContentMode:UIViewContentModeScaleToFill];
            if (i==0) {
                //第一个imageview放最后一张
                //                imageview.image=[UIImage imageNamed:array[array.count-1]];
                _isWebImage==YES?[imageview sd_setImageWithURL:[NSURL URLWithString:array[array.count-1]]]:(imageview.image=[UIImage imageNamed:array[array.count-1]]);
            }
            else if (i==array.count+1){
                //最后一个imageview放第一张
                //                imageview.image=[UIImage imageNamed:array[0]];
                _isWebImage==YES?[imageview sd_setImageWithURL:[NSURL URLWithString:array[0]]]:(imageview.image=[UIImage imageNamed:array[0]]);
            }
            else{
                //                imageview.image=[UIImage imageNamed:array[i-1]];
                _isWebImage==YES?[imageview sd_setImageWithURL:[NSURL URLWithString:array[i-1]]]:(imageview.image=[UIImage imageNamed:array[i-1]]);
            }
            [self.scrollView addSubview:imageview];
            contentSize=CGSizeMake((array.count+2)*self.frame.size.width, 0);
            startPoint=CGPointMake(self.frame.size.width, 0);
        }
    }
    //只有一张图片的情况
    else{
        
        for (int i=0; i<array.count; i++) {
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width*i, 0, self.frame.size.width, self.frame.size.height)];
//#warning 图片自适应
            [imageView setContentMode:UIViewContentModeScaleToFill];
            //            imageView.image=[UIImage imageNamed:array[i]];
            _isWebImage==YES?[imageView sd_setImageWithURL:[NSURL URLWithString:array[i]]]:(imageView.image=[UIImage imageNamed:array[i]]);
            [self.scrollView addSubview:imageView];
        }
        contentSize=CGSizeMake(self.frame.size.width, 0);
        startPoint=CGPointZero;
    }
    self.scrollView.contentSize=contentSize;
    self.scrollView.contentOffset=startPoint;
}

#pragma mark Timer时间方法
-(void)startTimer{

    if (!_duration) {
        //时间定时器
        self.timer=[NSTimer timerWithTimeInterval:5.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    }
    else{
        self.timer=[NSTimer timerWithTimeInterval:_duration target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    }
    //添加一个定时器
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
}
//每次移动的距离
-(void)updateTimer{
    CGPoint newOffset=CGPointMake(self.scrollView.contentOffset.x+CGRectGetWidth(self.scrollView.frame), 0);
    [self.scrollView setContentOffset:newOffset animated:YES];
}


#pragma mark <getter setter>
//传入一个图片数组
-(void)setImageArray:(NSArray *)imageArray{
    
    _imageArray=imageArray;
    _pageControl.numberOfPages=_imageArray.count;
    //自动计算大小
    CGSize pageSize=[_pageControl sizeForNumberOfPages:_imageArray.count];
    _pageControl.bounds=CGRectMake(0, 0, pageSize.width, pageSize.height);
    _pageControl.center=CGPointMake(self.center.x, self.frame.size.height-20);
    [self setUpImage:imageArray];
    [self.timer invalidate];
    
    if (imageArray.count>1) {
        self.pageControl.hidden=NO;
         [self startTimer];
    }else{
        
        self.pageControl.hidden=YES;
    }
   
}

//轮播时间
-(void)setDuration:(NSTimeInterval)duration{
    
    _duration=duration;
    [self.timer invalidate];
    [self startTimer];
}

//设置选中时的颜色
-(void)setSelectColor:(UIColor *)selectColor{
    
    _pageControl.currentPageIndicatorTintColor=selectColor;
}

//设置未选中时的颜色
-(void)setUnselectColor:(UIColor *)unselectColor{
    
    _pageControl.pageIndicatorTintColor=unselectColor;
}

@end
