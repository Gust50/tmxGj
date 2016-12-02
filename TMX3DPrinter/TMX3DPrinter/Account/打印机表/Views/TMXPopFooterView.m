//
//  TMXPopFooterView.m
//  TMX3DPrinter
//
//  Created by arom on 16/8/26.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXPopFooterView.h"

@implementation TMXPopFooterView

- (UIButton *)headLabel{
    
    if (!_headLabel) {
        _headLabel = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_headLabel setTitleColor:RGBColor(52, 52, 52) forState:(UIControlStateNormal)];
        _headLabel.titleLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _headLabel.titleLabel.textAlignment = NSTextAlignmentCenter;
        _headLabel.backgroundColor =  RGBColor(228, 233, 234);
    
        [_headLabel setTitle:NSLocalizedString(@"Return", nil) forState:(UIControlStateNormal)];
        [_headLabel addTarget:self action:@selector(remove) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _headLabel;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    [self addSubview:self.headLabel];
    
    [self updateConstraints];
}

- (void)remove{

    if (self.removeblock) {
        self.removeblock();
    }
}

- (void)updateConstraints{
    
    [super updateConstraints];
    
    WS(weakSelf);
    [_headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.mas_right).with.offset(0);
        make.top.equalTo(weakSelf.mas_top).with.offset(0);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
    }];
}


@end
