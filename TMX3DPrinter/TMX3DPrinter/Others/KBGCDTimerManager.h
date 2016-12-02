//
//  KBGCDTimerManager.h
//  TMX3DPrinter
//
//  Created by kobe on 16/8/29.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, timerTaskType){
    cacheTimerTaskType=0,     ///<cache timerTask
    removeTimerTaskType=1     ///<remove before timerTask
};

@interface KBGCDTimerManager : NSObject

+(KBGCDTimerManager *)shareInstance;


-(void)scheduledDispatchTimerWithName:(NSString *)timerName
                         timeInterval:(double)interval
                                queue:(dispatch_queue_t)queue
                              repeats:(BOOL)isRepeats
                             timerTaskType:(timerTaskType)timerTaskType
                               action:(dispatch_block_t)action;

-(void)scheduledDispatchTimerWithName:(NSString *)timerName
                         timeInterval:(double)interval
                         timeInterNow:(double)intervalNow
                                queue:(dispatch_queue_t)queue
                              repeats:(BOOL)isRepeats
                        timerTaskType:(timerTaskType)timerTaskType
                               action:(dispatch_block_t)action;

-(void)cancelTimerTaskWithName:(NSString *)timerName;
-(void)cancelAllTimerTask;
-(void)pauseTimerTask:(NSString *)timerName;
-(void)resumeTimerTask:(NSString *)timerName;

@end
