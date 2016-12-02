//
//  NSDate+KBExtension.h
//  ClgsUser
//
//  Created by kobe on 16/3/22.
//  Copyright © 2016年 com.xinmengsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (KBExtension)

/** isToday */
-(BOOL)isToday;
/** isYesterday */
-(BOOL)isYesterday;
/** isThisYear */
-(BOOL)isThisYear;
/** return a date format with YMD(返回一个年月日的格式) */
-(NSDate *)dateWithYMD;
/** return a time gap(时间差) */
-(NSDateComponents *)deltaWithNow;

+(NSString *)caculatorTime:(NSDate *)date;

/**
 转换时间为H:M:S

 @param totalTime S

 @return string
 */
+(NSString *)formatterTimeWithSec:(NSInteger)totalTime;
@end
