//
//  KBGCDTimerManager.m
//  TMX3DPrinter
//
//  Created by kobe on 16/8/29.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "KBGCDTimerManager.h"

@interface KBGCDTimerManager ()
@property (nonatomic, strong) NSMutableDictionary *timerContainter;   ///< save timer
@property (nonatomic, strong) NSMutableDictionary *actionBlockCache;  ///< save timerAction
@end

@implementation KBGCDTimerManager

#pragma mark <lazyLoad>
-(NSMutableDictionary *)timerContainter{
    if (!_timerContainter) {
        _timerContainter=[NSMutableDictionary new];
    }
    return _timerContainter;
}

-(NSMutableDictionary *)actionBlockCache{
    if (!_actionBlockCache) {
        _actionBlockCache=[NSMutableDictionary new];
    }
    return _actionBlockCache;
}


+(KBGCDTimerManager *)shareInstance{
    static KBGCDTimerManager *kBGCDTimerManager=nil;
    static dispatch_once_t onceToken;
    _dispatch_once(&onceToken, ^{
        kBGCDTimerManager=[KBGCDTimerManager new];
    });
    
    return kBGCDTimerManager;
}
-(void)scheduledDispatchTimerWithName:(NSString *)timerName
                         timeInterval:(double)interval
                                queue:(dispatch_queue_t)queue
                              repeats:(BOOL)isRepeats
                        timerTaskType:(timerTaskType)timerTaskType
                               action:(dispatch_block_t)action{
    
    if (timerName==nil) return;
    if (queue==nil) queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer=[self.timerContainter objectForKey:timerName];
    if (!timer) {
        timer=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_resume(timer);
        [self.timerContainter setObject:timer forKey:timerName];
    }
    
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, (int64_t)interval*NSEC_PER_SEC),interval*NSEC_PER_SEC, 0.1*NSEC_PER_SEC);
    __weak typeof(self) weakSelf=self;
    
    
    switch (timerTaskType) {
        case cacheTimerTaskType:{
            [self cacheAction:action timerName:timerName];
            dispatch_source_set_event_handler(timer, ^{
                NSMutableArray *actionArray=[self.actionBlockCache objectForKey:timerName];
                [actionArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    dispatch_block_t actonBlock=obj;
                    actonBlock();
                }];
                [weakSelf removeActionCacheWithTimerName:timerName];
                if (!isRepeats) {
                    [weakSelf cancelTimerTaskWithName:timerName];
                }
            });
        }
            break;
        case removeTimerTaskType:{
            [weakSelf removeActionCacheWithTimerName:timerName];
            dispatch_source_set_event_handler(timer, ^{
                action();
                if (!isRepeats) {
                    [weakSelf cancelTimerTaskWithName:timerName];
                }
            });
        }
            break;
        default:
            break;
    }
    
}

-(void)scheduledDispatchTimerWithName:(NSString *)timerName timeInterval:(double)interval timeInterNow:(double)intervalNow queue:(dispatch_queue_t)queue repeats:(BOOL)isRepeats timerTaskType:(timerTaskType)timerTaskType action:(dispatch_block_t)action{
    if (timerName==nil) return;
    if (queue==nil) queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer=[self.timerContainter objectForKey:timerName];
    if (!timer) {
        timer=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_resume(timer);
        [self.timerContainter setObject:timer forKey:timerName];
    }
    
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, (int64_t)intervalNow*NSEC_PER_SEC),interval*NSEC_PER_SEC, 0.001*NSEC_PER_SEC);
    __weak typeof(self) weakSelf=self;
    
    
    switch (timerTaskType) {
        case cacheTimerTaskType:{
            [self cacheAction:action timerName:timerName];
            dispatch_source_set_event_handler(timer, ^{
                NSMutableArray *actionArray=[self.actionBlockCache objectForKey:timerName];
                [actionArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    dispatch_block_t actonBlock=obj;
                    actonBlock();
                }];
                [weakSelf removeActionCacheWithTimerName:timerName];
                if (!isRepeats) {
                    [weakSelf cancelTimerTaskWithName:timerName];
                }
            });
        }
            break;
        case removeTimerTaskType:{
            [weakSelf removeActionCacheWithTimerName:timerName];
            dispatch_source_set_event_handler(timer, ^{
                action();
                if (!isRepeats) {
                    [weakSelf cancelTimerTaskWithName:timerName];
                }
            });
        }
            break;
        default:
            break;
    }

    
}


-(void)cancelTimerTaskWithName:(NSString *)timerName{
    
    dispatch_source_t timer=[self.timerContainter objectForKey:timerName];
    if (!timer) return;
    [self.timerContainter removeObjectForKey:timerName];
    dispatch_source_cancel(timer);
    [self.actionBlockCache removeObjectForKey:timerName];
}

-(void)pauseTimerTask:(NSString *)timerName{
    
    dispatch_source_t timer=[self.timerContainter objectForKey:timerName];
    if (!timerName) return;
    dispatch_suspend(timer);
}

-(void)resumeTimerTask:(NSString *)timerName{
    
    dispatch_source_t timer=[self.timerContainter objectForKey:timerName];
    if (!timer) return;
    dispatch_resume(timer);
}

-(void)cancelAllTimerTask{
    
    [self.timerContainter enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self.timerContainter removeObjectForKey:key];
        dispatch_source_cancel(obj);
    }];
}

-(void)cacheAction:(dispatch_block_t)action timerName:(NSString *)timerName{
    
    id actionArray=[self.actionBlockCache objectForKey:timerName];
    if (actionArray && [actionArray isKindOfClass:[NSMutableArray class]]) {
        [(NSMutableArray *)actionArray addObject:action];
    }else{
        NSMutableArray *array=[NSMutableArray arrayWithObject:action];
        [self.actionBlockCache setObject:array forKey:timerName];
    }
}

-(void)removeActionCacheWithTimerName:(NSString *)timerName{
    
    if (![self.actionBlockCache objectForKey:timerName]) return;
    [self.actionBlockCache removeObjectForKey:timerName];
}
@end
