//
//  TMXShareUserListModel.h
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/5.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMXShareUserListModel : NSObject

@property (nonatomic, assign)NSInteger shareUsersCount;     ///<共享用户人数
@property (nonatomic, assign)NSInteger remaining;           ///<还可共享数
@property (nonatomic, strong)NSArray *shareUsers;           ///<用户列表

/**
 *  打印机共享用户列表
 *
 *  @param printerId     打印机id
 *  @param completion 返回
 */
-(void)FetchTMXShareUserListModel:(NSDictionary *)params
                       callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface TMXShareUserListListModel : NSObject

@property (nonatomic, copy)NSString *userName;              ///<用户名
@property (nonatomic, copy)NSString *shareDate;             ///<共享时间
@property (nonatomic, copy)NSString *printerShareId;        ///<共享id
@property (nonatomic, copy)NSString *avatar;                ///<用户头像

@end

@interface TMXRemoveShareUserModel : NSObject

/**
 *  分享着解绑自己下的共享者
 *
 *  @param userId             用户id
 *  @param printerShareId     打印机id
 *  @param completion 返回
 */
-(void)FetchTMXShareUserListModel:(NSDictionary *)params
                         callBack:(void(^)(BOOL isSuccess,id result))completion;

@end