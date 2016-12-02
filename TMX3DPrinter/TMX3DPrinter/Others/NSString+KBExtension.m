//
//  NSString+KBExtension.m
//  ClshUser
//
//  Created by kobe on 16/6/13.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "NSString+KBExtension.h"
#import <objc/runtime.h>


@implementation NSString (KBExtension)

+(CGSize)sizeWithStr:(NSString *)str
                font:(UIFont *)font
               width:(CGFloat)width
{
    
    NSDictionary *dict=@{NSFontAttributeName:font};
    CGSize size=[str boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                  attributes:dict
                                     context:nil].size;
    return size;

}

+(void)labelString:(UILabel *)lable
              font:(UIFont *)font
             range:(NSRange)range
             color:(UIColor *)color
{
    NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:lable.text];
    [str addAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color} range:range];
    lable.attributedText=str;
}

+(NSNumberFormatter *)numberFormatter{
    //修改金额格式
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    //数字格式化
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.locale=locale;
    formatter.numberStyle = kCFNumberFormatterCurrencyStyle;
    
    return formatter;
}



+(CGSize)caculatorTextSize:(CGFloat)maxWidth
                  textFont:(UIFont *)textFont
               textContent:(NSString *)textContent{
    
    NSDictionary *dict=@{NSFontAttributeName:textFont};
    CGSize size=[textContent boundingRectWithSize:CGSizeMake(SCREENWIDTH-20, MAXFLOAT)
                                            options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                         attributes:dict
                                            context:nil].size;
    return size;
}



+ (NSString *)lr_stringDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}

+(NSString *)encodeString:(NSString *)unencodedString{
    
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *encodedString=(NSString*)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    return encodedString;
}

+(NSString *)decodeString:(NSString *)encodedString{
    
    NSString *decodedString=(__bridge_transfer NSString*)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                 (__bridge CFStringRef)encodedString,CFSTR(""),CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}


-(UIColor *)tintColor{
    return objc_getAssociatedObject(self, _cmd);
    
}

-(void)setTintColor:(UIColor *)tintColor{
    objc_setAssociatedObject(self, @selector(tintColor), tintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
