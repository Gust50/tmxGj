//
//  TMXPtintingSectionHeadView.h
//  TMX3DPrinter
//
//  Created by arom on 16/8/29.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TMXPtintingSectionHeadViewDelegate <NSObject>

- (void)showPrinterHistoryList;
- (void)refreshUI;

@end

@interface TMXPtintingSectionHeadView : UITableViewHeaderFooterView

@property (nonatomic,weak) id<TMXPtintingSectionHeadViewDelegate> delegate;
@end
