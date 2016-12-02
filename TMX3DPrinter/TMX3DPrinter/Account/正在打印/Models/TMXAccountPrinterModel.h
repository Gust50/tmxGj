//
//  TMXAccountPrinterModel.h
//  TMX3DPrinter
//
//  Created by kobe on 16/6/17.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMXAccountPrinterModel : NSObject
@property (nonatomic, strong) NSArray *printerList;

/**
 *  打印机列表
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)FetchTMXPrinterListData:(NSDictionary *)params
                      callBack:(void(^)(BOOL isSuccess,id result))completion;
@end


@interface TMXAccountPrinterListModel : NSObject
@property (nonatomic, copy) NSString *printerID;   ///<打印机id
@property (nonatomic, assign) BOOL isDefault;    ///<是否默认打印机
@property (nonatomic, copy) NSString *status;    ///<连接状态
@end



typedef NS_ENUM(NSInteger, GoToVCType){
    Printing=1,           ///<正在打印
    PrintTask=2,          ///<打印机任务列表
    PriterTask_Share=3    ///<共享
};

@interface TMXAccountPrintModel : NSObject
@property (nonatomic, copy) NSString *printerId;      ///<打印编号
@property (nonatomic, assign) GoToVCType gotoPage;
/**
 *  打印模型
 *
 *  @param params     参数
 *  @param completion 返回
 */
-(void)FetchTMXPrintModelData:(NSDictionary *)params
                      callBack:(void(^)(BOOL isSuccess,id result))completion;
/**
 *  通过文件名打印模型
 *
 *  @param params     参数
 *  @param completion 返回
 */
-(void)FetchTMXPrintModelFileNameData:(NSDictionary *)params
                     callBack:(void(^)(BOOL isSuccess,id result))completion;
@end