//
//  TMXSharePrinterVC.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/5.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXSharePrinterVC.h"
#import "TMXSharePrinterView.h"
#import "TMXSharePrinterModel.h"

@interface TMXSharePrinterVC ()<TMXSharePrinterViewDelegate>
{
    TMXSharePrinterModel *sharePrinterModel;        ///<二维码信息
    NSMutableDictionary *params;                    ///<参数
}

@property (nonatomic, strong)TMXSharePrinterView *sharePrinterView;
@end

@implementation TMXSharePrinterVC

#pragma mark - lazyLoad
-(TMXSharePrinterView *)sharePrinterView
{
    if (!_sharePrinterView) {
        _sharePrinterView = [[TMXSharePrinterView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64)];
        _sharePrinterView.delegate=self;
    }
    return _sharePrinterView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(237, 109, 0);
    [self.navigationItem setTitle:NSLocalizedString(@"SharePrinter", nil)];
    sharePrinterModel = [[TMXSharePrinterModel alloc] init];
    params = [NSMutableDictionary dictionary];
    
    [self.view addSubview:self.sharePrinterView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self enableOpenLeftDrawer:NO];
    [self loadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self enableOpenLeftDrawer:YES];
}

#pragma mark - setter getter
- (void)loadData
{
    params[@"printerId"] = @(self.printerId);
    [sharePrinterModel FetchTMXSharePrinterModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            sharePrinterModel = result;
            self.sharePrinterView.sharePrinterModel = sharePrinterModel;
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark <TMXSharePrinterViewDelegate>

-(void)saveQRCode:(UIImage *)QRCodeImg{
    UIAlertController *show=[UIAlertController alertControllerWithTitle:NSLocalizedString(@"MyQrCode", nil) message:NSLocalizedString(@"IsSave", nil) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm=[UIAlertAction actionWithTitle:NSLocalizedString(@"Confirm", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImageWriteToSavedPhotosAlbum(QRCodeImg, self, @selector(saveImage:didFinishSavingWithError:contextInfo:), NULL);
    }];
    
    UIAlertAction *cancel=[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    [show addAction:confirm];
    [show addAction:cancel];
    
    [self.navigationController presentViewController:show animated:YES completion:^{
        
    }];

}

-(void)saveImage:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error!=NULL) {
        
        [MBProgressHUD showError:NSLocalizedString(@"Save_Fail", nil)];
    }else{
        
        [MBProgressHUD showSuccess:NSLocalizedString(@"Save_Suc", nil)];
    }
}

#pragma mark - setter getter
-(void)setPrinterId:(NSInteger )printerId
{
    _printerId = printerId;
}

@end
