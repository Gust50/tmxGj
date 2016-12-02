//
//  TMXLanguageFooterview.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/10/27.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXLanguageFooterview.h"

@interface TMXLanguageFooterview ()
@property (nonatomic, strong)UILabel *footerTitle;
@end
@implementation TMXLanguageFooterview

-(UILabel *)footerTitle
{
    if (!_footerTitle) {
        _footerTitle = [UILabel new];
        _footerTitle.text = NSLocalizedStringFromTable(@"Return", nil, nil);
        _footerTitle.font = [UIFont systemFontOfSize:13*AppScale];
        _footerTitle.backgroundColor = backGroundColor;
        _footerTitle.textAlignment = NSTextAlignmentCenter;
        _footerTitle.userInteractionEnabled = YES;
        UITapGestureRecognizer *gester = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
        [_footerTitle addGestureRecognizer:gester];
    }
    return _footerTitle;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = backGroundColor;
        [self initUI];
        
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.footerTitle];
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    WS(weakSelf);
    [_footerTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
    }];
}

//返回
- (void)back
{
    if (self.footerviewBlock) {
        self.footerviewBlock();
    }
}


-(void)setIsUpdate:(BOOL)isUpdate{
    _isUpdate=isUpdate;
    _footerTitle.text = NSLocalizedStringFromTable(@"Return", nil, nil);
}

@end
