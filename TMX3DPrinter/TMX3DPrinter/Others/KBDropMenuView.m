//
//  KBDropMenuView.m
//  ClshUser
//
//  Created by kobe on 16/6/13.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "KBDropMenuView.h"

@interface KBDropMenuView ()

@property (nonatomic, strong) UIImageView *backGroundImgView;      ///<背景图层


@end

@implementation KBDropMenuView

-(UIImageView *)backGroundImgView{
    if (!_backGroundImgView) {
        _backGroundImgView=[[UIImageView alloc]init];
        _backGroundImgView.userInteractionEnabled=YES;
        _backGroundImgView.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
    return _backGroundImgView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor clearColor];
        [self addSubview:self.backGroundImgView];
    }
    self.transform = CGAffineTransformMakeScale(0.001, 0.001);

    return self;
}

-(void)showView:(UIView *)view{
    CGFloat x=view.center.x;
    CGFloat y=view.center.y;
    [self shoViewFromPoint:CGPointMake(x, y)];
}

-(void)shoViewFromPoint:(CGPoint)point{
    
    if (_menuState==MenuShow) return;
    
    
//    UIWindow *window=[UIApplication sharedApplication].keyWindow;
//    [window addSubview:self];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.transform=CGAffineTransformMakeScale(1.0, 1.0);
    }];
    
    self.layer.position=CGPointMake(self.layer.anchorPoint.x*self.frame.size.width+point.x, self.layer.anchorPoint.y*self.frame.size.height+point.y);
    _menuState=MenuShow;
}

-(void)hideMenu{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.transform=CGAffineTransformMakeScale(0.001, 0.001);
    }];
    _menuState=MenuDiss;
}


-(void)setContentView:(UIView *)contentView{
    
    _contentView=contentView;
    contentView.frame=self.backGroundImgView.frame;
    _contentView.layer.borderColor=[UIColor grayColor].CGColor;
    _contentView.layer.borderWidth=1;
    _contentView.layer.cornerRadius=3.0;
    _contentView.layer.masksToBounds=YES;
    
    [self.backGroundImgView addSubview:contentView];
}

-(void)setBackGroundImg:(NSString *)backGroundImg{
    _backGroundImg=backGroundImg;
    self.backGroundImgView.image=[UIImage imageNamed:backGroundImg];
    
}

-(void)setAnchorPoint:(CGPoint)anchorPoint{
    self.layer.anchorPoint=anchorPoint;
}

-(void)setContentVC:(UIViewController *)contentVC{
    _contentVC=contentVC;
    self.contentView=contentVC.view;
}

-(void)setOrigin:(CGPoint)origin{
    _origin=origin;
    CGRect frame=_contentView.frame;
    frame.origin=origin;
    _contentView.frame=frame;
}
@end
