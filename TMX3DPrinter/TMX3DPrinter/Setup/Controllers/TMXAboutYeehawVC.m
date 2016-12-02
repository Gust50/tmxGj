//
//  TMXAboutYeehawVC.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/6/11.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXAboutYeehawVC.h"

@interface TMXAboutYeehawVC ()
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contentTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contentHeigt;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *netHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *netWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *netH;


@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UILabel *netBUtton;
@property (strong, nonatomic) IBOutlet UILabel *wechatButton;
@property (strong, nonatomic) IBOutlet UILabel *weiboButton;
@property (strong, nonatomic) IBOutlet UILabel *emailButton;
@property (strong, nonatomic) IBOutlet UIImageView *netImage;

@end

@implementation TMXAboutYeehawVC
//修改属性
- (void)modify
{
    self.netH.constant = 20*AppScale;
    self.netWidth.constant = 20*AppScale;
    self.netHeight.constant = 30*AppScale;
    self.topViewHeight.constant = 210*AppScale;
    self.iconTop.constant = 84*AppScale;
    self.iconWidth.constant = 100*AppScale;
    self.iconHeight.constant = 110*AppScale;
    self.contentTop.constant = 15*AppScale;
    self.contentHeigt.constant = 125*AppScale;
    
    self.textView.backgroundColor = backGroundColor;
    self.textView.userInteractionEnabled = NO;
    self.netBUtton.userInteractionEnabled = NO;
     self.wechatButton.userInteractionEnabled = NO;
     self.weiboButton.userInteractionEnabled = NO;
     self.emailButton.userInteractionEnabled = NO;
    self.textView.text = NSLocalizedString(@"TMXIntro", nil);
//    self.weiboButton.text = NSLocalizedString(@"3DPrint", nil);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:NSLocalizedString(@"Yeehaw", nil)];
    self.view.backgroundColor = backGroundColor;
    [self modify];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //给导航条设置一个空的背景图 使其透明化
    [self.navigationController .navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //去除导航条透明后导航条下的黑线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16*AppScale],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self enableOpenLeftDrawer:NO];
    
}


@end
