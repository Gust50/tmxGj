//
//  TMXPersonInfoIconCell.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/6/8.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXPersonInfoIconCell.h"

@interface TMXPersonInfoIconCell ()
@property (strong, nonatomic) IBOutlet UILabel *iconLabel;


@end

@implementation TMXPersonInfoIconCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.icon.layer.cornerRadius = 25.0;
    self.icon.layer.masksToBounds = YES;
    self.iconLabel.text = NSLocalizedString(@"Icon", nil);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
