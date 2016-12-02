//
//  TMXLoginInfoModel.h
//  TMX3DPrinter
//
//  Created by kobe on 16/6/17.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMXLoginInfoModel : NSObject

@property(nonatomic,copy)NSString *timestamp;                     ///<时间戳
@property(nonatomic,copy)NSString *token;                         ///<token
@property(nonatomic,copy)NSString *userId;                        ///<用户ID
@property(nonatomic,copy)NSString *username;                      ///<用户名

@end
