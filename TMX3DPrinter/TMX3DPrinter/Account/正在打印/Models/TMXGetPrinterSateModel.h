//
//  TMXGetPrinterSateModel.h
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/13.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMXGetPrinterSateModel : NSObject

@property (nonatomic, assign)BOOL energySavingState;        ///<情感灯光节能状态
@property (nonatomic, assign)BOOL inductionDoorState;       ///<安全门自动感应状态
@property (nonatomic, copy)NSString *currentVersion;         ///<当前打印机固件版本号

/**
 *  获取情感灯光节能，安全门自动感应状态
 *
 *  @param userId                用户id
 *  @param printerId             打印机id
 *  @param completion 返回
 */
-(void)FetchTMXGetPrinterSateModel:(NSDictionary *)params
                                  callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXUpEnergySavingStateModel : NSObject

/**
 *  获取情感灯光节能状态
 *
 *  @param userId                用户id
 *  @param printerId             打印机id
 *  @param completion 返回
 */
-(void)FetchTMXUpEnergySavingStateModel:(NSDictionary *)params
                          callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXUpInductionDoorStateModel : NSObject

/**
 *  获取安全门自动感应状态
 *
 *  @param userId                用户id
 *  @param printerId             打印机id
 *  @param completion 返回
 */
-(void)FetchTMXUpInductionDoorStateModel:(NSDictionary *)params
                               callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXCheckVersionModel : NSObject

@property (nonatomic, assign)BOOL result;       ///<为最新返回true、否则返回false

/**
 *  检测当前版本是否为最新版本
 *
 *  @param currentVersion 当前打印机固件版本号
 *  @param completion 返回
 */
-(void)FetchTMXCheckVersionModel:(NSDictionary *)params
                                callBack:(void(^)(BOOL isSuccess,id result))completion;

@end