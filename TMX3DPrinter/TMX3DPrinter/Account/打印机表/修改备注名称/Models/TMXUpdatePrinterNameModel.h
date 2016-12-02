//
//  TMXUpdatePrinterNameModel.h
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/5.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMXUpdatePrinterNameModel : NSObject

/**
 *  修改打印机名称
 *
 *  @param id              打印机id
 *  @param printerName     打印机名称
 *  @param printerType     打印机类型 printerType：0代表绑定打印机，1代表共享打印机
 *  @param completion 返回
 */
-(void)FetchTMXUpdatePrinterNameModel:(NSDictionary *)params
                         callBack:(void(^)(BOOL isSuccess,id result))completion;

@end
