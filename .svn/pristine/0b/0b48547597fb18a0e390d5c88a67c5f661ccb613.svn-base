//
//  NSBundle+Extension.m
//  TMX3DPrinter
//
//  Created by kobe on 16/10/26.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "NSBundle+Extension.h"
#import <objc/runtime.h>

static const char kBundleKey=0;

@interface BundleEx : NSBundle

@end

@implementation BundleEx

-(NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName{
    
    NSBundle *bundle=objc_getAssociatedObject(self, &kBundleKey);
    if (bundle) {
        return [bundle localizedStringForKey:key value:value table:tableName];
    }else{
        return [super localizedStringForKey:key value:value table:tableName];
    }
}


@end


@implementation NSBundle (Extension)
+(void)setLanguage:(NSString *)language{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        object_setClass([NSBundle mainBundle], [BundleEx class]);
    });
    
    id value=language ? [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:language ofType:@"lproj"]]:nil;
    objc_setAssociatedObject([NSBundle mainBundle], &kBundleKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+(NSString *)getCurrentLanguage{
    NSArray *languages=[NSLocale preferredLanguages];
    return [languages objectAtIndex:0];
}
@end
