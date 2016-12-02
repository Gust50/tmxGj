//
//  TMXShareSettingFooterView.m
//  TMX3DPrinter
//
//  Created by arom on 16/8/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXShareSettingFooterView.h"

@interface TMXShareSettingFooterView ()

@property (nonatomic,strong)UIButton * bottomBtn;           //底部按钮

@end
@implementation TMXShareSettingFooterView

#pragma mark -- 懒加载
- (UIButton *)bottomBtn{

    if (!_bottomBtn) {
        _bottomBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_bottomBtn setTitle:NSLocalizedString(@"Create_QrCode", nil) forState:(UIControlStateNormal)];
        _bottomBtn.backgroundColor = systemColor;
        _bottomBtn.layer.masksToBounds = YES;
        _bottomBtn.layer.cornerRadius = 8*AppScale;
        [_bottomBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_bottomBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.bottomBtn];
    
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    
    WS(weakSelf);
    [_bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.height.equalTo(@(40*AppScale));
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
}

- (void)share
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(sharePrinter)]) {
        [self.delegate sharePrinter];
    }
}

@end
