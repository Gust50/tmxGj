//
//  TMXAdvertiseWebVC.m
//  TMX3DPrinter
//
//  Created by kobe on 16/9/20.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXAdvertiseWebVC.h"
#import <WebKit/WebKit.h>


@interface TMXAdvertiseWebVC ()<WKNavigationDelegate,WKUIDelegate>
{
     MBProgressHUD *hud;
}
@property (nonatomic, strong) WKWebView *web;
@end

@implementation TMXAdvertiseWebVC

#pragma mark <lazyLoad>
-(WKWebView *)web{
    if (!_web) {
        _web=[[WKWebView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64)];
        _web.navigationDelegate=self;
        
    }
    return _web;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.view addSubview:self.web];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:_webUrl]];
    [_web loadRequest:request];
    hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.backgroundColor=[UIColor clearColor];
    hud.color=[UIColor clearColor];
    hud.activityIndicatorColor=systemColor;
    
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [hud hide:YES];
}


#pragma mark <getter setter>
-(void)setWebUrl:(NSString *)webUrl{
    _webUrl=webUrl;
}

@end
