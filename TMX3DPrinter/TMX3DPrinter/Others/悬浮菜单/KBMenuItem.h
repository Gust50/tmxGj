//
//  KBMenuItem.h
//  KBAnimationExample
//
//  Created by kobe on 16/9/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBMenuItem : UIButton

-(instancetype)initWithNormalImg:(NSString *)normalImg
                    highlightImg:(NSString *)highlight
                            size:(CGSize)size
                          target:(id)target action:(SEL)action;

+(KBMenuItem *)menuItemWithNormalImg:(NSString *)normalImg
                        highlightImg:(NSString *)highlight
                                size:(CGSize)size
                              target:(id)target action:(SEL)action;

-(void)showMenuItemWithPoint:(CGPoint)point;
-(void)hideMenuItem;
@end
