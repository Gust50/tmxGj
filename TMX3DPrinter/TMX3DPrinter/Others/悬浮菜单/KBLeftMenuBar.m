//
//  KBLeftMenuBar.m
//  KBAnimationExample
//
//  Created by kobe on 16/9/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "KBLeftMenuBar.h"
#import "KBMenuItem.h"
#import "KBAnimationTool.h"

@interface KBLeftMenuBar ()

@property (nonatomic, strong) UIButton *arrowBtn;
@property (nonatomic, strong) NSArray *itemArr;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *lineBackgroundView;
@end

@implementation KBLeftMenuBar

#pragma mark <lazyLoad>
-(NSArray *)itemArr{
    if (!_itemArr) {
        _itemArr=[NSArray array];
    }
    return _itemArr;
}

-(UIButton *)arrowBtn{
    if (!_arrowBtn) {
        _arrowBtn=[UIButton buttonWithType:0];
        [_arrowBtn setTitle:@"   " forState:0];
        [_arrowBtn setTitleColor:[UIColor blueColor] forState:0];
        _arrowBtn.frame=CGRectMake(0, 0, 60, 35);
//        _arrowBtn.layer.cornerRadius=35/2;
//        _arrowBtn.layer.masksToBounds=YES;
        _arrowBtn.center=self.center;
        [_arrowBtn setBackgroundImage:[UIImage imageNamed:@"menu_background"] forState:0];
        [_arrowBtn setImage:[UIImage imageNamed:@"menu_arrow"] forState:0];
        [_arrowBtn addTarget:self action:@selector(arrowBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _arrowBtn;
}

-(UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView=[[UIView alloc]initWithFrame:CGRectMake(50, 0, 1, 35)];
        _backgroundView.backgroundColor=systemColor;
        _backgroundView.layer.cornerRadius=35/2.0;
        _backgroundView.layer.masksToBounds=YES;
    }
    return _backgroundView;
}

-(UIView *)lineBackgroundView{
    if (!_lineBackgroundView) {
        _lineBackgroundView=[[UIView alloc]initWithFrame:CGRectMake(50, 1, 1, 33)];
        _lineBackgroundView.backgroundColor=[UIColor clearColor];
        _lineBackgroundView.layer.borderWidth=1;
        _lineBackgroundView.layer.masksToBounds=YES;
        _lineBackgroundView.layer.cornerRadius=34/2;
        _lineBackgroundView.layer.borderColor=[UIColor whiteColor].CGColor;
    }
    return _lineBackgroundView;
}


-(instancetype)initWithMenuItemsNormalImg:(NSArray *)normalImgArr highlightImg:(NSArray *)highlightImgArr size:(CGSize)size{
    if (self==[super init]) {
        
        self.frame=CGRectMake(0, 0, size.width, size.height);
//        self.layer.cornerRadius=size.width/2;
//        self.layer.masksToBounds=YES;
        //添加视图
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.backgroundView];
        [self addSubview:self.lineBackgroundView];
        [self layoutMenuItemNormalImg:normalImgArr hihtlight:highlightImgArr];
        [self addSubview:self.arrowBtn];
        
    }
    return self;
}

-(void)arrowBtn:(UIButton *)btn{
    if (_isShow) {
        [self hideLeftMenuBarItems];
        [self hideBackgroundView];
        _isShow=NO;
    }else{
         [self showBackgroundView];
        _arrowBtn.hidden=YES;
        [self showLeftMenuBarItems];
        _isShow=YES;
    }
    
//    
//    [self showBackgroundView];
//    _arrowBtn.hidden=YES;
//    [self showLeftMenuBarItems];
    
}


-(void)hideBackgroundView{
    [UIView animateWithDuration:0.4 animations:^{
        CGRect tempRect=CGRectMake(50, 0, 1, 35);
        _backgroundView.frame=tempRect;
        
        CGRect lineTempRect=CGRectMake(50, 1, 1, 33);
        _lineBackgroundView.frame=lineTempRect;
    }];
}
-(void)showBackgroundView{
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect tempRect=_backgroundView.frame;
        tempRect.size.width=-200;
        _backgroundView.frame=tempRect;
        
        CGRect lineTempRect=_lineBackgroundView.frame;
        lineTempRect.size.width=-198;
        _lineBackgroundView.frame=lineTempRect;
    }];
}
-(void)showLeftMenuBarItems{
    
    CGFloat count=_itemArr.count;
    for (KBMenuItem *item in _itemArr) {
//        CGPoint point=[self caculatorLeftMenuItemPoint:CGPointMake(self.frame.size.width/2+20, self.frame.size.height/2) increasementSize:CGSizeMake(-self.frame.size.width-10, 0) index:count];
        CGPoint point=[self caculatorLeftMenuItemPoint:CGPointMake(self.arrowBtn.center.x+20, self.self.arrowBtn.center.y) increasementSize:CGSizeMake(-self.frame.size.width-10, 0) index:count];
        [item showMenuItemWithPoint:point];
        count--;
    }
}

-(void)hideLeftMenuBarItems{
    [self hideBackgroundView];
    _isShow=NO;
    _arrowBtn.hidden=NO;
    for (KBMenuItem *item in _itemArr) {
        [item hideMenuItem];
    }
}

-(CGPoint)caculatorLeftMenuItemPoint:(CGPoint)point
                 increasementSize:(CGSize)size
                            index:(NSInteger)index{
    CGFloat x=point.x;
    CGFloat y=point.y;
    x+=size.width*index;
    y+=size.height*index;
    CGPoint tempPoint=CGPointMake(x, y);
    return tempPoint;
}

-(void)layoutMenuItemNormalImg:(NSArray *)normalImg hihtlight:(NSArray *)highlight{
    NSMutableArray *tempArr=[NSMutableArray array];
    for (int i=0; i<normalImg.count; i++) {
        KBMenuItem *item=[KBMenuItem menuItemWithNormalImg:normalImg[i] highlightImg:highlight[i] size:CGSizeMake(self.frame.size.width, self.frame.size.height) target:self action:@selector(menuItemBtn:)];
        item.tag=100+i;
        item.center=self.arrowBtn.center;
        [self addSubview:item];
        [tempArr addObject:item];
    }
    self.itemArr=tempArr;
}


-(void)menuItemBtn:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickLeftMenuBarItem:)]) {
        [self.delegate clickLeftMenuBarItem:btn.tag-100];
    }
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *result=[super hitTest:point withEvent:event];
    if (_isShow) {
        for (KBMenuItem *item in _itemArr) {
            CGPoint itemPoint=[item convertPoint:point fromView:self];
            if ([item pointInside:itemPoint withEvent:event]) {
                return item;
            }
        }
    }
    return result;
}

#pragma mark <getter setter>
-(void)setIsShow:(BOOL)isShow{
    _isShow=isShow;
}
@end
