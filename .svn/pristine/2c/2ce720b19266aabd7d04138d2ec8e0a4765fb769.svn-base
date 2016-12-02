//
//  TMXNullView.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/26.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXNullView.h"
#import "KBLabel.h"

@interface TMXNullView ()

@property (strong, nonatomic) KBLabel *buyLabel;

@end
@implementation TMXNullView

- (KBLabel *)buyLabel
{
    if (!_buyLabel) {
        _buyLabel = [[KBLabel alloc] init];
        _buyLabel.text = NSLocalizedString(@"BuyNow", nil);
        _buyLabel.textColor = RGBColor(166, 166, 166);
        _buyLabel.font = [UIFont systemFontOfSize:13*AppScale];
        _buyLabel.textAlignment = NSTextAlignmentCenter;
        _buyLabel.type = bottomLine;
        _buyLabel.labelFont = [UIFont systemFontOfSize:13*AppScale];
        _buyLabel.lineColor = RGBColor(166, 166, 166);
        
        _buyLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setBuyTMX)];
        [_buyLabel addGestureRecognizer:gesture];
    }
    return _buyLabel;
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
    [self addSubview:self.buyLabel];
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_buyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.height.mas_equalTo(@(30*AppScale));
    }];

}

//去购买TMX
- (void)setBuyTMX
{
    if (self.block) {
        self.block();
    }
}


@end
