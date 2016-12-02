//
//  TMXHomeDetailDescribeCell.h
//  TMX3DPrinter
//
//  Created by kobe on 16/8/26.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TMXHomeDetailDescribeCellDelegate <NSObject>

- (void)collectModel;

@end

@class TMXHomeModelDetailModel;
@interface TMXHomeDetailDescribeCell : UITableViewCell

@property (nonatomic, strong)TMXHomeModelDetailModel *detailModel;

@property (nonatomic, weak)id<TMXHomeDetailDescribeCellDelegate>delegate;

@end
