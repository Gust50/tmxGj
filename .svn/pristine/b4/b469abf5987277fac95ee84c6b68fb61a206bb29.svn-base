//
//  KBTextView.m
//  ClshMerchant
//
//  Created by kobe on 16/7/28.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "KBTextView.h"

@interface KBTextView ()
@property (nonatomic, strong) UILabel *placehoderLab;
@end

@implementation KBTextView

#pragma mark <lazyLoad>
-(UILabel *)placehoderLab{
    if (!_placehoderLab) {
        _placehoderLab=[UILabel new];
        _placehoderLab.numberOfLines=0;
        _placehoderLab.textColor=[UIColor lightTextColor];
    }
    return _placehoderLab;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self addSubview:self.placehoderLab];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledDidChange) name:UITextViewTextDidChangeNotification object:self];
        self.layer.borderColor=backGroundColor.CGColor;
        self.layer.borderWidth=1;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _placehoderLab.y=8;
    _placehoderLab.x=5;
    _placehoderLab.width=self.width-2*_placehoderLab.x;
    
    NSDictionary *dict=@{NSFontAttributeName : _placeHolderFont,NSForegroundColorAttributeName:[UIColor orangeColor]};
    CGSize size=[_placeHolder boundingRectWithSize:CGSizeMake(SCREENWIDTH-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading attributes:dict context:nil].size;
    _placehoderLab.height=size.height;
    _placehoderLab.textColor=[UIColor lightGrayColor];
}


#pragma mark <otherResponse>
-(void)textFiledDidChange{
    
    if (self.text.length==0) {
        _placehoderLab.hidden=NO;
    }else{
        _placehoderLab.hidden=YES;
    }
}

#pragma mark <getter setter>
-(void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder=[placeHolder copy];
    _placehoderLab.text=placeHolder;
    [self setNeedsLayout];
}

-(void)setPlaceHolderColor:(UIColor *)placeHolderColor{
    _placeHolderColor=placeHolderColor;
    _placehoderLab.textColor=placeHolderColor;
}

-(void)setPlaceHolderFont:(UIFont *)placeHolderFont{
    _placeHolderFont=placeHolderFont;
    _placehoderLab.font=placeHolderFont;
    [self setNeedsLayout];
}

#pragma mark <super>
-(void)setText:(NSString *)text{
    [super setText:text];
    [self textFiledDidChange];
}

@end
