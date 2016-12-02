//
//  PrinterHeadView.m
//  TMX3DPrinter
//
//  Created by arom on 16/8/26.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "PrinterHeadView.h"

@implementation PrinterHeadView

#pragma mark -- 懒加载
- (UILabel *)headLabel{

    if (!_headLabel) {
        _headLabel = [[UILabel alloc] init];
        _headLabel.textColor = RGBColor(153, 153, 153);
        _headLabel.font = [UIFont systemFontOfSize:12*AppScale];
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

- (void)updateConstraints{

    [super updateConstraints];
    
    WS(weakSelf);
    [_headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*AppScale));
    }];
}

@end
