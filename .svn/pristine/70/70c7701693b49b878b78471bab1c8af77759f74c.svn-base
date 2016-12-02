//
//  NSObject+KBExtension.h
//  ClshUser
//
//  Created by kobe on 16/6/4.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KBExtension)

/**
 *  返回JSON格式的字典
 *
 *  @param jsonData    JSON数据
 *
 *  @return            返回JSON格式的字典
 */
+(NSDictionary *)returnJson:(id)jsonData;

/**
 *  Data数据类型装换成String数据类型
 *
 *  @param data        Data数据类型
 *
 *  @return            返回String类型
 */
+(NSString *)stringWithData:(NSData *)data;

/**
 *  String类型转换成JSON格式的String
 *
 *  @param string      String
 *
 *  @return            JSON格式的String
 */
+(NSString *)jsonTypeStringWithString:(NSString *)string;

/**
 *  id类型转换成JSON格式
 *
 *  @param object     id
 *
 *  @return           JSON格式的字符串
 */
+(NSString *)jsonTypeStringWithData:(id)object;

/**
 *  字典装换成Data类型
 *
 *  @param dict      字典
 *
 *  @return          Data类型
 */
+(NSData *)dataWithDictionary:(NSDictionary *)dict;

@end
