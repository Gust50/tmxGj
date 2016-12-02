//
//  TMXHomeDetailDescribeCell.m
//  TMX3DPrinter
//
//  Created by kobe on 16/8/26.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXHomeDetailDescribeCell.h"
#import "KBtopImgBottomTextBtn.h"
#import "TMXHomeDetailBrowseView.h"
#import "TMXHomeModelDetailModel.h"

@interface TMXHomeDetailDescribeCell ()
@property (nonatomic, strong) UIImageView *modelImg;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *collectLab;
@property (nonatomic, strong) UILabel *likeLab;
@property (nonatomic, strong) UILabel *remarkLab;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) KBtopImgBottomTextBtn *collectBtn;
@property (nonatomic, strong) TMXHomeDetailBrowseView *browseView;

@property (nonatomic, assign) CGFloat collectWidth;
@property (nonatomic, assign) CGFloat likeWidth;
@property (nonatomic, assign) CGFloat remarkWidth;

@end

@implementation TMXHomeDetailDescribeCell

#pragma mark <lazyLoad>
-(UIImageView *)modelImg{
    if (!_modelImg) {
        _modelImg=[UIImageView new];
//        [_modelImg sd_setImageWithURL:[NSURL URLWithString:@"http://image.tianjimedia.com/uploadImages/2013/256/09W06B852E50.jpg"] placeholderImage:nil];
    }
    return _modelImg;
}

-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab=[UILabel new];
        _nameLab.font = [UIFont systemFontOfSize:13*AppScale];
    }
    return _nameLab;
}

-(UILabel *)collectLab{
    if (!_collectLab) {
        _collectLab=[UILabel new];
        _collectLab.textColor = [UIColor redColor];
        _collectLab.font = [UIFont systemFontOfSize:10*AppScale];

    }
    return _collectLab;
}

-(UILabel *)likeLab{
    if (!_likeLab) {
        _likeLab=[UILabel new];
        _likeLab.textColor = [UIColor redColor];
        _likeLab.font = [UIFont systemFontOfSize:10*AppScale];
    }
    return _likeLab;
}

-(UILabel *)remarkLab{
    if (!_remarkLab) {
        _remarkLab=[UILabel new];
        _remarkLab.textColor = [UIColor redColor];
        _remarkLab.font = [UIFont systemFontOfSize:10*AppScale];
    }
    return _remarkLab;
}

-(UIView *)line{
    if (!_line) {
        _line=[UIView new];
        _line.backgroundColor = RGBColor(231, 231, 231);
    }
    return _line;
}

-(KBtopImgBottomTextBtn *)collectBtn{
    if (!_collectBtn) {
        _collectBtn=[KBtopImgBottomTextBtn new];
        _collectBtn.iconUrl = @"DetailCollect_normal";
        NSString *_collect = NSLocalizedString(@"Collect", nil);
        _collectBtn.nameContent = _collect;
        _collectBtn.isHomeIcon = NO;
        _collectBtn.textFont = [UIFont systemFontOfSize:10*AppScale];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(collectEven)];
        [_collectBtn addGestureRecognizer:gesture];
    }
    return _collectBtn;
}

-(TMXHomeDetailBrowseView *)browseView
{
    if (!_browseView) {
        _browseView = [[TMXHomeDetailBrowseView alloc] init];
        _browseView.layer.cornerRadius = 5*AppScale;
        _browseView.layer.masksToBounds = YES;
    }
    return _browseView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}


-(void)initUI{
    [self addSubview:self.modelImg];
    [self addSubview:self.nameLab];
    [self addSubview:self.collectLab];
    [self addSubview:self.likeLab];
    [self addSubview:self.remarkLab];
    [self addSubview:self.line];
    [self addSubview:self.collectBtn];
    [self addSubview:self.browseView];
    [self updateConstraints];
    
}
-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    
    [_modelImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(_nameLab.mas_top).with.offset(-10*AppScale);
    }];
    
    [_browseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_modelImg.mas_right).offset(-10*AppScale);
        make.bottom.equalTo(_modelImg.mas_bottom).offset(-5*AppScale);
        make.size.mas_equalTo(CGSizeMake(80*AppScale, 30*AppScale));
    }];
    
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.right.equalTo(_line.mas_left);
        make.height.mas_equalTo(@(20*AppScale));
        make.bottom.equalTo(_collectLab.mas_top).with.offset(-5*AppScale);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-10*AppScale);
        make.size.mas_equalTo(CGSizeMake(1, 50*AppScale));
        make.right.equalTo(_collectBtn.mas_left).with.offset(-5*AppScale);
    }];
    
    [_collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-10*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.size.mas_equalTo(CGSizeMake(60*AppScale, 50*AppScale));
    }];
    
    [_collectLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-10*AppScale);
        make.height.mas_equalTo(@(15*AppScale));
    }];
    
    
    [_collectLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(_collectWidth+5*AppScale));
    }];
    
    [_likeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_collectLab.mas_right).with.offset(10*AppScale);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-10*AppScale);
        make.height.mas_equalTo(@(15*AppScale));
    }];
    
    [_likeLab mas_updateConstraints:^(MASConstraintMaker *make) {
         make.width.mas_equalTo(@(_likeWidth+5*AppScale));
    }];
    
    [_remarkLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_likeLab.mas_right).with.offset(10*AppScale);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-10*AppScale);
        make.height.mas_equalTo(@(15*AppScale));
    }];
    
    [_remarkLab mas_updateConstraints:^(MASConstraintMaker *make) {
         make.width.mas_equalTo(@(_remarkWidth+5*AppScale));
    }];
}

- (void)collectEven
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectModel)]) {
        [self.delegate collectModel];
    }
}

#pragma mark - setter getter
-(void)setDetailModel:(TMXHomeModelDetailModel *)detailModel
{
    _detailModel = detailModel;
    
    [_modelImg sd_setImageWithURL:[NSURL URLWithString:detailModel.imageList[0] ] placeholderImage:nil];
    _browseView.browseCount = detailModel.viewCnt;
    _nameLab.text = detailModel.name;
    NSString *collec = NSLocalizedString(@"DetailCollect", nil);
    _collectLab.text = [NSString stringWithFormat:@"%ld %@", detailModel.favoriteCnt, collec];
    [NSString labelString:_collectLab font:[UIFont systemFontOfSize:10*AppScale] range:NSMakeRange(_collectLab.text.length-collec.length, collec.length) color:RGBColor(97, 97, 97)];
    CGSize collectSize = [NSString sizeWithStr:_collectLab.text font:[UIFont systemFontOfSize:12*AppScale] width:120];
    _collectWidth = collectSize.width;
    NSString *lik = NSLocalizedString(@"Like", nil);
    _likeLab.text = [NSString stringWithFormat:@"%ld %@", detailModel.upvoteCnt, lik];
    [NSString labelString:_likeLab font:[UIFont systemFontOfSize:10*AppScale] range:NSMakeRange(_likeLab.text.length-lik.length, lik.length) color:RGBColor(97, 97, 97)];
    CGSize likeSize = [NSString sizeWithStr:_likeLab.text font:[UIFont systemFontOfSize:12*AppScale] width:120];
    _likeWidth = likeSize.width;
    NSString *com = NSLocalizedString(@"Comment", nil);
    _remarkLab.text = [NSString stringWithFormat:@"%ld %@", detailModel.modelCommentCount, com];
    [NSString labelString:_remarkLab font:[UIFont systemFontOfSize:10*AppScale] range:NSMakeRange(_remarkLab.text.length-com.length, com.length) color:RGBColor(97, 97, 97)];
    CGSize remarkSize = [NSString sizeWithStr:_remarkLab.text font:[UIFont systemFontOfSize:12*AppScale] width:120];
    _remarkWidth = remarkSize.width;
    if (detailModel.isFavoriteModel) {
        _collectBtn.iconUrl = @"DetailCollect_select";
        NSString *_cancel = NSLocalizedString(@"Cancel_Collect", nil);
        _collectBtn.nameContent = _cancel;
    }else
    {
        _collectBtn.iconUrl = @"DetailCollect_normal";
        NSString *_collect = NSLocalizedString(@"Collect", nil);
        _collectBtn.nameContent = _collect;
    }
    
    [self updateConstraints];
}

@end
