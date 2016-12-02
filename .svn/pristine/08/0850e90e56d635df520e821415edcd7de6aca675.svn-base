//
//  TMXHomeJqueryHeaderView.m
//  TMX3DPrinter
//
//  Created by kobe on 16/8/25.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXHomeJqueryHeaderView.h"
#import "KBJquery.h"

@interface TMXHomeJqueryHeaderView ()<KBJqueryDelegate>
@property (nonatomic, strong) KBJquery *kBJquery;
@end

@implementation TMXHomeJqueryHeaderView

-(KBJquery *)kBJquery{
    if (!_kBJquery) {
        _kBJquery=[[KBJquery alloc]initWithFrame:self.frame];
        _kBJquery.duration=5;
        _kBJquery.isWebImage=YES;
        _kBJquery.delegate = self;
//        _kBJquery.imageArray=@[@"http://img15.3lian.com/2015/f1/18/d/88.jpg",@"http://img.taopic.com/uploads/allimg/121025/240425-12102520440152.jpg",@"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1211/14/c0/15757313_1352882611899.jpg"];
    }
    return _kBJquery;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.kBJquery];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    
    [_kBJquery mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - setter getter
-(void)setJqueryArray:(NSArray *)jqueryArray
{
    _jqueryArray = jqueryArray;
    _kBJquery.imageArray = jqueryArray;
}

#pragma mark - KBJqueryDelegate
-(void)clickScrollViewPage:(KBJquery *)kBJquery index:(NSInteger)index
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickJquery:)]) {
        [self.delegate clickJquery:index];
    }
}

@end
