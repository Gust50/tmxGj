//
//  TMXHeadView.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/19.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXHeadView.h"

@interface TMXHeadView ()

@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)UILabel *content;
@property (nonatomic, strong)UILabel *subContent;

@end
@implementation TMXHeadView

#pragma mark - lazyLoad
-(UIImageView *)icon
{
    if (!_icon) {
        _icon = [UIImageView new];
    }
    return _icon;
}

-(UILabel *)content
{
    if (!_content) {
        _content = [UILabel new];
//        _content.text = @"用户评论";
        _content.font = [UIFont systemFontOfSize:12*AppScale];
    }
    return _content;
}

-(UILabel *)subContent
{
    if (!_subContent) {
        _subContent = [UILabel new];
//        _subContent.text = @"已有287位用户评论";
        _subContent.font = [UIFont systemFontOfSize:10*AppScale];
        _subContent.textAlignment = NSTextAlignmentRight;
        _subContent.textColor = RGBColor(108, 108, 108);
    }
    return _subContent;
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
    [self addSubview:self.icon];
    [self addSubview:self.content];
    [self addSubview:self.subContent];
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    WS(weakSelf);
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(15*AppScale, 15*AppScale));
    }];
    
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_icon.mas_right).offset(5*AppScale);
        make.size.mas_equalTo(CGSizeMake(110*AppScale, 15*AppScale));
    }];
    
    [_subContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_content.mas_right).offset(5*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(15*AppScale));
    }];
}

#pragma mark setter getter
-(void)setUserIcon:(NSString *)userIcon
{
    _userIcon = userIcon;
    _icon.image = [UIImage imageNamed:userIcon];
}

-(void)setDescribe:(NSString *)describe
{
    _describe = describe;
    _content.text = describe;
}

-(void)setLeng:(NSString *)leng
{
    _leng = leng;
}

-(void)setSubDescribe:(NSString *)subDescribe
{
    _subDescribe = subDescribe;
    _subContent.text = subDescribe;
    NSScanner *scanner = [NSScanner scannerWithString:subDescribe];
    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
    
    int number;
    [scanner scanInt:&number];
    NSString *num=[NSString stringWithFormat:@"%d",number];
    [NSString labelString:_subContent font:[UIFont systemFontOfSize:10*AppScale] range:NSMakeRange(self.leng.length, num.length) color:systemColor];
}

@end
