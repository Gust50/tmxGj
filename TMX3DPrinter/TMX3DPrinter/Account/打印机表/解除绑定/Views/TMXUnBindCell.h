//
//  TMXUnBindCell.h
//  TMX3DPrinter
//
//  Created by wutaobo on 16/8/31.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TMXUnBindCellDelegate <NSObject>

- (void)clickUnbind:(NSInteger)tag; ///<管理者解除还是所有者解除

@end
@interface TMXUnBindCell : UITableViewCell

@property (nonatomic, weak)id<TMXUnBindCellDelegate>delegate;

@property (nonatomic, copy)NSString *printerName;       ///<传入名称
@property (nonatomic, copy)NSString *date;              ///<传入时间

@end
