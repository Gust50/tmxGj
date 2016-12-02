//
//  TMXWaitPrinterModel.h
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/9.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMXWaitPrinterModel : NSObject

@property (nonatomic, assign)NSInteger printQueueCount;     ///<等待任务个数
@property (nonatomic, strong)NSArray *printQueueList;       ///<打印列表

/**
 *  共享用户查看打印任务列表
 *
 *  @param printerId  打印机id
 *  @param completion 返回
 */
-(void)FetchTMXWaitPrinterModel:(NSDictionary *)params
                       callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXWaitPrinterListModel : NSObject

@property (nonatomic, assign)NSInteger waitPrinterID;       ///<任务id
@property (nonatomic, assign)BOOL belongToUser;            ///<此任务是否属于当前用户（true/false）
@property (nonatomic, copy)NSString *fileName;              ///<名称
@property (nonatomic, copy)NSString *filePathImg;           ///<图片
@property (nonatomic, copy)NSString *printTime;             ///<耗时
@property (nonatomic, copy)NSString *filamentUsed;          ///<耗材
@property (nonatomic, assign)NSInteger status;              ///<打印任务状态： 0待打印 1打印中 2打印完成

@end

@interface TMXWaitPrinterCancelModel : NSObject

/**
 *  取消文件打印列表
 *
 *  @param id         打印任务id
 *  @param completion 返回
 */
-(void)FetchTMXWaitPrinterCancelModel:(NSDictionary *)params
                       callBack:(void(^)(BOOL isSuccess,id result))completion;

@end