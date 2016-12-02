//
//  TMXPrinteringCell.h
//  TMX3DPrinter
//
//  Created by wutaobo on 16/6/12.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMXAccountPrintTaskListModel;

@protocol  TMXPrinteringCellDelegate<NSObject>

-(void)deletePrinterFile:(NSString *)fileID;
-(void)printerFile:(NSString *)fileID;


@end

@interface TMXPrinteringCell : UITableViewCell

@property (nonatomic, strong) TMXAccountPrintTaskListModel *listModel;
@property (nonatomic, weak) id<TMXPrinteringCellDelegate>delegate;

@property (nonatomic, assign) BOOL isHasTask; 
@end
