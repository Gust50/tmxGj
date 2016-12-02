//
//  TMXLanguageHeaderview.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/10/27.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXLanguageHeaderview.h"

@interface TMXLanguageHeaderview ()
@property (nonatomic, strong)UILabel *headTitle;
@end
@implementation TMXLanguageHeaderview

-(UILabel *)headTitle
{
    if (!_headTitle) {
        _headTitle = [UILabel new];
        _headTitle.text = NSLocalizedStringFromTable(@"Select_language", nil, nil);
        _headTitle.font = [UIFont systemFontOfSize:13*AppScale];
        _headTitle.textColor = [UIColor whiteColor];
        _headTitle.textAlignment = NSTextAlignmentCenter;
        _headTitle.backgroundColor = systemColor;
    }
    return _headTitle;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = systemColor;
        [self initUI];
    }
    return self;
}


- (void)initUI
{
    [self addSubview:self.headTitle];
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    WS(weakSelf);
    [_headTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
    }];
}


-(void)setIsUpdate:(BOOL)isUpdate{
    _isUpdate=isUpdate;
    _headTitle.text = NSLocalizedStringFromTable(@"Select_language", nil, nil);
    
}
@end
