//
//  TMXPrinterTaskListModel.h
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/5.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMXPrinterTaskListModel : NSObject

@property (nonatomic, assign)NSInteger totalPage;
@property (nonatomic, assign)NSInteger pageNumber;
@property (nonatomic, strong)NSArray *printQueueList; ///<打印列表

/**
 *  打印任务列表
 *
 *  @param status     0;//待打印  1;//打印中 2;//已打印 3;//已取消 4;//已存档
 *  @param printerId  打印机id
 *  @param pageNumber
 *  @param pageSize
 *  @param completion 返回
 */
-(void)FetchTMXPrinterTaskListModel:(NSDictionary *)params
                             callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXPrinterTaskListListModel : NSObject

@property (nonatomic, assign)NSInteger taskId;          
@property (nonatomic, copy)NSString *fileName;          ///<名称
@property (nonatomic, copy)NSString *filePathImg;       ///<图片
@property (nonatomic, copy)NSString *printTime;         ///<耗时
@property (nonatomic, copy)NSString *filamentUsed;      ///<耗材
@property (nonatomic, assign)NSInteger status;          ///<打印任务状态： 0待打印 1打印中 2打印完成

@end

@interface TMXCancelPrinterTaskModel : NSObject

/**
 *  停止打印任务（正在打印中的任务）
 *
 *  @param id         打印任务id
 *  @param completion 返回
 */
-(void)FetchTMXCancelPrinterTaskModel:(NSDictionary *)params
                            callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXStartPrinterTaskModel : NSObject

/**
 *  开始打印任务
 *
 *  @param id         打印任务id
 *  @param completion 返回
 */
-(void)FetchTMXStartPrinterTaskModel:(NSDictionary *)params
                           callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXStopPrinterTaskModel : NSObject

/**
 *  机主取消打印任务
 *
 *  @param id         打印任务id
 *  @param completion 返回
 */
-(void)FetchTMXStopPrinterTaskModel:(NSDictionary *)params
                            callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXPrintQueueArchiveModel : NSObject

/**
 *  打印任务存档
 *
 *  @param id         打印任务id
 *  @param completion 返回
 */
-(void)FetchTMXPrintQueueArchiveModel:(NSDictionary *)params
                            callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXRestoreQueueArchiveModel : NSObject

/**
 *  存档任务批量复原
 *
 *  @param ids        打印任务id数组
 *  @param completion 返回
 */
-(void)FetchTMXRestoreQueueArchiveModel:(NSDictionary *)params
                             callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXUpdatePrinterOrderModel : NSObject

/**
 *  打印任务重新排序
 *
 *  @param id        当前任务id
 *  @param nextId
 *  @param completion 返回
 */
-(void)FetchTMXUpdatePrinterOrderModel:(NSDictionary *)params
                               callBack:(void(^)(BOOL isSuccess,id result))completion;

@end
