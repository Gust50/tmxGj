//
//  KBLeftMenuBar.h
//  KBAnimationExample
//
//  Created by kobe on 16/9/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KBLeftMenuBarDelegate <NSObject>
-(void)clickLeftMenuBarItem:(NSInteger)index;
@optional
-(void)showLeftMenuItemBar;
-(void)hideLeftMenuItemBar;
@end

@interface KBLeftMenuBar : UIView
-(instancetype)initWithMenuItemsNormalImg:(NSArray *)normalImgArr
                             highlightImg:(NSArray *)highlightImgArr
                                     size:(CGSize)size;

-(void)showLeftMenuBarItems;
-(void)hideLeftMenuBarItems;

@property (nonatomic, weak) id<KBLeftMenuBarDelegate>delegate;
@property (nonatomic, assign) BOOL isShow;
@end
