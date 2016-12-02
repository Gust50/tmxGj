//
//  UITableViewCell+KBMasonryCellHeight.m
//  KBCacheTableViewHeight
//
//  Created by kobe on 16/9/22.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "UITableViewCell+KBMasonryCellHeight.h"
#import "UITableView+KBCacheHeight.h"
#import <objc/runtime.h>

NSString *const cacheUniqueKey=@"cacheUniqueKey";
NSString *const cacheStateKey=@"cacheStateKey";
NSString *const recalculateForStateKey=@"recalculateForStateKey";
NSString *const cacheForTableViewKey=@"cacheForTableViewKey";

const void *lastViewInCellKey=@"lastViewInCellKey";
const void *bottomOffsetToCellKey=@"bottomOffsetToCellKey";


@implementation UITableViewCell (KBMasonryCellHeight)

+(CGFloat)heightForTableView:(UITableView *)tableView config:(cellBlock)config{
    UITableViewCell *cell=[tableView.reuseCells objectForKey:[[self class]description]];
    if (cell==nil) {
        cell=[[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [tableView.reuseCells setObject:cell forKey:[[self class]description]];
    }
    if (config) {
        config(cell);
    }
    return [cell caculatorHeightForTableView:tableView];
}

+(CGFloat)heightForTableView:(UITableView *)tableView
                      config:(cellBlock)config
                       cache:(cacheHeight)cache{
    if (cache) {
        //从字典中获取存储的Key值
        NSDictionary *cacheKeys=cache();
        NSString *key=cacheKeys[cacheUniqueKey];
        NSString *stateKey=cacheKeys[cacheStateKey];
        NSString *shouldUpdate=cacheKeys[recalculateForStateKey];
        
        //取出缓存cell的字典
        NSMutableDictionary *stateDict=tableView.cacheCellHeightDict[key];
        //获取cell不同状态下的高度
        NSString *cacheHeight=stateDict[stateKey];
        
        if (tableView==nil || tableView.cacheCellHeightDict.count==0 || shouldUpdate.boolValue || cacheHeight==nil) {
            CGFloat height=[self heightForTableView:tableView config:config];
            if (stateDict==nil) {
                stateDict=[NSMutableDictionary new];
                //存储缓存cell高度的字典
                tableView.cacheCellHeightDict[key]=stateDict;
            }
            //字典存储cell的高度
            [stateDict setObject:[NSString stringWithFormat:@"%lf",height] forKey:stateKey];
            return height;
        }else if (tableView.cacheCellHeightDict.count!=0 && cacheHeight!=nil && cacheHeight.integerValue!=0){
            return cacheHeight.floatValue;
        }
    }
    return [self heightForTableView:tableView config:config];
}


#pragma mark <private menthod>
-(CGFloat)caculatorHeightForTableView:(UITableView *)tableView{
    
    NSAssert(self.lastviewInCell!=nil, @"需要指定cell排列中的最后一个视图对象,不然无法计算cell的高度");
    [self layoutIfNeeded];
    CGFloat rowHeight=self.lastviewInCell.frame.size.height+self.lastviewInCell.frame.origin.y+self.bottomOffsetToCell;
    return rowHeight;
}


#pragma mark <getter setter>

-(void)setLastviewInCell:(UIView *)lastviewInCell{
    objc_setAssociatedObject(self, lastViewInCellKey, lastviewInCell, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIView *)lastviewInCell{
    return objc_getAssociatedObject(self, lastViewInCellKey);
}


-(void)setBottomOffsetToCell:(CGFloat)bottomOffsetToCell{
    objc_setAssociatedObject(self, bottomOffsetToCellKey, @(bottomOffsetToCell), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CGFloat)bottomOffsetToCell{
    NSNumber *valueObject=objc_getAssociatedObject(self, bottomOffsetToCellKey);
    if ([valueObject respondsToSelector:@selector(floatValue)]) {
        return valueObject.floatValue;
    }
    return 0.0;
}

@end
