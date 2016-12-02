//
//  KBRegexp.m
//  ClshUser
//
//  Created by kobe on 16/6/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "KBRegexp.h"

@implementation KBRegexp

+(BOOL)checkPhoneNumInput:(NSString *)phoneNum{
    NSString *regex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[1678]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:phoneNum];
    return isMatch;
}

+ (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    //scanInt是否找到你一个十进制的数字，isAtEnd扫描是否结束
    return[scan scanInt:&val] && [scan isAtEnd];
}

+(BOOL)isInteger:(NSString *)inviteCode{
    NSString *regrex=@"^[0-9]{12}";
    NSPredicate *isInteger = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regrex];
    return [isInteger evaluateWithObject:inviteCode];
}
//验证用户名
+(BOOL)validateUserName:(NSString *)name{
     NSString *userNameRegex=@"^[a-zA-Z0-9+_+\u4e00-\u9fa5]{4,30}+$";
//   NSString *userNameRegex = @"^([\u4E00-\u9FA5]+|[a-zA-Z0-9_]{4,30}+$)";
//    NSString *userNameRegex=@"^[a-zA-Z0-9_u4e00-u9fa5]{4,30}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    return [userNamePredicate evaluateWithObject:name];
}

//银行卡号
+(BOOL)validateCardNumber:(NSString *)cardNum{
    NSString *cardNumberRegex=@"^([0-9]{16}|[0-9]{19})$";
    NSPredicate *cardNumberPredicate=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",cardNumberRegex];
    return [cardNumberPredicate evaluateWithObject:cardNum];
}

//验证是否是中文
+(BOOL)validateChinese:(NSString *)string{
    NSString *chineseRegex=@"^[\u4E00-\u9FA5]*$";
    NSPredicate *chinesePredicate=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",chineseRegex];
    return [chinesePredicate evaluateWithObject:string];
}

//验证身份证
+(BOOL)validateUserIdCard:(NSString *)userIdCard{
    NSString *userIdCardRegex=@"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *userIdCardPredicate=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",userIdCardRegex];
    return [userIdCardPredicate evaluateWithObject:userIdCard];
}

//验证金额
+(BOOL)validateMoney:(NSString *)money{
    NSString *moneyRegex=@"^[1-9][0-9]*$";
    NSPredicate *moneyPredicate=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",moneyRegex];
    return [moneyPredicate evaluateWithObject:money];
}

//邮编
+(BOOL)validatepostCode:(NSString *)postCode{
    NSString *postCodeRegex=@"[1-9]\\d{5}(?!\\d)";
    NSPredicate *codePredicate=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",postCodeRegex];
    return [codePredicate evaluateWithObject:postCode];
}
+(BOOL)isBlankString:(NSString *)string{
    
    if (string==nil || string==NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]<[string length]) {
        return YES;
    }
    return NO;
}

+(BOOL)isContainerChineseString:(NSString *)string{
    
    for (int i=0; i<[string length]; i++) {
        int a=[string characterAtIndex:i];
        //中文的编码范围是：0x4E00~0x9FA5 ||0x9fff
        if (a>0x4e00 && a<0x9fff) {
            return YES;
        }
    }
    return NO;
}
@end
