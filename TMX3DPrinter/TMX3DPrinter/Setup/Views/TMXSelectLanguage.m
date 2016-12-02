//
//  TMXSelectLanguage.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/10/26.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXSelectLanguage.h"
#import "TMXLanguageCell.h"
#import "TMXLanguageHeaderview.h"
#import "TMXLanguageFooterview.h"
#import "TMXLanguageModel.h"

@interface TMXSelectLanguage ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableview;
@property (nonatomic, strong) NSArray *languageArr;


@property (nonatomic, assign) BOOL isUpateHeader;
@property (nonatomic, assign) BOOL isUpdateFooter;

@end
@implementation TMXSelectLanguage
static NSString *const cellID = @"TMXLanguageCell";
static NSString *const headerID = @"TMXLanguageHeaderview";
static NSString *const footerID = @"TMXLanguageFooterview";


-(NSArray *)languageArr{
    if (!_languageArr) {
        
        //zh-Hans-US
        NSString *_chinese=NSLocalizedString(@"en-CH",nil);
        NSString *_english=NSLocalizedString(@"en-US",nil);
        
        NSArray *tempLanguageArr=@[_chinese,_english];
        NSArray *tempSetLanguageArr=@[@"zh-Hans",@"en"];
        
        NSMutableArray *tempModelArr=[NSMutableArray array];
        
        for (int i=0; i<tempLanguageArr.count; i++) {
            TMXLanguageModel *tempModel=[TMXLanguageModel new];
            tempModel.showName=tempLanguageArr[i];
            tempModel.setType=tempSetLanguageArr[i];
            [tempModelArr addObject:tempModel];
        }
        
//        _languageArr=@[_chinese,_english];
        _languageArr=[tempModelArr copy];
    }
    return _languageArr;
}
-(UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-190*AppScale, SCREENWIDTH, 190*AppScale) style:UITableViewStylePlain];
        _tableview.backgroundColor = backGroundColor;
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.showsVerticalScrollIndicator = NO;
    }
    return _tableview;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        [self addSubview:self.tableview];
        [self.tableview registerClass:[TMXLanguageCell class] forCellReuseIdentifier:cellID];
        [self.tableview registerClass:[TMXLanguageHeaderview class] forHeaderFooterViewReuseIdentifier:headerID];
        [self.tableview registerClass:[TMXLanguageFooterview class] forHeaderFooterViewReuseIdentifier:footerID];
        LRLog(@"----------输入语言选项-------->%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"AppleLanguages"][0]);
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.languageArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TMXLanguageCell *languageCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!languageCell) {
        languageCell = [[TMXLanguageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    TMXLanguageModel *tempModel=self.languageArr[indexPath.row];
    languageCell.languageType=tempModel.showName;
   
    
    NSString *code=[[NSUserDefaults standardUserDefaults]objectForKey:@"AppleLanguages"][0];
    if ([code hasPrefix:tempModel.setType]) {
         languageCell.isSelect=YES;
    }else{
        languageCell.isSelect=NO;
    }
    
    languageCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return languageCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50*AppScale;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TMXLanguageHeaderview *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    headView.isUpdate=_isUpateHeader;
    if (!headView) {
        headView = [[TMXLanguageHeaderview alloc] initWithReuseIdentifier:headerID];
    }
    headView.backgroundColor = [UIColor redColor];
    return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    TMXLanguageFooterview *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerID];
    footerView.isUpdate=_isUpdateFooter;
    if (!footerView) {
        footerView = [[TMXLanguageFooterview alloc] initWithReuseIdentifier:headerID];
    }
    WS(weakSelf);
    footerView.footerviewBlock = ^(){
        [weakSelf removeViewWithAnimation];
    };
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50*AppScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40*AppScale;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TMXLanguageCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = YES;
    
    TMXLanguageModel *tempModel=self.languageArr[indexPath.row];
    [NSBundle setLanguage:tempModel.setType];

//    [ShareApp setRootVC];
    [self saveLanguage:tempModel.setType];
    [self removeViewWithAnimation];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"SwitchLanguage" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"UpdateUI" object:nil userInfo:nil];
    
}

//设置语言
-(void)saveLanguage:(NSString *)setLanguage{
    
    [[NSUserDefaults standardUserDefaults] setObject:@[setLanguage] forKey:@"AppleLanguages"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self removeViewWithAnimation];
}


-(void)removeViewWithAnimation{
    
    self.backgroundColor=[UIColor clearColor];
    [UIView animateWithDuration:.5 animations:^{
        self.frame=CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, SCREENHEIGHT);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)setIsUpdate:(BOOL)isUpdate{
    _isUpdate=isUpdate;

    //zh-Hans-US
    NSString *_chinese=NSLocalizedString(@"en-CH",nil);
    NSString *_english=NSLocalizedString(@"en-US",nil);
    
    NSArray *tempLanguageArr=@[_chinese,_english];
    NSArray *tempSetLanguageArr=@[@"zh-Hans",@"en"];
    
    NSMutableArray *tempModelArr=[NSMutableArray array];
    
    for (int i=0; i<tempLanguageArr.count; i++) {
        TMXLanguageModel *tempModel=[TMXLanguageModel new];
        tempModel.showName=tempLanguageArr[i];
        tempModel.setType=tempSetLanguageArr[i];
        [tempModelArr addObject:tempModel];
    }
    
    //        _languageArr=@[_chinese,_english];
    _languageArr=[tempModelArr copy];
    
    self.isUpateHeader=YES;
    self.isUpdateFooter=YES;
    [_tableview reloadData];
}

@end
