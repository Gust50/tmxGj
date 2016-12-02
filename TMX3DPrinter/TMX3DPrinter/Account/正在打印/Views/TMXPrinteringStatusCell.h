//
//  TMXPrinteringStatusCell.h
//  TMX3DPrinter
//
//  Created by kobe on 16/9/18.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TMXAccountPrintTaskModel,TMXAccountUpdatePrintTaskModel;
@protocol TMXPrinteringStatusCellDelegate <NSObject>

@optional
-(void)printerSwitchWire;
-(void)printerPause;
-(void)printerResume;
-(void)printerCancel;
@end

@interface TMXPrinteringStatusCell : UITableViewCell

@property (nonatomic, strong) TMXAccountPrintTaskModel *tMXAccountPrintTaskModel;                ///<打印机数据
@property (nonatomic, strong) TMXAccountUpdatePrintTaskModel *tMXAccountUpdatePrintTaskModel;    ///<更新数据
@property (nonatomic, assign) BOOL isHasTask;    ///<是否有任务
@property (nonatomic, assign) BOOL isPausedTask;     ///<任务是否暂停
@property (nonatomic, assign) BOOL isAll;
@property (nonatomic, weak) id<TMXPrinteringStatusCellDelegate>delegate;

@end
