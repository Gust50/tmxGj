//
//  TMXAccountPrinterCommandModel.h
//  TMX3DPrinter
//
//  Created by kobe on 16/6/17.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TMXAccountPrinterCommandModel : NSObject

/**
 *  发送打印机指令
 *
 *  @param params     参数
 *  @param completion 返回
 */
-(void)FetchTMXAccountPrinterCommandData:(NSDictionary *)params
                     callBack:(void(^)(BOOL isSuccess,id result))completion;

/**
 *  打印机解绑
 *
 *  @param params     参数
 *  @param completion 返回
 */
-(void)FetchTMXAccountPrinterUnBindData:(NSDictionary *)params
                                callBack:(void(^)(BOOL isSuccess,id result))completion;

/**
 *  设置默认打印机
 *
 *  @param params     参数
 *  @param completion 返回
 */
-(void)FetchTMXAccountPrinterBindData:(NSDictionary *)params
                               callBack:(void(^)(BOOL isSuccess,id result))completion;
@end
