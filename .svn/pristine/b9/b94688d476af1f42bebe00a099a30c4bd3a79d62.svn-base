//
//  KBDateFormatter.m
//  ClshUser
//
//  Created by kobe on 16/6/20.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "KBDateFormatter.h"

@interface KBDateFormatter ()

@property (nonatomic, strong) NSDateFormatter *dateFormatter;
-(void)systemTimeZoneDidChange:(NSNotification *)notification;

@end

@implementation KBDateFormatter
static NSString * const kUSATimeFormatter = @"MM/dd/yyyy HH:mm";
static NSString * const kCHTimeFormatter = @"yyyy-MM-dd";

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static KBDateFormatter *shareInstance;
    dispatch_once(&onceToken, ^{
        if (!shareInstance) {
            shareInstance = [[self alloc] init];
        }
    });
    return shareInstance;
}

-(instancetype)init{
    if (self==[super init]) {
        self.dateFormatter=[[NSDateFormatter alloc]init];
        [self.dateFormatter setDateFormat:kUSATimeFormatter];
        [self setLocation:KBLocationUSA];
        [self setTimeZone:KBTimeZoneUSA];
    }
    return self;
}



-(NSTimeInterval)timeIntervalFromDate:(NSDate *)date{
    return date.timeIntervalSince1970;
}


-(NSTimeInterval)timeIntervalFromString:(NSString *)string{
    NSDate *date=[self dateFromString:string];
    return date.timeIntervalSince1970;
}

-(NSDate *)dateFromString:(NSString *)string{
    NSDate *date=[self.dateFormatter dateFromString:string];
    return date;
}

-(NSDate *)dateFromTimeInterval:(NSTimeInterval)timeInterval{
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:timeInterval];
    return date;
}

-(NSString *)stringFromDate:(NSDate *)date{
    return [self.dateFormatter stringFromDate:date];
}


-(void)setLocation:(KBLocation)location{
    _location=location;
    NSLocale *local=nil;
    switch (location) {
        case KBLocationLocal:
            local=[NSLocale currentLocale];
            break;
        case KBLocationChina:
            local=[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
            break;
        case KBLocationUSA:
            local=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
            break;
        default:
            break;
    }
    self.dateFormatter.locale=local;
}

-(void)setTimeZone:(KBTimeZone)timeZone{
    _timeZone=timeZone;
    NSTimeZone *newTimeZone;
    switch (timeZone) {
        case KBTimeZoneLocal:
            newTimeZone=[NSTimeZone systemTimeZone];
            break;
        case KBTimeZoneChina:
            newTimeZone=[NSTimeZone systemTimeZone];
            break;
        case KBTimeZoneUSA:
            newTimeZone=[NSTimeZone systemTimeZone];
            break;
        default:
            break;
    }
}

-(void)setDateFormatterString:(NSString *)dateFormatterString{
    _dateFormatterString=dateFormatterString;
    [self.dateFormatter setDateFormat:dateFormatterString];
}

-(void)setDefaultTimeStyle{
    [self.dateFormatter setDateFormat:kCHTimeFormatter];
}
@end
