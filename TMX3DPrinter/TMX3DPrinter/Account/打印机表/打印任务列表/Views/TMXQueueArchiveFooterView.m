//
//  TMXQueueArchiveFooterView.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/12.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXQueueArchiveFooterView.h"

@interface TMXQueueArchiveFooterView ()
@property (nonatomic, strong)UILabel *leftLine;
@property (nonatomic, strong)UILabel *rightLine;
@property (nonatomic, strong)UILabel *middleLabel;
@end
@implementation TMXQueueArchiveFooterView

-(UILabel *)leftLine
{
    if (!_leftLine) {
        _leftLine = [[UILabel alloc] init];
        _leftLine.backgroundColor = RGBColor(186, 189, 190);
    }
    return _leftLine;
}

-(UILabel *)rightLine
{
    if (!_rightLine) {
        _rightLine = [[UILabel alloc] init];
        _rightLine.backgroundColor = RGBColor(186, 189, 190);
    }
    return _rightLine;
}

-(UILabel *)middleLabel
{
    if (!_middleLabel) {
        _middleLabel = [UILabel new];
        _middleLabel.font = [UIFont systemFontOfSize:11*AppScale];
        _middleLabel.text = NSLocalizedString(@"Record", nil);
        _middleLabel.textAlignment = NSTextAlignmentCenter;
        _middleLabel.textColor = RGBColor(154, 154, 154);
    }
    return _middleLabel;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = backGroundColor;
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.leftLine];
    [self addSubview:self.rightLine];
    [self addSubview:self.middleLabel];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(70*AppScale, 1));
    }];
    
    [_rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(70*AppScale, 1));
    }];
    
    [_middleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftLine.mas_right).offset(10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(_rightLine.mas_left).offset(-10*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
}

@end
