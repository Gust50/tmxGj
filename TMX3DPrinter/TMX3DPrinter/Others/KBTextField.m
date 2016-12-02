//
//  KBTextField.m
//  TMX3DPrinter
//
//  Created by kobe on 2016/11/28.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "KBTextField.h"

@implementation KBTextField

-(CGRect)placeholderRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x+10, bounds.origin.y, bounds.size.width -10, bounds.size.height);
    return inset;
}

-(CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x+10, bounds.origin.y, bounds.size.width -10, bounds.size.height);
    return inset;

}
@end
