//
//  NSBundle+Extension.h
//  TMX3DPrinter
//
//  Created by kobe on 16/10/26.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (Extension)
+(void)setLanguage:(NSString *)language;
+(NSString *)getCurrentLanguage;
@end
