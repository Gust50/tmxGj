//
//  TMXPrinterTaskBar.h
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TMXPrinterTaskBarDelegate <NSObject>

- (void)clickTask:(NSInteger )tag;

@end
@interface TMXPrinterTaskBar : UIView

@property (nonatomic, weak)id<TMXPrinterTaskBarDelegate>delegate;

@end
