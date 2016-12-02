//
//  TMXHomeDisplayModelCell.m
//  TMX3DPrinter
//
//  Created by kobe on 16/8/25.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXHomeDisplayModelCell.h"
#import "TMXHomeSearchModel.h"
#import "TMXCollectModel.h"
#import "TMXLikeModel.h"
#import "TMXProfileModel.h"
#import "TMXHomeModel.h"
#import "TMXHomeClassifyListModel.h"
#import "TMXUploadByUserModel.h"

@interface TMXHomeDisplayModelCell ()
@property (nonatomic, strong) UIImageView *modelImg;
@property (nonatomic, strong) UILabel *modelNameLab;
@property (nonatomic, strong) UILabel *userNameLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UIView * bottomLine;
@property (nonatomic, strong) UILabel *collectLab;
@property (nonatomic, strong) UILabel *remarkLab;

@property (nonatomic, assign) CGFloat collectWidth;
@property (nonatomic, assign) CGFloat remarkWidth;
@end


@implementation TMXHomeDisplayModelCell

#pragma mark <lazyLoad>
-(UIImageView *)modelImg{
    if (!_modelImg) {
        _modelImg=[UIImageView new];
    }
    return _modelImg;
}

-(UILabel *)modelNameLab{
    if (!_modelNameLab) {
        _modelNameLab=[UILabel new];
        _modelNameLab.textAlignment = NSTextAlignmentCenter;
        _modelNameLab.font = [UIFont systemFontOfSize:13*AppScale];
    }
    return _modelNameLab;
}

-(UILabel *)userNameLab{
    if (!_userNameLab) {
        _userNameLab=[UILabel new];
        _userNameLab.font = [UIFont systemFontOfSize:11*AppScale];
        _userNameLab.textColor = RGBColor(102, 102, 102);
    }
    return _userNameLab;
}

-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab=[UILabel new];
        _timeLab.textAlignment = NSTextAlignmentRight;
        _timeLab.font = [UIFont systemFontOfSize:10*AppScale];
        _timeLab.textColor = RGBColor(144, 144, 144);
    }
    return _timeLab;
}

-(UIView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine=[UIView new];
        _bottomLine.backgroundColor = RGBColor(235, 235, 235);
    }
    return _bottomLine;
}

-(UILabel *)collectLab{
    if (!_collectLab) {
        _collectLab=[UILabel new];
        _collectLab.font = [UIFont systemFontOfSize:10*AppScale];
        _collectLab.textColor = [UIColor redColor];
    }
    return _collectLab;
}

-(UILabel *)remarkLab{
    if (!_remarkLab) {
        _remarkLab=[UILabel new];
        _remarkLab.font = [UIFont systemFontOfSize:10*AppScale];
        _remarkLab.textColor = [UIColor redColor];
    }
    return _remarkLab;
}

#pragma mark <init>

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}


-(void)initUI{
    
    [self addSubview:self.modelImg];
    [self addSubview:self.modelNameLab];
    [self addSubview:self.userNameLab];
    [self addSubview:self.timeLab];
    [self addSubview:self.bottomLine];
    [self addSubview:self.collectLab];
    [self addSubview:self.remarkLab];
    [self updateConstraints];
}


-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_modelImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(_modelNameLab.mas_top).offset(-5*AppScale);
    }];
    
    [_modelNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(20*AppScale));
        make.bottom.equalTo(_userNameLab.mas_top).offset(-5*AppScale);
    }];
    
    [_userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.height.mas_equalTo(@(18*AppScale));
        make.right.equalTo(_timeLab.mas_left).with.offset(-2);
        make.bottom.equalTo(_bottomLine.mas_top);
    }];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(18*AppScale));
        make.left.equalTo(_userNameLab.mas_right);
        make.bottom.equalTo(_bottomLine.mas_top);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(1));
        make.bottom.equalTo(_collectLab.mas_top);
    }];
    
    [_collectLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.height.mas_equalTo(@(18*AppScale));
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
    [_collectLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(_collectWidth));
    }];
    
    [_remarkLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_collectLab.mas_right).with.offset(10*AppScale);
        make.height.mas_equalTo(@(18*AppScale));
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
    [_remarkLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(_remarkWidth));
    }];
}

#pragma mark - setter getter
-(void)setIsProfile:(BOOL)isProfile
{
    _isProfile = isProfile;
}

- (void)setSearchListModel:(TMXHomeSearchListModel *)searchListModel
{
    _searchListModel = searchListModel;
    [_modelImg sd_setImageWithURL:[NSURL URLWithString:searchListModel.image] placeholderImage:nil];
    _modelNameLab.text = searchListModel.name;
    _userNameLab.text = searchListModel.ownerName;
    
    NSString *collectL = NSLocalizedString(@"Collect", nil);
    _collectLab.text = [NSString stringWithFormat:@"%ld %@", searchListModel.favoriteCnt, collectL];
    [NSString labelString:_collectLab font:[UIFont systemFontOfSize:10*AppScale] range:NSMakeRange(_collectLab.text.length-collectL.length, collectL.length) color:RGBColor(81, 81, 81)];
    CGSize collectSize = [NSString sizeWithStr:_collectLab.text font:[UIFont systemFontOfSize:12*AppScale] width:120];
    _collectWidth = collectSize.width;
    NSString *remarkL = NSLocalizedString(@"Comment", nil);
    _remarkLab.text = [NSString stringWithFormat:@"%ld %@", searchListModel.modelCommentCount, remarkL];
    [NSString labelString:_remarkLab font:[UIFont systemFontOfSize:10*AppScale] range:NSMakeRange(_remarkLab.text.length-remarkL.length, remarkL.length) color:RGBColor(81, 81, 81)];
    CGSize remarkSize = [NSString sizeWithStr:_remarkLab.text font:[UIFont systemFontOfSize:12*AppScale] width:120];
    _remarkWidth = remarkSize.width;
    
    if (searchListModel.updatedDate.length) {
//        NSDate *date = [[KBDateFormatter shareInstance]dateFromTimeInterval:([searchListModel.updatedDate doubleValue]/1000.0)];
////        NSString *timeString = [[KBDateFormatter shareInstance] stringFromDate:date];
//        _timeLab.text = [NSDate caculatorTime:date];
        NSDate *date = [[KBDateFormatter shareInstance]dateFromTimeInterval:([searchListModel.updatedDate doubleValue]/1000.0)];
        NSString *timeString = [[KBDateFormatter shareInstance] stringFromDate:date];
        _timeLab.text = timeString;
    }else
    {
        _timeLab.text = @"";
    }
}

-(void)setCollectListModel:(TMXCollectListModel *)collectListModel
{
    _collectListModel = collectListModel;
    [_modelImg sd_setImageWithURL:[NSURL URLWithString:collectListModel.image] placeholderImage:nil];
    _modelNameLab.text = collectListModel.name;
    _userNameLab.text = collectListModel.ownerName;
    
    NSString *collectL = NSLocalizedString(@"DetailCollect", nil);
    _collectLab.text = [NSString stringWithFormat:@"%ld %@", collectListModel.favoriteCnt, collectL];
    [NSString labelString:_collectLab font:[UIFont systemFontOfSize:10*AppScale] range:NSMakeRange(_collectLab.text.length-collectL.length, collectL.length) color:RGBColor(81, 81, 81)];
    CGSize collectSize = [NSString sizeWithStr:_collectLab.text font:[UIFont systemFontOfSize:12*AppScale] width:120];
    _collectWidth = collectSize.width;
    NSString *remarkL = NSLocalizedString(@"Comment", nil);
    _remarkLab.text = [NSString stringWithFormat:@"%ld %@", collectListModel.modelCommentCount, remarkL];
    [NSString labelString:_remarkLab font:[UIFont systemFontOfSize:10*AppScale] range:NSMakeRange(_remarkLab.text.length-remarkL.length, remarkL.length) color:RGBColor(81, 81, 81)];
    CGSize remarkSize = [NSString sizeWithStr:_remarkLab.text font:[UIFont systemFontOfSize:12*AppScale] width:120];
    _remarkWidth = remarkSize.width;
    
    if (collectListModel.updatedDate.length) {
//        NSDate *date = [[KBDateFormatter shareInstance]dateFromTimeInterval:([collectListModel.updatedDate doubleValue]/1000.0)];
////        NSString *timeString = [[KBDateFormatter shareInstance] stringFromDate:date];
//        _timeLab.text = [NSDate caculatorTime:date];
        NSDate *date = [[KBDateFormatter shareInstance]dateFromTimeInterval:([collectListModel.updatedDate doubleValue]/1000.0)];
        NSString *timeString = [[KBDateFormatter shareInstance] stringFromDate:date];
        _timeLab.text = timeString;
    }else
    {
        _timeLab.text = @"";
    }
}

-(void)setLikeListModel:(TMXLikeListModel *)likeListModel
{
    _likeListModel = likeListModel;
    [_modelImg sd_setImageWithURL:[NSURL URLWithString:likeListModel.image] placeholderImage:nil];
    _modelNameLab.text = likeListModel.name;
    _userNameLab.text = likeListModel.ownerName;
    
    NSString *collectL = NSLocalizedString(@"DetailCollect", nil);
    _collectLab.text = [NSString stringWithFormat:@"%ld %@", likeListModel.favoriteCnt, collectL];
    [NSString labelString:_collectLab font:[UIFont systemFontOfSize:10*AppScale] range:NSMakeRange(_collectLab.text.length-collectL.length, collectL.length) color:RGBColor(81, 81, 81)];
    CGSize collectSize = [NSString sizeWithStr:_collectLab.text font:[UIFont systemFontOfSize:12*AppScale] width:120];
    _collectWidth = collectSize.width;
    NSString *remarkL = NSLocalizedString(@"Comment", nil);
    _remarkLab.text = [NSString stringWithFormat:@"%ld %@", likeListModel.modelCommentCount, remarkL];
    [NSString labelString:_remarkLab font:[UIFont systemFontOfSize:10*AppScale] range:NSMakeRange(_remarkLab.text.length-remarkL.length, remarkL.length) color:RGBColor(81, 81, 81)];
    CGSize remarkSize = [NSString sizeWithStr:_remarkLab.text font:[UIFont systemFontOfSize:12*AppScale] width:120];
    _remarkWidth = remarkSize.width;
    
    if (likeListModel.updatedDate.length) {
//        NSDate *date = [[KBDateFormatter shareInstance]dateFromTimeInterval:([likeListModel.updatedDate doubleValue]/1000.0)];
////        NSString *timeString = [[KBDateFormatter shareInstance] stringFromDate:date];
//        _timeLab.text = [NSDate caculatorTime:date];
        NSDate *date = [[KBDateFormatter shareInstance]dateFromTimeInterval:([likeListModel.updatedDate doubleValue]/1000.0)];
        NSString *timeString = [[KBDateFormatter shareInstance] stringFromDate:date];
        _timeLab.text = timeString;
    }else
    {
        _timeLab.text = @"";
    }
}

- (void)setProfileListModel:(TMXProfileListModel *)profileListModel
{
    _profileListModel = profileListModel;
    [_modelImg sd_setImageWithURL:[NSURL URLWithString:profileListModel.image] placeholderImage:nil];
    _modelNameLab.text = profileListModel.name;
    NSString *statu = NSLocalizedStringFromTable(@"LinkStatu", nil, nil);
    if (profileListModel.isShare) {
        NSString *openS = NSLocalizedString(@"State_Open", nil);
        _userNameLab.text = openS;
        [NSString labelString:_userNameLab font:[UIFont systemFontOfSize:11*AppScale] range:NSMakeRange(statu.length, openS.length-statu.length) color:systemColor];
    }else
    {
        _userNameLab.text = NSLocalizedString(@"State_NoOpen", nil);
    }
    NSString *collectL = NSLocalizedString(@"DetailCollect", nil);
    _collectLab.text = [NSString stringWithFormat:@"%ld %@", profileListModel.favoriteCnt, collectL];
    [NSString labelString:_collectLab font:[UIFont systemFontOfSize:10*AppScale] range:NSMakeRange(_collectLab.text.length-collectL.length, collectL.length) color:RGBColor(81, 81, 81)];
    CGSize collectSize = [NSString sizeWithStr:_collectLab.text font:[UIFont systemFontOfSize:12*AppScale] width:120];
    _collectWidth = collectSize.width;
    NSString *remarkL = NSLocalizedString(@"Comment", nil);
    _remarkLab.text = [NSString stringWithFormat:@"%ld %@", profileListModel.modelCommentCount, remarkL];
    [NSString labelString:_remarkLab font:[UIFont systemFontOfSize:10*AppScale] range:NSMakeRange(_remarkLab.text.length-remarkL.length, remarkL.length) color:RGBColor(81, 81, 81)];
    CGSize remarkSize = [NSString sizeWithStr:_remarkLab.text font:[UIFont systemFontOfSize:12*AppScale] width:120];
    _remarkWidth = remarkSize.width;
    
    if (profileListModel.updatedDate.length) {
//        NSDate *date = [[KBDateFormatter shareInstance]dateFromTimeInterval:([profileListModel.updatedDate doubleValue]/1000.0)];
//        _timeLab.text = [NSDate caculatorTime:date];
        NSDate *date = [[KBDateFormatter shareInstance]dateFromTimeInterval:([profileListModel.updatedDate doubleValue]/1000.0)];
        NSString *timeString = [[KBDateFormatter shareInstance] stringFromDate:date];
        _timeLab.text = timeString;
    }else
    {
        _timeLab.text = @"";
    }
}

-(void)setCategryListModel:(TMXHomeCategoryModelListListModel *)categryListModel
{
    _categryListModel = categryListModel;
    [_modelImg sd_setImageWithURL:[NSURL URLWithString:categryListModel.image] placeholderImage:nil];
    _modelNameLab.text = categryListModel.name;
    _userNameLab.text = categryListModel.ownerName;
    NSString *collectL = NSLocalizedString(@"DetailCollect", nil);
    _collectLab.text = [NSString stringWithFormat:@"%ld %@", categryListModel.favoriteCnt, collectL];
    [NSString labelString:_collectLab font:[UIFont systemFontOfSize:10*AppScale] range:NSMakeRange(_collectLab.text.length-collectL.length, collectL.length) color:RGBColor(81, 81, 81)];
    CGSize collectSize = [NSString sizeWithStr:_collectLab.text font:[UIFont systemFontOfSize:12*AppScale] width:120];
    _collectWidth = collectSize.width;
    NSString *remarkL = NSLocalizedString(@"Comment", nil);
    _remarkLab.text = [NSString stringWithFormat:@"%ld %@", categryListModel.modelCommentCount, remarkL];
    [NSString labelString:_remarkLab font:[UIFont systemFontOfSize:10*AppScale] range:NSMakeRange(_remarkLab.text.length-remarkL.length, remarkL.length) color:RGBColor(81, 81, 81)];
    CGSize remarkSize = [NSString sizeWithStr:_remarkLab.text font:[UIFont systemFontOfSize:12*AppScale] width:120];
    _remarkWidth = remarkSize.width;
    
    if (categryListModel.updatedDate.length) {
//        NSDate *date = [[KBDateFormatter shareInstance]dateFromTimeInterval:([categryListModel.updatedDate doubleValue]/1000.0)];
////        NSString *timeString = [[KBDateFormatter shareInstance] stringFromDate:date];
//        
//        _timeLab.text = [NSDate caculatorTime:date];
        NSDate *date = [[KBDateFormatter shareInstance]dateFromTimeInterval:([categryListModel.updatedDate doubleValue]/1000.0)];
        NSString *timeString = [[KBDateFormatter shareInstance] stringFromDate:date];
        _timeLab.text = timeString;
    }else
    {
        _timeLab.text = @"";
    }
}

-(void)setClasifyListModel:(TMXHomeClassifyListListModel *)clasifyListModel
{
    _clasifyListModel = clasifyListModel;
    [_modelImg sd_setImageWithURL:[NSURL URLWithString:clasifyListModel.image] placeholderImage:nil];
    _modelNameLab.text = clasifyListModel.name;
    _userNameLab.text = clasifyListModel.ownerName;
    NSString *collectL = NSLocalizedString(@"DetailCollect", nil);
    _collectLab.text = [NSString stringWithFormat:@"%ld %@", clasifyListModel.favoriteCnt, collectL];
    [NSString labelString:_collectLab font:[UIFont systemFontOfSize:10*AppScale] range:NSMakeRange(_collectLab.text.length-collectL.length, collectL.length) color:RGBColor(81, 81, 81)];
    CGSize collectSize = [NSString sizeWithStr:_collectLab.text font:[UIFont systemFontOfSize:12*AppScale] width:120];
    _collectWidth = collectSize.width;
    NSString *remarkL = NSLocalizedString(@"Comment", nil);
    _remarkLab.text = [NSString stringWithFormat:@"%ld %@", clasifyListModel.modelCommentCount, remarkL];
    [NSString labelString:_remarkLab font:[UIFont systemFontOfSize:10*AppScale] range:NSMakeRange(_remarkLab.text.length-remarkL.length, remarkL.length) color:RGBColor(81, 81, 81)];
    CGSize remarkSize = [NSString sizeWithStr:_remarkLab.text font:[UIFont systemFontOfSize:12*AppScale] width:120];
    _remarkWidth = remarkSize.width;
    
    if (clasifyListModel.updatedDate.length) {
//        NSDate *date = [[KBDateFormatter shareInstance]dateFromTimeInterval:([clasifyListModel.updatedDate doubleValue]/1000.0)];
//        KBDateFormatter *kbformatter=[KBDateFormatter shareInstance];
//        kbformatter.dateFormatterString=@"MM/dd/yyyy HH:mm";
//        NSDate *data =[kbformatter dateFromTimeInterval:[clasifyListModel.updatedDate doubleValue]];
//        NSString *str=[kbformatter stringFromDate:data];
//        _timeLab.text = str;
        NSDate *date = [[KBDateFormatter shareInstance]dateFromTimeInterval:([clasifyListModel.updatedDate doubleValue]/1000.0)];
        NSString *timeString = [[KBDateFormatter shareInstance] stringFromDate:date];
        _timeLab.text = timeString;
    }else
    {
        _timeLab.text = @"";
    }
}

-(void)setUploadByUserListModel:(TMXUploadByUserListModel *)UploadByUserListModel
{
    _UploadByUserListModel = UploadByUserListModel;
    [_modelImg sd_setImageWithURL:[NSURL URLWithString:UploadByUserListModel.image] placeholderImage:nil];
    _modelNameLab.text = UploadByUserListModel.name;
    _userNameLab.text = UploadByUserListModel.ownerName;
    NSString *collectL = NSLocalizedString(@"DetailCollect", nil);
    _collectLab.text = [NSString stringWithFormat:@"%ld %@", UploadByUserListModel.favoriteCnt, collectL];
    [NSString labelString:_collectLab font:[UIFont systemFontOfSize:10*AppScale] range:NSMakeRange(_collectLab.text.length-collectL.length, collectL.length) color:RGBColor(81, 81, 81)];
    CGSize collectSize = [NSString sizeWithStr:_collectLab.text font:[UIFont systemFontOfSize:12*AppScale] width:120];
    _collectWidth = collectSize.width;
    NSString *remarkL = NSLocalizedString(@"Comment", nil);
    _remarkLab.text = [NSString stringWithFormat:@"%ld %@", UploadByUserListModel.modelCommentCount, remarkL];
    [NSString labelString:_remarkLab font:[UIFont systemFontOfSize:10*AppScale] range:NSMakeRange(_remarkLab.text.length-remarkL.length, remarkL.length) color:RGBColor(81, 81, 81)];
    CGSize remarkSize = [NSString sizeWithStr:_remarkLab.text font:[UIFont systemFontOfSize:12*AppScale] width:120];
    _remarkWidth = remarkSize.width;
    
    if (UploadByUserListModel.updatedDate.length) {
//        NSDate *date = [[KBDateFormatter shareInstance]dateFromTimeInterval:([UploadByUserListModel.updatedDate doubleValue]/1000.0)];
//        
//        _timeLab.text = [NSDate caculatorTime:date];
        NSDate *date = [[KBDateFormatter shareInstance]dateFromTimeInterval:([UploadByUserListModel.updatedDate doubleValue]/1000.0)];
        NSString *timeString = [[KBDateFormatter shareInstance] stringFromDate:date];
        _timeLab.text = timeString;
    }else
    {
        _timeLab.text = @"";
    }
}

@end
