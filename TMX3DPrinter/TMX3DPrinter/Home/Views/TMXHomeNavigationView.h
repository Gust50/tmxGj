//
//  TMXHomeNavigationView.h
//  TMX3DPrinter
//
//  Created by wutaobo on 16/8/29.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMXHomeNavigationView;

@protocol TMXHomeNavigationViewDelegate <NSObject>

-(void)selectModel:(TMXHomeNavigationView *)navView;
@end
@interface TMXHomeNavigationView : UIView

@property(nonatomic,weak)id<TMXHomeNavigationViewDelegate>delegate;

@end
