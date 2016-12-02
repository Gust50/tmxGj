//
//  PrinterListTableViewCell.h
//  TMX3DPrinter
//
//  Created by arom on 16/8/25.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMXPrinterListListModel;
@class TMXPrinterListShareListModel;
@interface PrinterListTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView * printerImage;       ///<图标
@property (nonatomic,strong)UILabel * nameLable;              ///<名字
@property (nonatomic,strong)UILabel * stateLabel;             ///<状态
@property (nonatomic,strong)UIImageView * selectImage;        ///<选择图示

@property (nonatomic, strong)TMXPrinterListListModel *printerListModel;     ///<打印机列表
@property (nonatomic, strong)TMXPrinterListShareListModel *sharePrinterList;///<共享打印机列表

@end
