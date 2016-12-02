//
//  TMXLeftHeaderView.h
//  TMX3DPrinterHD
//
//  Created by kobe on 16/8/19.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TMXLeftHeaderViewDelegate <NSObject>
-(void)clickLogin;
-(void)touchIcon;
@end

@interface TMXLeftHeaderView : UIView
@property (nonatomic, copy) NSString *iconUrl;
@property (nonatomic, copy) NSString *titleNameText;
@property (nonatomic, copy) NSString *subTitleNameText;
@property (nonatomic, copy) NSString *backGroundImgUrl;
@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, weak) id<TMXLeftHeaderViewDelegate>delegate;
@end
