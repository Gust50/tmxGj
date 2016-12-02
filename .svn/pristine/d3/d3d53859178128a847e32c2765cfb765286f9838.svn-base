//
//  TMXSelectWifiView.m
//  TMX3DPrinter
//
//  Created by kobe on 16/8/9.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXSelectWifiView.h"

@interface TMXSelectWifiView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *dataDict;
@end

@implementation TMXSelectWifiView
static NSString *const cellID=@"cellID";

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH-30, SCREENHEIGHT/2.5) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.backgroundColor=backGroundColor;
    }
    return _tableView;
}

-(NSMutableDictionary *)dataDict{
    if (!_dataDict) {
        _dataDict=[NSMutableDictionary dictionary];
    }
    return _dataDict;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=backGroundColor;
        [self initData];
    }
    return self;
}


-(void)initData{
    
    [self addSubview:self.tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    [_dataDict removeAllObjects];
    [self.dataDict addEntriesFromDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"saveWifi"]];
    NSLog(@"%@",_dataDict);
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataDict allKeys].count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.textLabel.text=[_dataDict allKeys][indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectWifiName:password:)]) {
        [self.delegate selectWifiName:[_dataDict allKeys][indexPath.row] password:[_dataDict allValues][indexPath.row]];
    }
}

@end
