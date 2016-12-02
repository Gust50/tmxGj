//
//  KBLabel.m
//  粗粮
//
//  Created by kobe on 16/5/20.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "KBLabel.h"

@implementation KBLabel


//重写该方法
-(void)drawTextInRect:(CGRect)rect{
    
    [super drawTextInRect:rect];
    //字体的大小
    CGSize textSize=[[self text]sizeWithAttributes:@{NSFontAttributeName:_labelFont}];
    //实际字体的宽度
    CGFloat strikeWidth=textSize.width;
    //画线的大小
    CGRect lineRect;
    //画线起始坐标
    CGFloat origin_x;
    CGFloat origin_y;

    //判断字体的居中方式
    if ([self textAlignment]==NSTextAlignmentLeft) {
        origin_x=0;
    }else if ([self textAlignment]==NSTextAlignmentCenter){
        origin_x=(rect.size.width-strikeWidth)/2;
    }else{
         origin_x=rect.size.width-strikeWidth;
    }
    
    
    switch (_type) {
        case NoneLine:
            
            break;
        case topLine:
            origin_y=2;
            break;
            
        case middleLine:
            origin_y=rect.size.height/2;
            break;
            
        case bottomLine:
            origin_y=rect.size.height-2;
            break;
            
        default:
            break;
    }
    
    lineRect=CGRectMake(origin_x, origin_y, strikeWidth, 1);
    //绘制划线
    if (_type!=NoneLine) {
        CGContextRef context=UIGraphicsGetCurrentContext();
        CGFloat R,G,B,A;
        CGColorRef color=[_lineColor CGColor];
        size_t numComponents=CGColorGetNumberOfComponents(color);
        
        const CGFloat *components = CGColorGetComponents(color);
        if (numComponents==4) {
            R = components[0];
            G = components[1];
            B = components[2];
            A = components[3];
            CGContextSetRGBFillColor(context,R , G, B, A);
        }else if (numComponents==3){
            R = components[0];
            G = components[1];
            B = components[2];
            CGContextSetRGBFillColor(context, R, G, B, A);
        }
        
        CGContextFillRect(context, lineRect);
    }
    
}


-(void)setType:(KBLabelType)type{
    _type=type;
}

-(void)setLabelFont:(UIFont *)labelFont{
    _labelFont=labelFont;
}

-(void)setLineColor:(UIColor *)lineColor{
    
}
@end
