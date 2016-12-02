//
//  TMXShareSettingCell.h
//  TMX3DPrinter
//
//  Created by arom on 16/8/29.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMXShareSettingCell : UITableViewCell

@property (nonatomic,strong)UILabel * describLabel;       ///<描述
@property (nonatomic,strong)UITextField * KtextField;     ///<输入内容
@property (nonatomic,strong)UILabel * countLabel;         ///<单位

@end
