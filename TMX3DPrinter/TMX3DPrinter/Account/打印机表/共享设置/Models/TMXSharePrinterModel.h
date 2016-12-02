//
//  TMXSharePrinterModel.h
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMXSharePrinterModel : NSObject

@property (nonatomic, copy)NSString *printerName;       ///<打印机名称
@property (nonatomic, copy)NSString *img;               ///<二维码地址
@property (nonatomic, assign)NSInteger count;           ///<还可以共享多少人
@property (nonatomic, copy)NSString *userAvatar;        ///<用户头像
@property (nonatomic, copy)NSString *userName;          ///<用户名

/**
 *  获取二维码信息
 *
 *  @param printerId    打印机id
 *  @param completion 返回
 */
-(void)FetchTMXSharePrinterModel:(NSDictionary *)params
                     callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXCreateQRCodeModel : NSObject

/**
 *  二维码生成
 *
 *  @param printerId    打印机id
 *  @param minutes      失效时间（分钟）
 *  @param maxShare     打印机共享最大数
 *  @param completion 返回
 */
-(void)FetchTMXCreateQRCodeModel:(NSDictionary *)params
                        callBack:(void(^)(BOOL isSuccess,id result))completion;

@end