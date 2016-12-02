//
//  TMXSexCell.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/6/24.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXSexCell.h"

@implementation TMXSexCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectImage.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        self.selectImage.hidden = NO;
    }else
    {
        self.selectImage.hidden = YES;
    }
}

@end
