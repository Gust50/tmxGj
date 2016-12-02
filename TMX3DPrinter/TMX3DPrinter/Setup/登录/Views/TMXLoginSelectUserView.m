//
//  TMXLoginSelectUserView.m
//  TMX3DPrinterHD
//
//  Created by wutaobo on 2016/11/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXLoginSelectUserView.h"
#import "TMXLoginSelectUserCell.h"

@interface TMXLoginSelectUserView ()<UITableViewDataSource,UITableViewDelegate, TMXLoginSelectUserCellDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableDictionary *dataDict;

@end

@implementation TMXLoginSelectUserView
static NSString *const selectUserID = @"TMXLoginSelectUserCell";

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH-60, SCREENHEIGHT/2.5) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

-(NSMutableDictionary *)dataDict
{
    if (!_dataDict) {
        _dataDict = [NSMutableDictionary dictionary];
    }
    return _dataDict;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initData];
    }
    return self;
}

- (void)initData
{
    [self addSubview:self.tableView];
    [self.tableView registerClass:[TMXLoginSelectUserCell class] forCellReuseIdentifier:selectUserID];
    [self.dataDict removeAllObjects];
    [self.dataDict addEntriesFromDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"]];
    NSLog(@"%@", _dataDict);
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataDict allKeys].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TMXLoginSelectUserCell *selectUserCell = [tableView dequeueReusableCellWithIdentifier:selectUserID forIndexPath:indexPath];
    selectUserCell.delegate = self;
    selectUserCell.userNameLab = [[_dataDict allKeys] objectAtIndexCheck:indexPath.row];
    return selectUserCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickUserName:)]) {
        [self.delegate clickUserName:[[_dataDict allKeys] objectAtIndexCheck:indexPath.row]];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeSelectUserView" object:nil];
}

#pragma mark <TMXLoginSelectUserCellDelegate>
-(void)clickDeleteAccount:(NSString *)user
{
    [self.dataDict removeObjectForKey:user];
    [[NSUserDefaults standardUserDefaults] setObject:self.dataDict forKey:@"userInfo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.tableView reloadData];
}

@end
