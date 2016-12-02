//
//  TMXPrinterListTableViewCell.h
//  TMX3DPrinter
//
//  Created by arom on 16/8/26.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMXPrinterListListModel;
@class TMXPrinterListShareListModel;
typedef void(^selectBlock)();

@interface TMXPrinterListTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView * printerImage;       ///<图标
@property (nonatomic,strong)UILabel * nameLable;              ///<名字
@property (nonatomic,strong)UILabel * isDefault;              ///<是否默认
@property (nonatomic,strong)UILabel * WIFIStateLabel;         ///<wifi状态
//@property (nonatomic,strong)UILabel * WIFILabel;              ///<WIFI名字
@property (nonatomic,strong)UIButton * selectButton;          ///<选择图示


@property (nonatomic,copy)selectBlock selectblock;            ///<block

@property (nonatomic, strong)TMXPrinterListListModel *printerListModel;     ///<打印机列表
@property (nonatomic, strong)TMXPrinterListShareListModel *sharePrinterList;///<共享打印机列表
@end
