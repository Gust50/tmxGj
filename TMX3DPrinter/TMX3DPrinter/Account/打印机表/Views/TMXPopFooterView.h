//
//  TMXPopFooterView.h
//  TMX3DPrinter
//
//  Created by arom on 16/8/26.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^removeBlock)();

@interface TMXPopFooterView : UITableViewHeaderFooterView

@property (nonatomic,strong)UIButton * headLabel;

@property (nonatomic,copy)removeBlock removeblock;

@end
