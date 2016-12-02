//
//  TMXPrinteringHeadView.h
//  TMX3DPrinter
//
//  Created by wutaobo on 16/6/12.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMXAccountPrintTaskModel,TMXAccountUpdatePrintTaskModel;

@protocol TMXPrinteringHeadViewDelegate <NSObject>
-(void)pausePrinterState;   ///<暂停
-(void)resumePrinterState;  ///<恢复
-(void)cancelPrinterState;  ///<取消
-(void)huansiPrinter;       ///<换丝
@end

@interface TMXPrinteringHeadView : UITableViewCell
@property (nonatomic, strong) TMXAccountPrintTaskModel *tMXAccountPrintTaskModel;                ///<打印机数据
@property (nonatomic, strong) TMXAccountUpdatePrintTaskModel *tMXAccountUpdatePrintTaskModel;    ///<更新数据
@property (nonatomic, weak) id<TMXPrinteringHeadViewDelegate>delegate;
@property (nonatomic, assign) BOOL isHasTask;    ///<是否有任务
@property (nonatomic, assign) BOOL isPausedTask;     ///<任务是否暂停
@end
