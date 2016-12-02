//
//  TMXHomeScrollViewCell.h
//  TMX3DPrinter
//
//  Created by kobe on 16/8/25.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMXHomeModel;
@class TMXHomeScrollViewCell;
@protocol TMXHomeScrollViewCellDelegate <NSObject>

- (void)clickClassifyList:(NSInteger)categoryID;

@end
@interface TMXHomeScrollViewCell : UICollectionViewCell

@property (nonatomic, weak)id<TMXHomeScrollViewCellDelegate>delegate;

@property (nonatomic, strong)TMXHomeModel *homeModel; 

@end
