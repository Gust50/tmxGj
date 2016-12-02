//
//  UILabel+KBExtension.m
//  TMX3DPrinter
//
//  Created by kobe on 16/10/19.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "UILabel+KBExtension.h"
#import <objc/runtime.h>


@implementation UILabel (KBExtension)

-(UIColor *)forcedTintColor{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setForcedTintColor:(UIColor *)forcedTintColor{
    objc_setAssociatedObject(self, @selector(forcedTintColor), forcedTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+(void)load{
    
    
    swizzleMethod([UILabel class], @selector(setTintColor:), @selector(setLabelTintColor:));
    swizzleMethod([UILabel class], @selector(setTextColor:), @selector(setLabelTextColor:));
}


void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector)
{
    // the method might not exist in the class, but in its superclass
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    // class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    // the method doesn’t exist and we just added one
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


-(void)setLabelTintColor:(UIColor *)tintColor{
    
    if(self.forcedTintColor){
        [self setLabelTintColor:self.forcedTintColor];
        return;
    }
    if(self.text.tintColor){
        
        [self setLabelTintColor:self.text.tintColor];
        self.forcedTintColor = self.text.tintColor;
        return;
    }
    [self setLabelTintColor:tintColor];
}

-(void)setLabelTextColor:(UIColor *)textColor{
    
    if(self.forcedTintColor){
        [self setLabelTextColor:self.forcedTintColor];
        return;
    }
    if(self.text.tintColor){
        
        [self setLabelTextColor:self.text.tintColor];
        self.forcedTintColor = self.text.tintColor;
        return;
    }
    [self setLabelTextColor:textColor];
}
@end
