//
//  KBtopImgBottomTextBtn.h
//  ClshMerchant
//
//  Created by kobe on 16/8/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KBtopImgBottomTextBtnDelegate <NSObject>
-(void)clickKBtopImgBottomTextBtn:(NSInteger)categoryID;
-(void)clickBtnName:(NSString *)name printerTaskID:(NSInteger)printerTaskID;
@end

@interface KBtopImgBottomTextBtn : UIView
@property (nonatomic, copy) NSString *iconUrl;         ///<imgUrl
@property (nonatomic, copy) NSString *nameContent;     ///<content
@property (nonatomic, strong) UIColor *textColor;      ///<textColor
@property (nonatomic, strong) UIFont *textFont;        ///<textFont
@property (nonatomic, weak) id <KBtopImgBottomTextBtnDelegate>delegate;

@property (nonatomic, assign)BOOL isHomeIcon;           ///<判断是否是首页图标
@property (nonatomic, assign)NSInteger classifyID;      ///<传入分类ID
@property (nonatomic, assign)NSInteger printerTaskID;   ///<传入打印任务ID
@end
