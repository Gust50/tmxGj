//
//  TMXAccountPrintTaskModel.h
//  TMX3DPrinter
//
//  Created by kobe on 16/6/17.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMXAccountPrintTaskModel : NSObject

@property (nonatomic, copy) NSString *printerId;        ///<打印机id
@property (nonatomic, copy) NSString *modelName;       ///<打印中的模型名
@property (nonatomic, copy) NSString *modelImage;    ///<打印中的模型预览图
@property (nonatomic, copy) NSString *status;      ///<打印机打印状态
@property (nonatomic, copy) NSString *totalSeconds;     ///<打印所需总时间（单位:秒）
@property (nonatomic, copy) NSString *leftSeconds;       ///<剩余时间
@property (nonatomic, copy) NSString *usedSeconds;      ///<已用时间
//@property (nonatomic, copy) NSString *currentSpeed;    ///<当前打印速度
//@property (nonatomic, copy) NSString *expectedSpeed;     ///<设置的打印速度
@property (nonatomic, copy) NSString *currentTemperature;     ///<当前温度
@property (nonatomic, copy) NSString *expectedTemperature;    ///<设置的温度
@property (nonatomic, copy) NSString *completion;     ///<打印机进度
@property (nonatomic, strong) NSArray *fileList;       ///<打印机打印历史文件
@property (nonatomic, copy) NSString *refreshFrequency;  ///<打印机更新时间
@property (nonatomic, copy)NSString *msgContent;       ///<打印信息

@property (nonatomic, assign) BOOL hasTask;     ///<是否有打印任务
@property (nonatomic, assign) NSInteger modelId;    ///<打印模型的ID
@property (nonatomic, assign) BOOL isPaused;     ///<是否暂停

/**
 *  打印机任务列表
 *
 *  @param params     printerId
 *  @param completion 返回数据
 */
-(void)FetchTMXAccountPrintTaskData:(NSDictionary *)params
                  callBack:(void(^)(BOOL isSuccess,id result))completion;
@end


@interface TMXAccountPrintTaskListModel : NSObject

@property (nonatomic, copy) NSString *fileId;       ///<文件id
@property (nonatomic, copy) NSString *fileName;     ///<文件名
@property (nonatomic, copy) NSString *fileImage;      ///<文件预览图
@property (nonatomic, copy) NSString *latestPrintedDate;   ///<最近打印时间
@property (nonatomic, copy) NSString *status;    ///<打印状态
@property (nonatomic, copy) NSString *resource;   ///<模型文件源地址
@property (nonatomic, copy) NSString *fileRealName;

@end


@interface TMXAccountUpdatePrintTaskModel :NSObject

@property (nonatomic, copy) NSString *printerId;        ///<打印机id
@property (nonatomic, copy) NSString *status;      ///<打印机打印状态
@property (nonatomic, copy) NSString *totalSeconds;     ///<打印所需总时间（单位:秒）
@property (nonatomic, copy) NSString *leftSeconds;       ///<剩余时间
@property (nonatomic, copy) NSString *usedSeconds;      ///<已用时间
//@property (nonatomic, copy) NSString *currentSpeed;    ///<当前打印速度
//@property (nonatomic, copy) NSString *expectedSpeed;     ///<设置的打印速度
@property (nonatomic, copy) NSString *currentTemperature;     ///<当前温度
@property (nonatomic, copy) NSString *expectedTemperature;    ///<设置的温度
@property (nonatomic, copy) NSString *completion;       ///<打印完成进度
@property (nonatomic, copy)NSString *msgContent;       ///<打印信息

@property (nonatomic, assign) BOOL hasTask;     ///<是否有打印任务
@property (nonatomic, copy) NSString *modelImage; ///<打印机模型的图片
@property (nonatomic, copy) NSString *modelName;  ///<打印模型的名
@property (nonatomic, assign) BOOL isPaused;    ///<是否

/**
 *  打印机任务列表进度
 *
 *  @param params     printerId
 *  @param completion 返回数据
 */
-(void)FetchTMXAccountUpdatePrintTaskData:(NSDictionary *)params
                           callBack:(void(^)(BOOL isSuccess,id result))completion;
@end

@interface TMXAccountPrintTaskDelectFileModel : NSObject

/**
 *  删除打印文件
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)FetchTMXAccountPrintDelectFileData:(NSDictionary *)params
                           callBack:(void(^)(BOOL isSuccess,id result))completion;
@end
