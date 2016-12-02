//
//  KBFetchSystemInfo.h
//  TMX3DPrinter
//
//  Created by kobe on 16/8/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBFetchSystemInfo : NSObject
+(KBFetchSystemInfo *)shareInstance;
-(NSString *)fetchCurrentWIFIName;
@end
