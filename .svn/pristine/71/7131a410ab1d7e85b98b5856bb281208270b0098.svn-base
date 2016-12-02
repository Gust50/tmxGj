//
//  KBSegmentView.m
//  粗粮
//
//  Created by kobe on 16/5/18.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "KBSegmentView.h"

@interface KBSegmentView()

/** 下划线 */
@property(nonatomic,strong)UILabel *bottomLine;
/** 创建好的按钮放入数组中 */
@property(nonatomic,strong)NSMutableArray *btnSource;
/** 按钮的tag */
@property(nonatomic,assign)NSInteger selectBtnTag;
/** 按钮的宽度 */
@property(nonatomic,assign)CGFloat btnW;

@end

@implementation KBSegmentView

#pragma makr <lazyLoad>
-(UILabel *)bottomLine{
    if (!_bottomLine) {
        _bottomLine=[[UILabel alloc]init];
    }
    return _bottomLine;
}

-(NSMutableArray *)btnSource{
    if (!_btnSource) {
        _btnSource=[NSMutableArray array];
    }
    return _btnSource;
}

#pragma mark <init>
-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        
        self.selectBtnTag=0;
    }
    return self;
}

+(KBSegmentView *)createSegmentFrame:(CGRect)frame
                     segmentTitleArr:(NSArray *)segmentTitleArr
                     backgroundColor:(UIColor *)backgroundColor
                          titleColor:(UIColor *)titleColor
                    selectTitleColor:(UIColor *)selectTitleColor
                           titleFont:(UIFont *)titleFont
                     bottomLineColor:(UIColor *)bottomLineColor
                       isVerticleBar:(BOOL)isVerticalBar
                            delegate:(id)delegate
{
    KBSegmentView *kBSegmentView=[[self alloc]initWithFrame:frame];
    kBSegmentView.backgroundColor=backgroundColor;
    kBSegmentView.titleColor=titleColor;
    kBSegmentView.selectTitleColor=selectTitleColor;
    kBSegmentView.titleFont=titleFont;
    kBSegmentView.bottomLineColor=bottomLineColor;
    kBSegmentView.isVerticleBar=isVerticalBar;
    kBSegmentView.delegate=delegate;
    [kBSegmentView createButtonWithArray:segmentTitleArr];
    
    return kBSegmentView;
}

#pragma mark <createUI>
-(void)createButtonWithArray:(NSArray *)array{
    
   self.btnW=SCREENWIDTH/array.count;
    for (int i=0; i<array.count; i++) {
        UIButton *btn=[[UIButton alloc]init];
        btn.tag=i+1;
        btn.frame=CGRectMake(i*_btnW, 0, _btnW, self.bounds.size.height-2);
        [btn setTitleColor:self.titleColor forState:UIControlStateNormal];
        [btn setTitleColor:self.selectTitleColor forState:UIControlStateSelected];
        btn.titleLabel.font = _titleFont;
        [btn addTarget:self action:@selector(selectSegmentButton:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:array[i] forState:UIControlStateNormal];
     
        if (i==0) {
            self.bottomLine.frame=CGRectMake(i*_btnW, self.bounds.size.height-2, _btnW, 2);
            self.bottomLine.backgroundColor=self.bottomLineColor;
            [self addSubview:self.bottomLine];
        }
        
        if (self.isVerticleBar) {
            
            UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(i*_btnW, 0, 1, self.bounds.size.height)];
            line.backgroundColor=backGroundColor;
            [self addSubview:line];
        }
        
        [self addSubview:btn];
        [self.btnSource addObject:btn];
    }
    //选中第一个
    [[self.btnSource firstObject]setSelected:YES];
}

#pragma mark <otherResponse>
-(void)selectSegmentButton:(UIButton *)button{
    if (self.selectBtnTag!=button.tag-1) {
        
        for (UIButton *btn in self.btnSource) {
            btn.selected=NO;
        }
        
        [self.btnSource[button.tag-1] setSelected:YES];
        
        [UIView animateWithDuration:0.2 animations:^{
            
            _bottomLine.frame=CGRectMake((button.tag-1)*_btnW, self.bounds.size.height-2, _btnW, 2);
        }];
        self.selectBtnTag=button.tag-1;
        //代理
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectSegment:)]) {
            [self.delegate selectSegment:button.tag-1];
        }
    }
}

-(void)setSelectNum:(NSInteger)selectNum{
    if (self.selectBtnTag!=selectNum) {
        
        for (UIButton *btn in self.btnSource) {
            btn.selected=NO;
        }
        
        [self.btnSource[selectNum] setSelected:YES];
        
        [UIView animateWithDuration:0.2 animations:^{
            
            _bottomLine.frame=CGRectMake((selectNum)*_btnW, self.bounds.size.height-2, _btnW, 2);
        }];
        self.selectBtnTag=selectNum;
    }
}
@end
