//
//  TMXHomeClassifyListVC.h
//  TMX3DPrinter
//
//  Created by wutaobo on 16/8/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXBaseVC.h"

@interface TMXHomeClassifyListVC : TMXBaseVC

@property (nonatomic, assign)NSInteger categoryId;      ///<传入分类id
@property (nonatomic, copy)NSString *name;             ///<传入标题
@end
