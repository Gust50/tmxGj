//
//  TMXScanQRCodeModel.h
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/23.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMXScanQRCodeModel : NSObject

@property (nonatomic, copy)NSString *name;
@property (nonatomic, assign)NSInteger printerId;
@property (nonatomic, copy)NSString *code;

/**
 *  扫描二维码
 *
 *  @param printerId     打印机id
 *  @param code          code
 *  @param completion 返回
 */
-(void)FetchTMXScanQRCodeModel:(NSDictionary *)params
                     callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXAddPrinterToPrinterListModel : NSObject

/**
 *  共享打印机用户添加
 *
 *  @param printerId     打印机id
 *  @param code          code
 *  @param userId        用户id
 *  @param completion 返回
 */
-(void)FetchTMXAddPrinterToPrinterListModel:(NSDictionary *)params
                      callBack:(void(^)(BOOL isSuccess,id result))completion;

@end