//
//  TMXHomeHeaderView.h
//  TMX3DPrinter
//
//  Created by kobe on 16/8/25.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMXHomeCategoryModelListModel;
@class TMXHomeHeaderView;
@protocol TMXHomeHeaderViewDelegate <NSObject>

- (void)clickMoreModel:(NSInteger)categoryID name:(NSString *)name;

@end
@interface TMXHomeHeaderView : UICollectionReusableView

@property (nonatomic, weak)id<TMXHomeHeaderViewDelegate>delegate;

@property (nonatomic, strong)TMXHomeCategoryModelListModel *categoryModelListModel;     ///<分类模型列表
@end
