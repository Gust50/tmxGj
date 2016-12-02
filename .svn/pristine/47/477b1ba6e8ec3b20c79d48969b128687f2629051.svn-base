//
//  TMXPrinterTaskCell.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXPrinterTaskCell.h"
#import "TMXPrinterTaskListModel.h"

@interface TMXPrinterTaskCell ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *suppliesLab;
@property (nonatomic, strong)UIImageView *selectTask;

@end
@implementation TMXPrinterTaskCell

-(UIImageView *)icon{
    if (!_icon) {
        _icon=[UIImageView new];
        _icon.image = [UIImage imageNamed:@"LoginIcon"];
    }
    return _icon;
}

-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab=[UILabel new];
        _nameLab.textColor = RGBColor(64, 64, 64);
        _nameLab.font = [UIFont systemFontOfSize:12*AppScale];
    }
    return _nameLab;
}

-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab=[UILabel new];
        _timeLab.textColor = RGBColor(154, 154, 154);
        _timeLab.font = [UIFont systemFontOfSize:10*AppScale];
        
    }
    return _timeLab;
}

-(UILabel *)suppliesLab{
    if (!_suppliesLab) {
        _suppliesLab=[UILabel new];
        _suppliesLab.textColor = RGBColor(154, 154, 154);
        _suppliesLab.font = [UIFont systemFontOfSize:10*AppScale];
        
    }
    return _suppliesLab;
}

-(UIImageView *)selectTask
{
    if (!_selectTask) {
        _selectTask = [[UIImageView alloc] init];
        _selectTask.image = [UIImage imageNamed:@"Restore_normal"];
    }
    return _selectTask;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        _selectTask.image = [UIImage imageNamed:@"Restore_select"];
    }else
    {
        _selectTask.image = [UIImage imageNamed:@"Restore_normal"];
    }
}

-(void)initUI{
    
    [self addSubview:self.icon];
    [self addSubview:self.nameLab];
    [self addSubview:self.timeLab];
    [self addSubview:self.suppliesLab];
    [self addSubview:self.selectTask];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40*AppScale, 40*AppScale));
    }];
    
    [_selectTask mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(15*AppScale, 15*AppScale));
    }];
    
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_icon.mas_right).with.offset(5*AppScale);
        make.top.equalTo(_icon.mas_top);
        make.right.equalTo(_selectTask.mas_left).with.offset(-5*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_icon.mas_right).with.offset(5*AppScale);
        make.bottom.equalTo(_icon.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(100*AppScale, 20*AppScale));
    }];
    
    [_suppliesLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_timeLab.mas_right).with.offset(5*AppScale);
        make.right.equalTo(_selectTask.mas_left).with.offset(-5*AppScale);
        make.bottom.equalTo(_icon.mas_bottom);
        make.height.mas_equalTo(@(20*AppScale));
    }];
}

#pragma mark - setter getter
-(void)setSelectTag:(NSInteger)selectTag
{
    _selectTag = selectTag;
    if (selectTag == 3) {
        self.selectTask.hidden = NO;
    }else
    {
        self.selectTask.hidden = YES;
    }
}

-(void)setListModel:(TMXPrinterTaskListListModel *)listModel
{
    _listModel = listModel;
    [_icon sd_setImageWithURL:[NSURL URLWithString:listModel.filePathImg] placeholderImage:nil];
    _nameLab.text = listModel.fileName;
    if (listModel.printTime.length) {
        NSString *consu = NSLocalizedString(@"Consuming", nil);
         _timeLab.text = [NSString stringWithFormat:@"%@%@", consu,listModel.printTime];
        [NSString labelString:_timeLab font:[UIFont systemFontOfSize:10*AppScale] range:NSMakeRange(consu.length, _timeLab.text.length-consu.length) color:systemColor];
    }else
    {
         _timeLab.text = NSLocalizedString(@"Consuming", nil);
    }
    
    if (listModel.filamentUsed.length) {
        NSString *consu = NSLocalizedString(@"Consumables", nil);
        _suppliesLab.text = [NSString stringWithFormat:@"%@%@", consu,listModel.filamentUsed];
        [NSString labelString:_suppliesLab font:[UIFont systemFontOfSize:10*AppScale] range:NSMakeRange(consu.length, _suppliesLab.text.length-consu.length) color:systemColor];
    }else
    {
        _suppliesLab.text = NSLocalizedString(@"Consumables", nil);
    }
    
}

@end
