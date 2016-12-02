//
//  TMXPrinterTaskFooterView.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXPrinterTaskFooterView.h"

@interface TMXPrinterTaskFooterView ()

@property (nonatomic, strong)UILabel *describe;
@property (nonatomic, strong)UIButton *cancelTask;

@end
@implementation TMXPrinterTaskFooterView

-(UILabel *)describe
{
    if (!_describe) {
        _describe = [[UILabel alloc] init];
        _describe.textAlignment = NSTextAlignmentCenter;
        _describe.text = NSLocalizedString(@"Printing_descrie", nil);
        _describe.font = [UIFont systemFontOfSize:10*AppScale];
        _describe.textColor = RGBColor(160, 161, 161);
    }
    return _describe;
}

-(UIButton *)cancelTask
{
    if (!_cancelTask) {
        _cancelTask = [[UIButton alloc] init];
        _cancelTask.layer.cornerRadius = 5*AppScale;
        _cancelTask.layer.masksToBounds = YES;
        _cancelTask.backgroundColor = RGBColor(234, 97, 1);
        [_cancelTask setTitle:NSLocalizedString(@"Cancel_print", nil) forState:UIControlStateNormal];
        [_cancelTask setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cancelTask.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
        [_cancelTask addTarget:self action:@selector(cancelPrinterTask) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelTask;
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
    [self addSubview:self.describe];
    [self addSubview:self.cancelTask];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(30*AppScale);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(15*AppScale));
    }];
    
    [_cancelTask mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_describe.mas_bottom).offset(5*AppScale);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(35*AppScale));
    }];
}

//取消打印任务
- (void)cancelPrinterTask
{
    if (self.cancelTaskBlock) {
        self.cancelTaskBlock();
    }
}



@end
