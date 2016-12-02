//
//  TMXUnbindModel.h
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/5.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMXUnbindModel : NSObject

/**
 *  绑定打印机解绑
 *
 *  @param printerId       打印机id
 *  @param ShareUserId     继承人id
 *  @param type            0代表管理者解除，1所有者解除
 *  @param completion 返回
 */
-(void)FetchTMXUnbindModel:(NSDictionary *)params
                             callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXUnbindInfoModel : NSObject

@property (nonatomic, assign)NSInteger shareUsersCount;     ///<共享用户数
@property (nonatomic, copy)NSString *productName;           ///<打印机名称
@property (nonatomic, copy)NSString *bindDate;              ///<绑定时间
@property (nonatomic, strong)NSArray *shareUsers;

/**
 *  解除打印机页面信息
 *
 *  @param printerId       打印机id
 *  @param completion 返回
 */
-(void)FetchTMXUnbindInfoModel:(NSDictionary *)params
                  callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXUnbindInfoListModel : NSObject

@property (nonatomic, assign)NSInteger printerShareId;      ///<共享id
@property (nonatomic, copy)NSString *userName;              ///<用户名
@property (nonatomic, copy)NSString *shareDate;             ///<共享时间
@property (nonatomic, copy)NSString *avatar;                ///<用户头像

@end