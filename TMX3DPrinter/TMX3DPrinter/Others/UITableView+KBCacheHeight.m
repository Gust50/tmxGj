//
//  UITableView+KBCacheHeight.m
//  KBCacheTableViewHeight
//
//  Created by kobe on 16/9/22.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "UITableView+KBCacheHeight.h"
#import <objc/runtime.h>

static const void *tableview_cacheCellHeightKey=@"tableview_cacheCellHeightKey";
static const void *tableview_reuseCellKey=@"tableview_reuseCellKey";

@implementation UITableView (KBCacheHeight)

-(NSMutableDictionary *)cacheCellHeightDict{
    NSMutableDictionary *dict=objc_getAssociatedObject(self, tableview_cacheCellHeightKey);
    if (dict==nil) {
        dict=[NSMutableDictionary new];
        objc_setAssociatedObject(self,tableview_cacheCellHeightKey , dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dict;
}

-(NSMutableDictionary *)reuseCells{
    NSMutableDictionary *cells=objc_getAssociatedObject(self, tableview_reuseCellKey);
    if (cells==nil) {
        cells=[NSMutableDictionary new];
        objc_setAssociatedObject(self, tableview_reuseCellKey, cells, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return cells;
}

@end
