//
//  TMXHomeDisplayAdvertCell.m
//  TMX3DPrinter
//
//  Created by kobe on 16/8/25.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXHomeDisplayAdvertCell.h"

@interface TMXHomeDisplayAdvertCell ()
@property (nonatomic, strong) UIImageView *advertImg;

@end

@implementation TMXHomeDisplayAdvertCell

#pragma makr <lazyLoad>
-(UIImageView *)advertImg{
    if (!_advertImg) {
        _advertImg=[UIImageView new];
        _advertImg.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchImageView:)];
        [_advertImg addGestureRecognizer:tap];
        
    }
    return _advertImg;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.advertImg];
    [self updateConstraints];
}


-(void)touchImageView:(UITapGestureRecognizer *)gesture{
    
    if (self.showAdvertiseBlock) {
        self.showAdvertiseBlock(_categoryID);
    }
}

-(void)updateConstraints{
    [super updateConstraints];

    [_advertImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - setter getter
-(void)setAdvUrl:(NSString *)advUrl
{
    _advUrl = advUrl;
    [_advertImg sd_setImageWithURL:[NSURL URLWithString:advUrl] placeholderImage:nil];
}
-(void)setCategoryID:(NSInteger)categoryID{
    _categoryID=categoryID;
}

@end
