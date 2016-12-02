//
//  TMXAddPrinterCell.h
//  TMX3DPrinter
//
//  Created by kobe on 16/9/22.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMXScanQRCodeModel;
@protocol  TMXAddPrinterCellDelegate<NSObject>
-(void)addPrinter;
@end

@interface TMXAddPrinterCell : UITableViewCell
@property (nonatomic, weak) id<TMXAddPrinterCellDelegate>delegate;

@property (nonatomic, strong)TMXScanQRCodeModel *model;

@end
