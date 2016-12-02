//
//  TMXPrinterTaskStatusView.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXPrinterTaskStatusView.h"
#import "KBtopImgBottomTextBtn.h"

@interface TMXPrinterTaskStatusView ()<KBtopImgBottomTextBtnDelegate>

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIButton *cancel;

@end
@implementation TMXPrinterTaskStatusView

#pragma mark <lazyLoad>
-(UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

-(UIButton *)cancel
{
    if (!_cancel) {
        _cancel = [[UIButton alloc] init];
        _cancel.backgroundColor = backGroundColor;
        _cancel.titleLabel.font = [UIFont systemFontOfSize:12*AppScale];
        [_cancel setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
        [_cancel setTitleColor:RGBColor(91, 91, 91) forState:UIControlStateNormal];
        [_cancel addTarget:self action:@selector(cancelSelectTask) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancel;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor = RGBAColor(0, 0, 0, 0.6);
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
        [self addGestureRecognizer:gesture];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.backView];
    [self addSubview:self.cancel];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.height.mas_equalTo(@(80*AppScale));
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-40*AppScale);
    }];
    
    [_cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.top.equalTo(_backView.mas_bottom);
    }];
}

-(void)layoutBtn{
    
    for (int i=0; i<self.statusName.count; i++) {
        KBtopImgBottomTextBtn *btn=[[KBtopImgBottomTextBtn alloc]initWithFrame:CGRectMake(i*SCREENWIDTH/self.statusName.count, 10, SCREENWIDTH/self.statusName.count, 60*AppScale)];
        btn.isHomeIcon = NO;
        btn.nameContent = self.statusName[i];
        btn.iconUrl = self.statusIcon[i];
        btn.printerTaskID = self.printerTaskID;
        btn.textFont=[UIFont systemFontOfSize:11*AppScale];
        btn.textColor=[UIColor blackColor];
        btn.delegate = self;
        [self.backView addSubview:btn];
        
    }
}

#pragma mark - KBtopImgBottomTextBtnDelegate
-(void)clickBtnName:(NSString *)name printerTaskID:(NSInteger)printerTaskID
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickTMXPrinterTaskStatusView:printerTaskID:)]) {
        [self.delegate clickTMXPrinterTaskStatusView:name printerTaskID:self.printerTaskID];
    }
}

#pragma mark - setter getter
-(void)setCount:(NSInteger)count
{
    _count = count;
    [self layoutBtn];
}

-(void)setStatusIcon:(NSArray *)statusIcon
{
    _statusIcon = statusIcon;
}

-(void)setStatusName:(NSArray *)statusName
{
    _statusName = statusName;
}

-(void)setPrinterTaskID:(NSInteger)printerTaskID
{
    _printerTaskID = printerTaskID;
}

//取消
- (void)cancelSelectTask
{
    [self removeFromSuperview];
}

- (void)removeView
{
    [self removeFromSuperview];
}

@end
