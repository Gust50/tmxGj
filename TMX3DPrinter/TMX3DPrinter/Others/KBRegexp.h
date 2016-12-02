//
//  KBRegexp.h
//  ClshUser
//
//  Created by kobe on 16/6/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBRegexp : NSObject

+(BOOL)checkPhoneNumInput:(NSString *)phoneNum;      //!<手机号码验证
+(BOOL)validateEmail:(NSString *)email;              //!<邮箱验证
+(BOOL)isPureInt:(NSString*)string;                  //!<数字验证
+(BOOL)isInteger:(NSString *)inviteCode;             //!<邀请码验证
+(BOOL)validateUserName:(NSString *)name;            //!<验证用户名
+(BOOL)validateCardNumber:(NSString *)cardNum;       //!<验证银行卡号
+(BOOL)validateChinese:(NSString *)string;           //!<验证是否是中文
+(BOOL)validateUserIdCard:(NSString *)userIdCard;    //!<验证身份证
+(BOOL)validateMoney:(NSString *)money;              //!<提现金额必须大于0
+(BOOL)validatepostCode:(NSString *)postCode;        ///<邮编验证
+(BOOL)isBlankString:(NSString *)string;
+(BOOL)isContainerChineseString:(NSString *)string;
@end
