//
//  KBSegmentView.h
//  粗粮
//
//  Created by kobe on 16/5/18.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  KBSegmentViewDelegate<NSObject>

/** 回调选中的segmnet tag */
-(void)selectSegment:(NSInteger)index;

@end

@interface KBSegmentView : UIView

/** 文字颜色 */
@property(nonatomic,strong)UIColor *titleColor;
/** 按钮选中时候的文字颜色 */
@property(nonatomic,strong)UIColor *selectTitleColor;
/** 下划线的颜色 */
@property(nonatomic,strong)UIColor *bottomLineColor;
/** 文字大小 */
@property(nonatomic,strong)UIFont *titleFont;
/** 是否有竖线 */
@property(nonatomic,assign)BOOL isVerticleBar;
/** 传入一个数字选中哪一个 */
@property(nonatomic,assign)NSInteger selectNum;

@property(nonatomic,weak)id<KBSegmentViewDelegate>delegate;


/**
 *  创建segment
 *
 *  @param frame            传入frame
 *  @param segmentTitleArr  需要显示的segment的文字数组
 *  @param backgroundColor  segment的背景颜色
 *  @param titleColor       文字颜色
 *  @param selectTitleColor 选中时的文字颜色
 *  @param titleFont        文字大小
 *  @param bottomLineColor  下划线的颜色
 *  @param delegate         代理
 *  @param isVerticleBar    是否有竖线
 *  @return                 控件自己
 */
+(KBSegmentView *)createSegmentFrame:(CGRect)frame
                     segmentTitleArr:(NSArray *)segmentTitleArr
                     backgroundColor:(UIColor *)backgroundColor
                          titleColor:(UIColor *)titleColor
                    selectTitleColor:(UIColor *)selectTitleColor
                           titleFont:(UIFont *)titleFont
                     bottomLineColor:(UIColor *)bottomLineColor
                       isVerticleBar:(BOOL)isVerticleBar
                            delegate:(id)delegate;

@end
