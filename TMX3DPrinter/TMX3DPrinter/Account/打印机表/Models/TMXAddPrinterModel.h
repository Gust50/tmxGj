//
//  TMXAddPrinterModel.h
//  TMX3DPrinter
//
//  Created by kobe on 16/7/5.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMXAddPrinterModel : NSObject
@property (nonatomic, copy) NSString *printerId;     ///<打印机ID
/**
 *  绑定打印机
 *
 *  @param params     参数
 *  @param completion 返回
 */
-(void)FetchTMXAddPrinterData:(NSDictionary *)params
                    callBack:(void(^)(BOOL isSuccess,id result))completion;

@end



@interface TMXAddPrinterStatusModel : NSObject
@property (nonatomic, copy) NSString *printerStatus;   ///<查询打印机状态
/**
 *  查询打印机状态
 *
 *  @param params     参数
 *  @param completion 返回
 */
-(void)FetchTMXPrinterStatusData:(NSDictionary *)params
                        callBack:(void(^)(BOOL isSuccess,id result))completion;

@end



@interface TMXAddPrinterApikeyModel : NSObject
@property (nonatomic, copy) NSString *printerKey;           ///<apikey
@property (nonatomic, copy) NSString *rc;                   ///<打印机是否连接WIFI成功 rc=0成功1失败
@property (nonatomic, copy) NSString *ssid;                 ///<打印机SSID
/**
 *  获取打印机APIKEY
 *
 *  @param params     参数
 *  @param completion 返回
 */
-(void)FetchTMXPrinterApikeyData:(NSDictionary *)params
                        callBack:(void(^)(BOOL isSuccess,id result))completion;
@end

