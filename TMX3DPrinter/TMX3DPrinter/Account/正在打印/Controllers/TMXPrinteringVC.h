//
//  TMXPrinteringVC.h
//  TMX3DPrinter
//
//  Created by wutaobo on 16/8/26.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMXPrinteringVC : TMXBaseVC
@property (nonatomic, copy) NSString *printerId;    ///<传入打印机ID
@property (nonatomic, strong) dispatch_source_t timer;
@end
