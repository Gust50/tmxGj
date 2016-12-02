//
//  TMXHomeDisplayAdvertCell.h
//  TMX3DPrinter
//
//  Created by kobe on 16/8/25.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^showAdvertiseBlock)(NSInteger categoryID);

@interface TMXHomeDisplayAdvertCell : UICollectionViewCell

@property (nonatomic, copy)NSString *advUrl;    ///<传入广告
@property (nonatomic, copy) showAdvertiseBlock showAdvertiseBlock;
@property (nonatomic, assign) NSInteger categoryID;   ///<分类ID

@end
