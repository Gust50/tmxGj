//
//  TMXBaseVC.h
//  TMX3DPrinterHD
//
//  Created by kobe on 16/8/19.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^leftBarButtonAction)(void);
typedef void(^rightBarButtonAction)(void);

@interface TMXBaseVC : UIViewController

-(void)configureLeftBarButtonWithTitle:(NSString *)title
                                  icon:(NSString *)icon
                                action:(leftBarButtonAction)action;

-(void)configureRightBarButtonWithTitle:(NSString *)title
                                   icon:(NSString *)icon
                                 action:(rightBarButtonAction)action;

-(void)enableOpenLeftDrawer:(BOOL)enable;
-(void)enableOpenRightDrawer:(BOOL)enable;
@end
