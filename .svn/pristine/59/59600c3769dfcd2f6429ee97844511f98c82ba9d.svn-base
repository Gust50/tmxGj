//
//  TMXPtintingSectionHeadView.m
//  TMX3DPrinter
//
//  Created by arom on 16/8/29.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXPtintingSectionHeadView.h"

@interface TMXPtintingSectionHeadView ()

@property (nonatomic,strong)UIButton * historyListBtn;           ///<打印历史
@property (nonatomic,strong)UIButton * refreshBtn;               ///<刷新
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation TMXPtintingSectionHeadView

#pragma mark -- 懒加载
- (UIButton *)historyListBtn{

    if (!_historyListBtn) {
        _historyListBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_historyListBtn setTitle:NSLocalizedString(@"History", nil) forState:(UIControlStateNormal)];
        [_historyListBtn setImage:[UIImage imageNamed:@"PrinterHistoryIcon"] forState:(UIControlStateNormal)];
        _historyListBtn.titleLabel.font = [UIFont systemFontOfSize:12*AppScale];
        [_historyListBtn addTarget:self action:@selector(showPrintHistory) forControlEvents:(UIControlEventTouchUpInside)];
        [_historyListBtn setTitleColor:RGBColor(51, 51, 51) forState:(UIControlStateNormal)];
    }
    return _historyListBtn;
}

- (UIButton *)refreshBtn{

    if (!_refreshBtn) {
        _refreshBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_refreshBtn setTitle:NSLocalizedString(@"Refresh", nil) forState:(UIControlStateNormal)];
        [_refreshBtn setImage:[UIImage imageNamed:@"refresh"] forState:(UIControlStateNormal)];
        _refreshBtn.titleLabel.font = [UIFont systemFontOfSize:12*AppScale];
        [_refreshBtn setTitleColor:RGBColor(51, 51, 51) forState:(UIControlStateNormal)];
        [_refreshBtn addTarget:self action:@selector(refreshUI) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _refreshBtn;
}

- (UIView *)bottomLine{

    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = RGBColor(193,192, 197);
    }
    return _bottomLine;
}

-(UIView *)topLine{
    
    if (!_topLine) {
        _topLine=[UIView new];
        _topLine.backgroundColor=RGBColor(193,192, 197);
    }
    return _topLine;
}


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.historyListBtn];
    [self addSubview:self.refreshBtn];
    [self addSubview:self.bottomLine];
    [self addSubview:self.topLine];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self updateConstraints];
}

//打印历史
- (void)showPrintHistory{

    if (self.delegate && [self.delegate respondsToSelector:@selector(showPrinterHistoryList)]) {
        [self.delegate showPrinterHistoryList];
    }
}

//刷新
- (void)refreshUI{

    if (self.delegate && [self.delegate respondsToSelector:@selector(refreshUI)]) {
        [self.delegate refreshUI];
    }
}

- (void)updateConstraints{

    [super updateConstraints];
    
    WS(weakSelf);
    [_historyListBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.top.equalTo(weakSelf.mas_top).with.offset(0*AppScale);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0*AppScale);
        make.width.equalTo(@((SCREENWIDTH-100*AppScale)/2));
    }];
    
    [_refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.top.equalTo(weakSelf.mas_top).with.offset(0*AppScale);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0*AppScale);
        make.width.equalTo(_historyListBtn.mas_width);
    }];
    
    
    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(0);
        make.left.equalTo(weakSelf.mas_left).with.offset(10);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10);
        make.height.mas_equalTo(@(1));
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-1);
        make.height.equalTo(@(1));
    }];
}

@end
