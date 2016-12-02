//
//  TMXPopMenuSelectTableViewCell.h
//  TMX3DPrinter
//
//  Created by arom on 16/8/29.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TMXPopMenuSelectTableViewCellDelegate <NSObject>

- (void)clickTMXPopMenuSelectTableViewCellDelegate:(BOOL)isDefaut;

@end
@interface TMXPopMenuSelectTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel * describLabel;
@property (nonatomic,strong)UISwitch * selectSwitch;

@property (nonatomic, assign)BOOL isDefault;        ///<传入是否默认

@property (nonatomic, weak)id<TMXPopMenuSelectTableViewCellDelegate>delegate;

@end
