//
//  NSString+KBExtension.h
//  ClshUser
//
//  Created by kobe on 16/6/13.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (KBExtension)

@property (nonatomic, strong) UIColor *tintColor;   ///<字体的颜色

/**
 *  计算文字的高度
 *
 *  @param str   文本内容
 *  @param font  文字字体大小
 *  @param width 显示的文字宽度
 *
 *  @return size
 */
+(CGSize)sizeWithStr:(NSString *)str
                font:(UIFont *)font
               width:(CGFloat)width;

/**
 *  设置Label的字体属性
 *
 *  @param lable 控件
 *  @param font  字体大小
 *  @param range 范围
 *  @param color 字体颜色
 */
+(void)labelString:(UILabel *)lable
               font:(UIFont *)font
              range:(NSRange)range
              color:(UIColor *)color;


/**
 *  设置数字格式
 *
 *  @return  NSNumberFormatter
 */
+(NSNumberFormatter *)numberFormatter;


/**
 *  动态计算文字的高度
 *
 *  @param maxWidth maxWidth
 *  @param textFont textFont
 *  @param textContent  textContent
 *  @return CGSzie
 */
+(CGSize)caculatorTextSize:(CGFloat)maxWidth
                  textFont:(UIFont *)textFont
               textContent:(NSString *)textContent;

+(NSString *)encodeString:(NSString *)unencodedString;
+(NSString *)decodeString:(NSString *)encodedString;
+ (NSString *)lr_stringDate;
@end
