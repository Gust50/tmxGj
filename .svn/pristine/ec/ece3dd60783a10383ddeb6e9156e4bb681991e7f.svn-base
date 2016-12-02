//
//  TMXHomeNavigationView.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/8/29.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXHomeNavigationView.h"

@interface TMXHomeNavigationView ()<UITextFieldDelegate>
@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)KBTextField *searchModel;
@end
@implementation TMXHomeNavigationView

-(UIImageView *)icon{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        _icon.layer.masksToBounds = YES;
        _icon.image = [UIImage imageNamed:@"SearchIcon"];
        _icon.userInteractionEnabled=YES;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(search:)];
        [_icon addGestureRecognizer:gesture];
    }
    return _icon;
}
-(KBTextField *)searchModel{
    if (!_searchModel) {
        _searchModel=[[KBTextField alloc]init];
        _searchModel.borderStyle = UITextBorderStyleRoundedRect;
        _searchModel.textAlignment = NSTextAlignmentLeft;
        _searchModel.textColor = [UIColor whiteColor];
        _searchModel.layer.cornerRadius = 15;
        _searchModel.layer.masksToBounds = YES;
        _searchModel.font = [UIFont systemFontOfSize:10*AppScale];
        _searchModel.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 0)];
        _searchModel.leftViewMode = UITextFieldViewModeAlways;
        NSString *_input = NSLocalizedString(@"Input_search", nil);
        _searchModel.placeholder = _input;
        _searchModel.delegate = self;
    }
    return _searchModel;
}

#pragma mark <init>
-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}


#pragma mark <add UI>
-(void)initUI{
    [self addSubview:self.searchModel];
    [self.searchModel addSubview:self.icon];
    
    [self updateConstraints];
}

#pragma mark <otherResponse>
- (void)search:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectModel:)]) {
        [self.delegate selectModel:self];
    }
}

-(BOOL)textFieldShouldBeginEditing:(KBTextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(KBTextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectModel:)]) {
        [self.delegate selectModel:self];
    }
}

#pragma mark <update>
-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    
    [_searchModel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(weakSelf.mas_top);
        make.size.mas_equalTo(CGSizeMake(weakSelf.frame.size.width,weakSelf.frame.size.height));
    }];
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_searchModel.mas_left).with.offset(10*AppScale);
        make.centerY.equalTo(_searchModel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(10*AppScale, 10*AppScale));
    }];
    
}

@end
