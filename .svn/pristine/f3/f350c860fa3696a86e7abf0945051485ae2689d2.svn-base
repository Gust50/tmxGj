//
//  TMXPrinterTaskBar.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXPrinterTaskBar.h"

@interface TMXPrinterTaskBar ()
@property (nonatomic, strong)UIButton *cancel;
@property (nonatomic, strong)UIButton *restore;

@end
@implementation TMXPrinterTaskBar

-(UIButton *)cancel
{
    if (!_cancel) {
        _cancel = [[UIButton alloc] init];
        _cancel.tag = 1;
        _cancel.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
        _cancel.backgroundColor = [UIColor whiteColor];
        [_cancel setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
        [_cancel setTitleColor:RGBColor(97, 97, 97) forState:UIControlStateNormal];
        [_cancel addTarget:self action:@selector(selectStatus:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancel;
}

-(UIButton *)restore
{
    if (!_restore) {
        _restore = [[UIButton alloc] init];
        _restore.tag = 2;
        _restore.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
        _restore.backgroundColor = systemColor;
        [_restore setTitle:NSLocalizedString(@"Restore", nil) forState:UIControlStateNormal];
        [_restore setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_restore addTarget:self action:@selector(selectStatus:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _restore;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.cancel];
    [self addSubview:self.restore];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    WS(weakSelf);

    [_cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.left.equalTo(weakSelf.mas_left);
        make.width.mas_equalTo(@(SCREENWIDTH/2));
    }];
    
    [_restore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.right.equalTo(weakSelf.mas_right);
        make.width.mas_equalTo(@(SCREENWIDTH/2));
    }];
}

- (void)selectStatus:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickTask:)]) {
        [self.delegate clickTask:sender.tag];
    }
}

@end
