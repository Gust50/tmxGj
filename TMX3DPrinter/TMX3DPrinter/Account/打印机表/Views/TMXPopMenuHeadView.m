//
//  TMXPopMenuHeadView.m
//  TMX3DPrinter
//
//  Created by arom on 16/8/26.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXPopMenuHeadView.h"

@implementation TMXPopMenuHeadView

- (UILabel *)headLabel{

    if (!_headLabel) {
        _headLabel = [[UILabel alloc] init];
        _headLabel.textColor = [UIColor whiteColor];
        _headLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _headLabel.textAlignment = NSTextAlignmentCenter;
        _headLabel.backgroundColor = RGBColor(237, 109, 0);
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
       
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.mas_right).with.offset(0);
        make.top.equalTo(weakSelf.mas_top).with.offset(0);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
    }];
}


@end
