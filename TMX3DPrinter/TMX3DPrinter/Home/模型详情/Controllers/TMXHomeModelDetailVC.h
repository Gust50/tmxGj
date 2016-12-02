//
//  TMXHomeModelDetailVC.h
//  TMX3DPrinter
//
//  Created by kobe on 16/8/29.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXBaseVC.h"

@interface TMXHomeModelDetailVC : TMXBaseVC

@property (nonatomic, assign)BOOL isProfile;    ///<判断是否从我的跳转过来
@property (nonatomic, assign)NSInteger modelId; ///<传入模型id

@property (nonatomic ,assign)BOOL isModelOpen;  ///<传入模型是否公开

@end
