//
//  KBGuideViewController.h
//  TMX3DPrinter
//
//  Created by kobe on 16/9/21.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^startBtnBlock)();
typedef void(^skipBtnBlock)();

@interface KBGuideViewController : UIViewController
@property (nonatomic, strong) NSArray *guideImgArr;       ///<guide images array
@property (nonatomic, copy) startBtnBlock startBtnBlock;
@property (nonatomic, copy) skipBtnBlock skipBtnBlock;   ///<skip
@end
