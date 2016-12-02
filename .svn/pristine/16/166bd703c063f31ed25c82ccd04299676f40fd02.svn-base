//
//  TMXBaseVC.m
//  TMX3DPrinterHD
//
//  Created by kobe on 16/8/19.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXBaseVC.h"
#import "AppDelegate.h"
#import "TMXLeftVC.h"

@interface TMXBaseVC ()
@property (nonatomic, copy) leftBarButtonAction leftBarButtonAction;
@property (nonatomic, copy) rightBarButtonAction rightBarButtonAction;
@end

@implementation TMXBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self hideNavBlackLine];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

-(void)enableOpenLeftDrawer:(BOOL)enable{
    
    if (enable) {
        [ShareApp.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
        [ShareApp.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    }else{
        [ShareApp.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        [ShareApp.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
    }
}
-(void)enableOpenRightDrawer:(BOOL)enable{
    
    if (enable) {
        [ShareApp.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
        [ShareApp.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    }else{
        [ShareApp.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        [ShareApp.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
    }
}

-(void)configureLeftBarButtonWithTitle:(NSString *)title icon:(NSString *)icon action:(leftBarButtonAction)action{
    if (title==nil) {
        
        self.leftBarButtonAction=action;
        self.navigationItem.leftBarButtonItem=[UIBarButtonItem normalImage:icon selectImage:icon target:self action:@selector(clickLeftBtn)];
    }
    
}

-(void)clickLeftBtn{
    if (self.leftBarButtonAction) {
        self.leftBarButtonAction();
    }
}

-(void)configureRightBarButtonWithTitle:(NSString *)title icon:(NSString *)icon action:(rightBarButtonAction)action{
    
    if (title==nil) {
        self.rightBarButtonAction=action;
        self.navigationItem.rightBarButtonItem=[UIBarButtonItem normalImage:icon selectImage:icon target:self action:@selector(clickRightBtn)];
    }
}

-(void)clickRightBtn{
    if (self.rightBarButtonAction) {
        self.rightBarButtonAction();
    }
}

/**
 *  隐藏黑线
 */
-(void)hideNavBlackLine{
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
//        NSArray *list=self.navigationController.navigationBar.subviews;
//        for (id object in list) {
//            if ([object isKindOfClass:[UIImageView class]]) {
//                UIImageView *imageViews=(UIImageView *)object;
//                imageViews.hidden=YES;
//            }
//        }
    }
}
@end
