//
//  KBDragTableView.m
//  KBDragTableViewCell
//
//  Created by kobe on 16/9/23.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "KBDragTableView.h"

typedef enum{
    ROLL_TOP,
    ROLL_BOTTOM
}ROLL_DIRECTION;

@interface KBDragTableView ()

@property (nonatomic ,strong) UIView *snapShotView;
@property (nonatomic, strong) NSIndexPath *fromIndexPath;
@property (nonatomic, strong) NSIndexPath *toIndexPath;
@property (nonatomic, strong) CADisplayLink *autoRollTimer;
@property (nonatomic, assign) CGPoint fingerLocation;
@property (nonatomic, assign) ROLL_DIRECTION roll_dirction;

@end

@implementation KBDragTableView
@dynamic delegate;
@dynamic dataSource;

-(instancetype)init{
    if (self==[super init]) {
        //添加长按手势
        UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGestureRecognized:)];
        [self addGestureRecognizer:longPress];
    }
    return self;
}

-(void)longPressGestureRecognized:(UITapGestureRecognizer *)gesture{
    UIGestureRecognizerState longPressState=gesture.state;
    //手指在tableview的位置
    self.fingerLocation=[gesture locationInView:self];
    switch (longPressState) {
            //手势开始截图
        case UIGestureRecognizerStateBegan:{
            self.fromIndexPath=[self indexPathForRowAtPoint:_fingerLocation];
            if (_fromIndexPath) {
                [self selectCellAtIndexPath:_fromIndexPath];
            }
             break;
        }
           
        case UIGestureRecognizerStateChanged:{
            CGPoint center=_snapShotView.center;
            center.y=_fingerLocation.y;
            _snapShotView.center=center;
            if ([self checkRoolDirectionEdge]) {
                [self startRollTimer];
            }else{
                [self stopRollTimer];
            }
            _toIndexPath=[self indexPathForRowAtPoint:_fingerLocation];
            if (_toIndexPath && ![_toIndexPath isEqual:_fromIndexPath]) {
                [self cellToIndexPath:_toIndexPath];
            }
            break;
        }
            
            
        default:{
            [self stopRollTimer];
            [self didEndDraging];
             break;
        }
           
    }
}

-(void)updateDataSource{
    NSMutableArray *tempArr=[NSMutableArray array];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(originalDataSource:)]) {
        [tempArr addObjectsFromArray:[self.dataSource originalDataSource:self]];
    }
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(touchEndMoving:fromIndexPath:toIndexPath:)]) {
        [self.delegate touchEndMoving:self fromIndexPath:_fromIndexPath toIndexPath:_toIndexPath];
    }
    
    if ([self checkArrayIsNest:tempArr]) {
        if (_fromIndexPath.section==_toIndexPath.section) {
            [self moveObjectInMutableArray:tempArr fromIndexr:_fromIndexPath.row toIndex:_toIndexPath.row];
        }else{
            id originalObjc=tempArr[_fromIndexPath.section][_fromIndexPath.row];
            [tempArr[_toIndexPath.section]insertObject:originalObjc atIndex:_toIndexPath.row];
            [tempArr[_fromIndexPath.section]removeObjectAtIndex:_fromIndexPath.row];
        }
    }else{
        [self moveObjectInMutableArray:tempArr fromIndexr:_fromIndexPath.row toIndex:_toIndexPath.row];
    }
    
    if ([self.delegate respondsToSelector:@selector(tableView:newDataSource:)]) {
        [self.delegate tableView:self newDataSource:tempArr];
    }
}


-(void)moveObjectInMutableArray:(NSMutableArray *)array
                     fromIndexr:(NSInteger)fromInex
                        toIndex:(NSInteger)toIndex{
    if (fromInex<toIndex) {
        for (NSInteger i=fromInex; i<toIndex; i++) {
            [array exchangeObjectAtIndex:i withObjectAtIndex:i+1];
        }
    }else{
        for (NSInteger i=fromInex; i>toIndex; i--) {
            [array exchangeObjectAtIndex:i withObjectAtIndex:i-1];
        }
    }
}

-(BOOL)checkArrayIsNest:(NSArray *)array{
    for (id obj in array) {
        if ([obj isKindOfClass:[NSArray class]]) {
            return YES;
        }
    }
    return NO;
}
/**
 *  选中当前cell
 *
 *  @param indexPath 当前cell的索引
 */
-(void)selectCellAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[self cellForRowAtIndexPath:indexPath];
    UIView *tempView=[self customSnapShotFromView:cell];
    [self addSubview:tempView];
    self.snapShotView=tempView;
    cell.hidden=YES;
    CGPoint center=_snapShotView.center;
    center.y=_fingerLocation.y;
    [UIView animateWithDuration:0.2 animations:^{
        _snapShotView.transform=CGAffineTransformMakeScale(1.03, 1.03);
        _snapShotView.alpha=0.98;
        _snapShotView.center=center;
    }];
}

/**
 *  截图
 *
 *  @param view 传入当前触摸cell的视图view
 *
 *  @return 返回一个view
 */
-(UIView *)customSnapShotFromView:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIView *tempView=[[UIImageView alloc]initWithImage:image];
    tempView.center=view.center;
    tempView.layer.masksToBounds=NO;
    tempView.layer.cornerRadius=0.0;
    tempView.layer.shadowOffset=CGSizeMake(-5.0, 0.0);
    //阴影半径
    tempView.layer.shadowRadius=5.0;
    //阴影透明度
    tempView.layer.shadowOpacity=0.4;
    return tempView;
}

/**
 *  检测截图滑动是否到达顶部和底部
 *
 *  @return BOOL
 */
-(BOOL)checkRoolDirectionEdge{
    CGFloat minY=CGRectGetMinY(_snapShotView.frame);
    CGFloat maxY=CGRectGetMaxY(_snapShotView.frame);
    if (minY<self.contentOffset.y) {
        self.roll_dirction=ROLL_TOP;
        return YES;
    }
    if (maxY>self.bounds.size.height+self.contentOffset.y) {
        self.roll_dirction=ROLL_BOTTOM;
        return YES;
    }
    return NO;
}

/**
 *  开始定时器
 */
-(void)startRollTimer{
    if (!_autoRollTimer) {
        _autoRollTimer=[CADisplayLink displayLinkWithTarget:self selector:@selector(autoScroll)];
        [_autoRollTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

/**
 *  结束定时器
 */
-(void)stopRollTimer{
    if (_autoRollTimer) {
        [_autoRollTimer invalidate];
        _autoRollTimer=nil;
    }
}


-(void)autoScroll{
    CGFloat pixelSpeed=4;
    //向下滚动
    if (_roll_dirction==ROLL_TOP) {
        if (self.contentOffset.y>0) {
            [self setContentOffset:CGPointMake(0, self.contentOffset.y-pixelSpeed)];
            _snapShotView.center=CGPointMake(_snapShotView.center.x, _snapShotView.center.y-pixelSpeed);
        }
        }else{
            if (self.contentOffset.y+self.bounds.size.height<self.contentSize.height) {
                [self setContentOffset:CGPointMake(0, _snapShotView.center.y+pixelSpeed)];
                _snapShotView.center=CGPointMake(_snapShotView.center.x, _snapShotView.center.y+pixelSpeed);
            }
        }
    self.toIndexPath=[self indexPathForRowAtPoint:_snapShotView.center];
    if (_toIndexPath && ![_toIndexPath isEqual:_fromIndexPath]) {
        
        [self cellToIndexPath:_toIndexPath];
    }
}

-(void)cellToIndexPath:(NSIndexPath *)indexPath{
    [self updateDataSource];
    [self moveRowAtIndexPath:_fromIndexPath toIndexPath:indexPath];
    _fromIndexPath=indexPath;
}

-(void)didEndDraging{
    UITableViewCell *cell=[self cellForRowAtIndexPath:_fromIndexPath];
    cell.hidden=NO;
    cell.alpha=0;
    [UIView animateWithDuration:0.2 animations:^{
        _snapShotView.center=cell.center;
        _snapShotView.alpha=0;
        _snapShotView.transform=CGAffineTransformIdentity;
        cell.alpha=1;
    }completion:^(BOOL finished) {
        cell.hidden=NO;
        [_snapShotView removeFromSuperview];
        _snapShotView=nil;
        _fromIndexPath=nil;
        _toIndexPath=nil;
    }];
}
@end
