//
//  TMXMovePaperLocationVC.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/6/12.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXMovePaperLocationVC.h"
#import "TMXPrinterIntoWireVC.h"
#import "UIImage+GIF.h"
#import "TMXAccountPrinterCommandModel.h"


@interface TMXMovePaperLocationVC ()
{
    TMXAccountPrinterCommandModel *cmdModel;
     NSMutableDictionary *params;
     CGFloat length;
}
//图片
@property (strong, nonatomic) IBOutlet UIImageView *printerImage;
@property (strong, nonatomic) IBOutlet UILabel *describe;
//下一步
@property (strong, nonatomic) IBOutlet UIButton *nextStepButton;
//0.1mm
@property (strong, nonatomic) IBOutlet UIView *hideView;
@property (strong, nonatomic) IBOutlet UIButton *bottomButton;
@property (strong, nonatomic) IBOutlet UIButton *topButton;
//1.0mm
@property (strong, nonatomic) IBOutlet UIView *hideSecondView;
@property (strong, nonatomic) IBOutlet UIButton *bottomSecondButton;
@property (strong, nonatomic) IBOutlet UIButton *topSecondButton;

@property (nonatomic, assign) BOOL isPop;

- (IBAction)zAxisUp:(id)sender;

- (IBAction)zAxisBottom:(id)sender;

@end

@implementation TMXMovePaperLocationVC

//修改属性
- (void)modify
{
    self.nextStepButton.layer.cornerRadius = 5.0;
    self.nextStepButton.layer.masksToBounds = YES;
    self.bottomButton.layer.cornerRadius = 5.0;
    self.bottomButton.layer.masksToBounds = YES;
    self.topButton.layer.cornerRadius = 5.0;
    self.topButton.layer.masksToBounds = YES;
    self.bottomSecondButton.layer.cornerRadius = 5.0;
    self.bottomSecondButton.layer.masksToBounds = YES;
    self.topSecondButton.layer.cornerRadius = 5.0;
    self.topSecondButton.layer.masksToBounds = YES;
    [self.bottomButton setTitle:NSLocalizedString(@"OneBottom", nil) forState:UIControlStateNormal];
    [self.topButton setTitle:NSLocalizedString(@"OneTop", nil) forState:UIControlStateNormal];
    [self.bottomSecondButton setTitle:NSLocalizedString(@"TwoBottom", nil) forState:UIControlStateNormal];
    [self.topSecondButton setTitle:NSLocalizedString(@"TwoTop", nil) forState:UIControlStateNormal];
    //是否隐藏
    self.hideView.hidden=_isHidden;
    self.hideSecondView.hidden=_isHidden;
    
    if (_isHidden) {
        self.describe.text = NSLocalizedString(@"A4", nil);
        self.printerImage.image=[UIImage sd_animatedGIFNamed:@"printerInit"];
    }else{
        self.describe.text = NSLocalizedString(@"Touch", nil);
        
    }
    
    [self.nextStepButton setTitle:NSLocalizedString(@"Next", nil) forState:UIControlStateNormal];
    if (_nextTrail) {
        self.printerImage.image=[UIImage sd_animatedGIFNamed:@"printerTrail"];
    }
    if (_nextRight) {
        
        self.printerImage.image=[UIImage sd_animatedGIFNamed:@"printerRight"];
    }
    if (_nextLeft) {
        self.printerImage.image=[UIImage sd_animatedGIFNamed:@"printerLeft"];

    }
    if (_nextCenter) {
        self.printerImage.image=[UIImage sd_animatedGIFNamed:@"printerCenter"];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self modify];
    self.view.backgroundColor = [UIColor whiteColor];
    
    params=[NSMutableDictionary dictionary];
    cmdModel=[[TMXAccountPrinterCommandModel alloc]init];
    WS(weakSelf);
    

//    UIBarButtonItem *cancelBtn=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:nil];
    
    UIButton *cancleBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [cancleBtn setTitle:NSLocalizedString(@"Cancel", nil) forState:0];
    cancleBtn.backgroundColor=[UIColor grayColor];
    cancleBtn.layer.cornerRadius=5.0;
    cancleBtn.layer.masksToBounds=YES;
    [cancleBtn addTarget:self action:@selector(cancelPrinter) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:cancleBtn];
    
    
//    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:nil];
//    self.navigationItem.leftBarButtonItem.tintColor=backGroundColor;
    
//    
//    [weakSelf configureLeftBarButtonWithTitle:nil action:^{
//        
//        
//        
//        if (_isHidden) {
//            
//            [self.navigationController popViewControllerAnimated:YES];
//        }else{
//            
//            params[@"command"]=@(13);
//            params[@"printerId"]=_printerId;
//            self.isPop=YES;
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0)*(NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                
////                [weakSelf sendCmd];
//                
//                [cmdModel FetchTMXAccountPrinterCommandData:params callBack:^(BOOL isSuccess, id result) {
//                   
//                    if (isSuccess) {
//                        [self.navigationController popViewControllerAnimated:YES];
//                    }
//                }];
//            });
//        }
//        
    
       
        
//        [self.navigationController popViewControllerAnimated:YES];
//
//       
//    }];
//    
    
//    if (_nextTrail) {
//        [self configureLeftBarButtonWithTitle:nil action:^{
//            NSLog(@"取消");
//        }];
//    }
    
    
    
}


-(void)cancelPrinter{
    
    
    if (_isHidden) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
        params[@"command"]=@(13);
        params[@"printerId"]=_printerId;
//        self.isPop=YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0)*(NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            //                [weakSelf sendCmd];
            
            [cmdModel FetchTMXAccountPrinterCommandData:params callBack:^(BOOL isSuccess, id result) {
                
                if (isSuccess) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        });
    }
    

}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //关闭侧滑
     [self enableOpenLeftDrawer:NO];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //开启侧滑
    [self enableOpenLeftDrawer:YES];
}

//下一步
- (IBAction)setNextStep:(UIButton *)sender {
    if (_isHidden) {
        
        params[@"command"]=@(11);
//        params[@"printerId"]=_printerId;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0)*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self sendCmd];
        });
        
    }else{
        if (_nextTrail) {
            
//            TMXMovePaperLocationVC *tMXMovePaperLocationVC=[[TMXMovePaperLocationVC alloc]init];
//            tMXMovePaperLocationVC.nextRight=YES;
//            [self.navigationController pushViewController:tMXMovePaperLocationVC animated:YES];
            params[@"command"]=@(12);
            [self sendCmd];
        }
        
        if (_nextRight) {
            
//            TMXMovePaperLocationVC *tMXMovePaperLocationVC=[[TMXMovePaperLocationVC alloc]init];
//            tMXMovePaperLocationVC.nextLeft=YES;
//            [self.navigationController pushViewController:tMXMovePaperLocationVC animated:YES];
            params[@"command"]=@(12);
            [self sendCmd];
            
        }
        if (_nextLeft) {
            
//            TMXMovePaperLocationVC *tMXMovePaperLocationVC=[[TMXMovePaperLocationVC alloc]init];
//            tMXMovePaperLocationVC.nextCenter=YES;
//            [self.navigationController pushViewController:tMXMovePaperLocationVC animated:YES];
            params[@"command"]=@(12);
            [self sendCmd];
        }
        
        if (_nextCenter) {
            
            params[@"command"]=@(12);
            [self sendCmd];
            
            NSLog(@">>>>>>>>>>>>>");
        }

        
    }
}


#pragma makr <otherResponse>

- (IBAction)zAxisUp:(id)sender {
    if (_nextTrail) {
        
        params[@"length"]=@(0.1);
        params[@"command"]=@(7);
        [self sendCmdNotSkip];
    }
    
    if (_nextRight) {
        
        params[@"length"]=@(0.1);
        params[@"command"]=@(7);
        [self sendCmdNotSkip];

    }
    
    if (_nextLeft) {
        
        params[@"length"]=@(0.1);
        params[@"command"]=@(7);
        [self sendCmdNotSkip];

    }
    
    if (_nextCenter) {
        
        params[@"length"]=@(0.1);
        params[@"command"]=@(7);
        [self sendCmdNotSkip];

    }
    
}

- (IBAction)zAxisBottom:(id)sender {
    
    if (_nextTrail) {
        
        params[@"length"]=@(-0.1);
        params[@"command"]=@(7);
        [self sendCmdNotSkip];

    }
    
    if (_nextRight) {
        
        params[@"length"]=@(-0.1);
        params[@"command"]=@(7);
        [self sendCmdNotSkip];
    }
    
    if (_nextLeft) {
        
        params[@"length"]=@(-0.1);
        params[@"command"]=@(7);
        [self sendCmdNotSkip];
        
    }
    
    if (_nextCenter) {
        
        params[@"length"]=@(-0.1);
        params[@"command"]=@(7);
        [self sendCmdNotSkip];
        
    }
}
//向下移动1mm
- (IBAction)downRemoveOne:(UIButton *)sender {
    if (_nextTrail) {
        
        params[@"length"]=@(-1);
        params[@"command"]=@(7);
        [self sendCmdNotSkip];
        
    }
    
    if (_nextRight) {
        
        params[@"length"]=@(-1);
        params[@"command"]=@(7);
        [self sendCmdNotSkip];
    }
    
    if (_nextLeft) {
        
        params[@"length"]=@(-1);
        params[@"command"]=@(7);
        [self sendCmdNotSkip];
        
    }
    
    if (_nextCenter) {
        
        params[@"length"]=@(-1);
        params[@"command"]=@(7);
        [self sendCmdNotSkip];
        
    }

    
}
//向上移动1mm
- (IBAction)upwardRemoveOne:(UIButton *)sender {
    if (_nextTrail) {
        
        params[@"length"]=@(1);
        params[@"command"]=@(7);
        [self sendCmdNotSkip];
    }
    
    if (_nextRight) {
        
        params[@"length"]=@(1);
        params[@"command"]=@(7);
        [self sendCmdNotSkip];
        
    }
    
    if (_nextLeft) {
        
        params[@"length"]=@(1);
        params[@"command"]=@(7);
        [self sendCmdNotSkip];
        
    }
    
    if (_nextCenter) {
        
        params[@"length"]=@(1);
        params[@"command"]=@(7);
        [self sendCmdNotSkip];
        
    }
    
}

-(void)sendCmdNotSkip{
     params[@"printerId"]=_printerId;
    [cmdModel FetchTMXAccountPrinterCommandData:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            
            [MBProgressHUD showSuccess:@"success"];

        }else{
             [MBProgressHUD showError:result];
        }
        
    }];
}


//打印机指令
-(void)sendCmd{
    
    params[@"printerId"]=_printerId;
    NSLog(@">>>>>打印机参数>>>>>%@",params);
    
    WS(weakSelf);
    [cmdModel FetchTMXAccountPrinterCommandData:params callBack:^(BOOL isSuccess, id result) {
        
        if (isSuccess)
        {
            [MBProgressHUD showSuccess:@"success"];
            
            if (_isHidden) {
                
                TMXMovePaperLocationVC *tMXMovePaperLocationVC=[[TMXMovePaperLocationVC alloc]init];
                tMXMovePaperLocationVC.nextCenter=YES;
                tMXMovePaperLocationVC.printerId=_printerId;
                [weakSelf.navigationController pushViewController:tMXMovePaperLocationVC animated:YES];
                
            }else if (_nextCenter){
                
                TMXMovePaperLocationVC *tMXMovePaperLocationVC=[[TMXMovePaperLocationVC alloc]init];
                tMXMovePaperLocationVC.nextLeft=YES;
                tMXMovePaperLocationVC.printerId=_printerId;
                [weakSelf.navigationController pushViewController:tMXMovePaperLocationVC animated:YES];
                
            }else if (_nextLeft){
                
                TMXMovePaperLocationVC *tMXMovePaperLocationVC=[[TMXMovePaperLocationVC alloc]init];
                tMXMovePaperLocationVC.nextRight=YES;
                tMXMovePaperLocationVC.printerId=_printerId;
                [weakSelf.navigationController pushViewController:tMXMovePaperLocationVC animated:YES];
                
            }else if (_nextRight){
                
                TMXMovePaperLocationVC *tMXMovePaperLocationVC=[[TMXMovePaperLocationVC alloc]init];
                tMXMovePaperLocationVC.nextTrail=YES;
                tMXMovePaperLocationVC.printerId=_printerId;
                [weakSelf.navigationController pushViewController:tMXMovePaperLocationVC animated:YES];
                
            }else if (_nextTrail){
                
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                
            }else if (_isPop){
                
                [weakSelf.navigationController popViewControllerAnimated:YES];
                
            }else{
                
            }
            
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}


#pragma mark <getter setter>
//隐藏调频按钮
-(void)setIsHidden:(BOOL)isHidden{
    _isHidden=isHidden;
}

-(void)setNextTrail:(BOOL)nextTrail{
    _nextTrail=nextTrail;
}

-(void)setNextRight:(BOOL)nextRight{
    _nextRight=nextRight;
}

-(void)setNextLeft:(BOOL)nextLeft{
    _nextLeft=nextLeft;
}

-(void)setNextCenter:(BOOL)nextCenter{
    _nextCenter=nextCenter;
}

-(void)setPrinterId:(NSString *)printerId{
    _printerId=printerId;
}

@end
