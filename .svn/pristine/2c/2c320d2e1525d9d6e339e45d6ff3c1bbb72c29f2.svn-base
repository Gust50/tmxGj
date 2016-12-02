//
//  UITableViewCell+KBMasonryCellHeight.h
//  KBCacheTableViewHeight
//
//  Created by kobe on 16/9/22.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableView+KBCacheHeight.h"

typedef void(^cellBlock)(UITableViewCell *cell);   ///<配置cell
typedef NSDictionary*(^cacheHeight)();             ///<缓存cell的高度

/** 缓存cell高度字典的Key */
FOUNDATION_EXTERN NSString *const cacheUniqueKey;
/** cell不同状态下高度的Key */
FOUNDATION_EXTERN NSString *const cacheStateKey;
/** 是否需要重新计算cell高度的Key */
FOUNDATION_EXTERN NSString *const recalculateForStateKey;

@interface UITableViewCell (KBMasonryCellHeight)
@property (nonatomic, strong) UIView *lastviewInCell;
@property (nonatomic, assign) CGFloat bottomOffsetToCell;

/**
 *  计算cell的高度
 *
 *  @param tableView tableView
 *  @param config    配置cell
 *
 *  @return 计算的行高
 */
+(CGFloat)heightForTableView:(UITableView *)tableView
                      config:(cellBlock)config;

/**
 *  缓存cell的高度
 *
 *  @param tableView tableView
 *  @param config    配置cell
 *  @param cache     缓存cell的高度
 *
 *  @return 缓存cell的高度
 */
+(CGFloat)heightForTableView:(UITableView *)tableView
                      config:(cellBlock)config
                       cache:(cacheHeight)cache;

@end
