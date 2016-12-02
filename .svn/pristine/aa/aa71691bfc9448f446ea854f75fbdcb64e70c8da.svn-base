//
//  TMXPrinterTaskStatusView.h
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TMXPrinterTaskStatusViewDelegate <NSObject>

- (void)clickTMXPrinterTaskStatusView:(NSString *)name printerTaskID:(NSInteger)printerTaskID;

@end
@interface TMXPrinterTaskStatusView : UIView

@property (nonatomic, strong)NSArray *statusName;    ///<传入状态名
@property (nonatomic, strong)NSArray *statusIcon;    ///<传入图标
@property (nonatomic, assign)NSInteger count;
@property (nonatomic, assign)NSInteger printerTaskID;///<传入打印任务id

@property (nonatomic, weak)id<TMXPrinterTaskStatusViewDelegate>delegate;

@end
