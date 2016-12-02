//
//  TMXSharePrinterView.h
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/5.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMXSharePrinterModel;

@protocol TMXSharePrinterViewDelegate <NSObject>
-(void)saveQRCode:(UIImage *)QRCodeImg;
@end
@interface TMXSharePrinterView : UIView

@property (nonatomic, strong)TMXSharePrinterModel *sharePrinterModel;       ///<分享打印机模型
@property (nonatomic, weak) id<TMXSharePrinterViewDelegate>delegate;

@end
