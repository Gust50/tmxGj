//
//  TMXPrinterListModel.h
//  TMX3DPrinter
//
//  Created by 吴桃波 on 16/9/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMXPrinterListModel : NSObject

@property (nonatomic, strong)NSArray *printerList;           ///<已绑定打印机列表
@property (nonatomic, strong)NSArray *sharePrinterList;      ///<已共享打印机列表

/**
 *  打印机列表
 *
 *  @param userId     用户id
 *  @param completion 返回
 */
-(void)FetchTMXPrinterListModel:(NSDictionary *)params
                     callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXPrinterListListModel : NSObject

@property (nonatomic, assign)NSInteger printerListID;       ///<打印机id
@property (nonatomic, copy)NSString *printerName;           ///<名称
@property (nonatomic, assign)BOOL isDefault;               ///<是否默认打印机
@property (nonatomic, copy)NSString *status;                ///<连接状态
@property (nonatomic, assign)BOOL printerType;             ///<1代表绑定打印机，0代表共享打印机
@property (nonatomic, assign)BOOL isQrCode;                ///<是否已生成二维码
@property (nonatomic, assign)NSInteger userCount;           ///<共享用户数

@end

@interface TMXPrinterListShareListModel : NSObject

@property (nonatomic, assign)NSInteger sharePrinterListID;  ///<共享打印机id
@property (nonatomic, assign)NSInteger printerId;           ///<被共享的打印机的id
@property (nonatomic, copy)NSString *printerName;           ///<名称
@property (nonatomic, assign)BOOL isDefault;               ///<是否默认打印机
@property (nonatomic, copy)NSString *status;                ///<连接状态
@property (nonatomic, assign)BOOL printerType;             ///<1代表绑定打印机，0代表共享打印机

@end

@interface TMXPrinterUpdateIsDefaultModel : NSObject

@property (nonatomic, assign)BOOL IsDefault;                ///<该打印机默认状态

/**
 *  设置默认打印机
 *
 *  @param userId                用户id
 *  @param printerId             打印机id
 *  @param completion 返回
 */
-(void)FetchTMXPrinterUpdateIsDefaultModel:(NSDictionary *)params
                       callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXUnBindPrinterShareModel : NSObject

/**
 *  共享打印机解绑
 *
 *  @param userId                用户id
 *  @param printerShareId        打印机id
 *  @param completion 返回
 */
-(void)FetchTMXUnBindPrinterShareModel:(NSDictionary *)params
                                  callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXPrinterInfoModel : NSObject

@property (nonatomic, copy)NSString *printerName;   ///<备注名称
@property (nonatomic, assign)NSInteger userCount;   ///<共享用户数

/**
 *  打印机信息
 *
 *  @param printerId  打印机id
 *  @param completion 返回
 */
-(void)FetchTMXHigherSetupModel:(NSDictionary *)params
                       callBack:(void(^)(BOOL isSuccess,id result))completion;

@end