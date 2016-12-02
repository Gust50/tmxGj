//
//  KBFetchSystemInfo.m
//  TMX3DPrinter
//
//  Created by kobe on 16/8/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "KBFetchSystemInfo.h"
#import <SystemConfiguration/CaptiveNetwork.h>

@interface KBFetchSystemInfo ()

@end

@implementation KBFetchSystemInfo

+(KBFetchSystemInfo *)shareInstance{
    
    static KBFetchSystemInfo *kBFetchSystemInfo=nil;
    static dispatch_once_t onceToken;
    _dispatch_once(&onceToken, ^{
        kBFetchSystemInfo=[[KBFetchSystemInfo alloc]init];
    });
    return kBFetchSystemInfo;
}

-(NSString *)fetchCurrentWIFIName{
    
    NSString *WIFIName=nil;
    CFArrayRef wifiInterfaces=CNCopySupportedInterfaces();
    if (!wifiInterfaces) return nil;
    
    NSArray *interfaces=(__bridge NSArray *)wifiInterfaces;
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef=CNCopyCurrentNetworkInfo((__bridge CFStringRef)interfaceName);
        if (dictRef) {
            NSDictionary *networkInfo=(__bridge NSDictionary *)dictRef;
            WIFIName=[networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            CFRelease(dictRef);
        }
    }
    CFRelease(wifiInterfaces);
    return WIFIName;
}

@end
