//
//  KBDateFormatter.h
//  ClshUser
//
//  Created by kobe on 16/6/20.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,KBLocation) {
    KBLocationLocal,
    KBLocationUSA,
    KBLocationChina
};

typedef NS_ENUM(NSInteger,KBTimeZone) {
    KBTimeZoneLocal,
    KBTimeZoneUSA,
    KBTimeZoneChina
};


@interface KBDateFormatter : NSObject

@property (nonatomic, assign) KBLocation location;     ///<设置当地区域
@property (nonatomic, assign) KBTimeZone timeZone;     ///<设置当地时间
@property (nonatomic, copy) NSString *dateFormatterString;      ///<设置时间格式

+(instancetype)shareInstance;
-(void)setDefaultTimeStyle;

-(NSTimeInterval)timeIntervalFromDate:(NSDate *)date;          ///<NSDate类型转换时间戳
-(NSTimeInterval)timeIntervalFromString:(NSString *)string;    ///<NSString类型转时间戳
-(NSDate *)dateFromString:(NSString *)string;
-(NSDate *)dateFromTimeInterval:(NSTimeInterval)timeInterval;
-(NSString *)stringFromDate:(NSDate *)date;

@end
