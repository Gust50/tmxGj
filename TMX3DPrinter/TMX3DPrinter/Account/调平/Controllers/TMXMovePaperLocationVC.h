//
//  TMXMovePaperLocationVC.h
//  TMX3DPrinter
//
//  Created by wutaobo on 16/6/12.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMXMovePaperLocationVC : TMXBaseVC

@property (nonatomic, assign) BOOL isHidden;
@property (nonatomic, assign) BOOL nextTrail; 
@property (nonatomic, assign) BOOL nextRight;
@property (nonatomic, assign) BOOL nextLeft;
@property (nonatomic, assign) BOOL nextCenter;
@property (nonatomic, copy) NSString *printerId;

@end
