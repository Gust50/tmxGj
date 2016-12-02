//
//  KBDropMenuView.h
//  ClshUser
//
//  Created by kobe on 16/6/13.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,MenuState){
    MenuDiss,
    MenuShow,
};

@interface KBDropMenuView : UIView

@property (nonatomic, strong) UIView *contentView;         ///<容器内容
@property (nonatomic, copy) NSString *backGroundImg;      ///<背景图片
@property (nonatomic, assign) CGPoint anchorPoint;         ///<锚点
@property (nonatomic, assign) MenuState menuState;          ///<菜单显示状态
@property (nonatomic, strong) UIViewController *contentVC;  ///<控制器
@property (nonatomic, assign) CGPoint origin;               ///<起始坐标位置

-(void)shoViewFromPoint:(CGPoint)point;                ///<从一个point点显示图层
-(void)showView:(UIView *)view;                        ///<在view视图上面添加视图
-(void)hideMenu;                                       ///<影藏图层

@end
