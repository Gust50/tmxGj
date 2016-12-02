//
//  NSArray+KBExtension.h
//  ClshMerchant
//
//  Created by kobe on 16/8/5.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (KBExtension)
/**
 *  IndexOutOfBoundsException
 *
 *  @param index index
 *
 *  @return id
 */
-(id)objectAtIndexCheck:(NSUInteger)index;
@end
