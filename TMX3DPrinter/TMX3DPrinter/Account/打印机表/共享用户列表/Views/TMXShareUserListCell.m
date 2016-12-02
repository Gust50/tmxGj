//
//  TMXShareUserListCell.m
//  TMX3DPrinter
//
//  Created by arom on 16/8/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXShareUserListCell.h"
#import "TMXShareUserListModel.h"

@implementation TMXShareUserListCell

#pragma mark -- 懒加载
- (UIImageView *)iconView{

    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image = [UIImage imageNamed:@"LoginIcon"];
        _iconView.layer.masksToBounds = YES;
        _iconView.layer.cornerRadius = 15*AppScale;
        
    }
    return _iconView;
}

- (UILabel *)nameLabel{

    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = RGBColor(51, 51, 51);
        _nameLabel.font = [UIFont systemFontOfSize:13*AppScale];
    }
    return _nameLabel;
}

- (UILabel *)timeLabel{

    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = RGBColor(102, 102, 102);
        _timeLabel.font = [UIFont systemFontOfSize:13*AppScale];
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.iconView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.timeLabel];
    
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    WS(weakSelf);
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.width.mas_equalTo(@(30*AppScale));
                             
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_iconView.mas_right).with.offset(5*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*AppScale));
        make.right.equalTo(_timeLabel.mas_left).with.offset(-10*AppScale);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*AppScale));
        make.width.equalTo(@(100*AppScale));
    }];
}

#pragma mark - setter getter
-(void)setShareListModel:(TMXShareUserListListModel *)shareListModel
{
    _shareListModel = shareListModel;
    _nameLabel.text = shareListModel.userName;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:shareListModel.avatar] placeholderImage:nil];
    
    NSDate *date = [[KBDateFormatter shareInstance]dateFromTimeInterval:([shareListModel.shareDate doubleValue]/1000.0)];
    NSString *timeString = [[KBDateFormatter shareInstance] stringFromDate:date];
    _timeLabel.text = timeString;
}

@end
