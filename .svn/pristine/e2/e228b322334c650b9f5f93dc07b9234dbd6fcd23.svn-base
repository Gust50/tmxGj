//
//  NSArray+KBExtension.m
//  ClshMerchant
//
//  Created by kobe on 16/8/5.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "NSArray+KBExtension.h"

@implementation NSArray (KBExtension)

-(id)objectAtIndexCheck:(NSUInteger)index{
    if (index>=[self count]) {
        return nil;
    }
    
    id value=[self objectAtIndex:index];
    if (value==[NSNull null]) {
        return nil;
    }
    return value;
}
@end
