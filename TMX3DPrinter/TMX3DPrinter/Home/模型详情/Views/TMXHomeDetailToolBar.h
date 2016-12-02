//
//  TMXHomeDetailToolBar.h
//  TMX3DPrinter
//
//  Created by kobe on 16/8/29.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TMXHomeDetailToolBarDelegate<NSObject>
-(void)clickLikeBtn;
-(void)clickRemarkBtn;
-(void)clickFeedbackBtn;
@end

@interface TMXHomeDetailToolBar : UIView
@property (nonatomic, weak) id<TMXHomeDetailToolBarDelegate>delegate;
@property (nonatomic, strong) UIButton *feedBackBtn;

@property (nonatomic, assign)BOOL isLike;   ///<传入是否喜欢
@end
