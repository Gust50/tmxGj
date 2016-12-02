//
//  TMXPopMenuView.h
//  TMX3DPrinter
//
//  Created by arom on 16/8/26.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol popMenuCellSelectedDelegate <NSObject>

- (void)goShareSettingVC:(NSInteger)printerId isCreateQR:(BOOL)isCreateQR;  //跳分享设置
- (void)goShareUserListVC:(NSInteger)printerId;                             //共享用户列表
- (void)goPrinterTaskListVC:(NSInteger)printerId;                           //打印任务列表
- (void)goUpdatePrinterName:(NSInteger)printerId name:(NSString *)name printerType:(BOOL)printerType;     //备注名称
- (void)goResetPrinterWifiVC:(NSInteger)printerId status:(NSString *)status;                          //重新设置打印机wifi
- (void)unBindPrinter:(NSInteger)printerId isSecondView:(BOOL)isSecondView;//解除打印机
- (void)goAdvancedSetting:(NSInteger)printerId status:(NSString *)status;                             //高级设置

- (void)clickSelectDefault:(NSInteger)printerId printerType:(BOOL)printerType isDefault:(BOOL)isDefault; ///<是否选择默认

@end

@class TMXPrinterListListModel;
@class TMXPrinterListShareListModel;
@interface TMXPopMenuView : UIView

@property (nonatomic,assign)BOOL isSecondSection;
@property (nonatomic,weak) id <popMenuCellSelectedDelegate>delegate;

@property (nonatomic, strong)TMXPrinterListListModel *bindModel;            ///<绑定打印机
@property (nonatomic, strong)TMXPrinterListShareListModel *shareListModel;  ///<分享打印机

@end
