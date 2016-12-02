//
//  TMXHomeHeaderView.h
//  TMX3DPrinter
//
//  Created by kobe on 16/8/29.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TMXHomeModelHeaderViewDelegate <NSObject>

- (void)clickSelectPrinter;

@end
@interface TMXHomeModelHeaderView : UITableViewHeaderFooterView

@property (nonatomic, copy)NSString *iconUrl;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *subTitle;
@property (nonatomic, assign)BOOL isHideArrow;

@property (nonatomic, weak)id<TMXHomeModelHeaderViewDelegate>delegate;
@property (nonatomic, copy)NSString *leng;

@end
