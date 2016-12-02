//
//  KBJquery.h
//  ClshUser
//
//  Created by kobe on 16/5/25.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KBJquery;

@protocol  KBJqueryDelegate<NSObject>

@optional
/** 点击scrollView 触发 */
-(void)clickScrollViewPage:(KBJquery *)kBJquery index:(NSInteger)index;
/** 点击下面的小圈点触发(一般不用这个方法) */
-(void)clickDot:(KBJquery *)kBJquery index:(NSInteger)index;

@end

@interface KBJquery : UIView

/** 图片数组 */
@property(nonatomic,strong)NSArray *imageArray;
/** 延时 */
@property(nonatomic,assign)NSTimeInterval duration;
/** 是否使用网络图片 */
@property(nonatomic,assign)BOOL isWebImage;
/** 选中圆点的颜色 */
@property(nonatomic,assign)UIColor *selectColor;
/** 未选中的颜色 */
@property(nonatomic,assign)UIColor *unselectColor;

@property(nonatomic,weak)id<KBJqueryDelegate>delegate;

@end
