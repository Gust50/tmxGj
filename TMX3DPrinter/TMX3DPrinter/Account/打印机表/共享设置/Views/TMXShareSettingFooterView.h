//
//  TMXShareSettingFooterView.h
//  TMX3DPrinter
//
//  Created by arom on 16/8/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TMXShareSettingFooterViewDelegate <NSObject>

- (void)sharePrinter;

@end
@interface TMXShareSettingFooterView : UITableViewHeaderFooterView

@property (nonatomic, weak)id<TMXShareSettingFooterViewDelegate>delegate;

@end
