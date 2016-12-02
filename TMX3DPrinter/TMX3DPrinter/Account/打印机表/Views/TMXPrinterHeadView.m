//
//  TMXPrinterHeadView.m
//  TMX3DPrinter
//
//  Created by arom on 16/8/26.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXPrinterHeadView.h"
#import "TMXShareUserListModel.h"


@implementation TMXPrinterHeadView

#pragma mark -- 懒加载
- (UILabel *)headLabel{
    
    if (!_headLabel) {
        _headLabel = [[UILabel alloc] init];
        _headLabel.textColor = RGBColor(153, 153, 153);
        _headLabel.font = [UIFont systemFontOfSize:12*AppScale];
    }
    return _headLabel;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    [self addSubview:self.headLabel];
    
    [self updateConstraints];
}

- (void)updateConstraints{
    
    [super updateConstraints];
    
    WS(weakSelf);
    [_headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*AppScale));
    }];
}

#pragma mark - setter getter
-(void)setListModel:(TMXShareUserListModel *)listModel
{
    _listModel = listModel;
    NSString *com = NSLocalizedString(@"ComHave", nil);
    NSString *share = NSLocalizedString(@"PlaceUserShare", nil);
    NSString *placeUser = NSLocalizedString(@"PlaceUser", nil);
    _headLabel.text = [NSString stringWithFormat:@"%@ %ld %@，%ld %@", com,listModel.shareUsersCount,share,listModel.remaining,placeUser];
    
    NSArray *number = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
     NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:_headLabel.text];
    for (int i = 0; i < _headLabel.text.length; i ++) {
        NSString *a = [_headLabel.text substringWithRange:NSMakeRange(i, 1)];
        if ([number containsObject:a]) {
            [attributeString setAttributes:@{NSForegroundColorAttributeName:systemColor,NSFontAttributeName:[UIFont systemFontOfSize:12*AppScale]} range:NSMakeRange(i, 1)];
        }
    }
    _headLabel.attributedText = attributeString;
}

@end
