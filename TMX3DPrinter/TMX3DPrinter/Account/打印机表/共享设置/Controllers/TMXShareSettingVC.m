//
//  TMXShareSettingVC.m
//  TMX3DPrinter
//
//  Created by arom on 16/8/29.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXShareSettingVC.h"
#import "TMXShareSettingCell.h"
#import "TMXPrinterHeadView.h"
#import "TMXShareSettingFooterView.h"
#import "TMXSharePrinterVC.h"

@interface TMXShareSettingVC ()<TMXShareSettingFooterViewDelegate, UITableViewDataSource ,UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation TMXShareSettingVC

static NSString * const shareSettingCellID = @"shareSettingCellID";
static NSString * const shareSettingHeadViewID = @"shareSettingHeadViewID";
static NSString * const shareSettingFooterViewID = @"shareSettingFooterViewID";

#pragma mark - lazyLoad
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = backGroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark -- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backGroundColor;
    [self.view addSubview:self.tableView];
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self enableOpenLeftDrawer:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self enableOpenLeftDrawer:YES];
}

#pragma mark -- init ui
- (void)initUI{

    [self.tableView registerClass:[TMXShareSettingCell class] forCellReuseIdentifier:shareSettingCellID];
    [self.tableView registerClass:[TMXPrinterHeadView class] forHeaderFooterViewReuseIdentifier:shareSettingHeadViewID];
    [self.tableView registerClass:[TMXShareSettingFooterView class] forHeaderFooterViewReuseIdentifier:shareSettingFooterViewID];
    self.navigationItem.title = @"分享设置";
    self.tableView.tableFooterView = [[UITableViewHeaderFooterView alloc] init];
    self.tableView.backgroundColor = RGBColor(228, 233, 234);
    self.view.backgroundColor = RGBColor(228, 233, 234);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44*AppScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    if (section == 1) {
        return 100*AppScale;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 44*AppScale;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    TMXPrinterHeadView * headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:shareSettingHeadViewID];
    if (!headView) {
        headView = [[TMXPrinterHeadView alloc] initWithReuseIdentifier:shareSettingHeadViewID];
    }
    
    if (section == 0) {
        headView.headLabel.text = @"*打印机共享总人数不能超过20人";
    }else{
    
        headView.headLabel.text = @"*二维码有效时间最长不超过120分钟，请尽快截图分享";
    }
    
    return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    TMXShareSettingFooterView * footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:shareSettingFooterViewID];
    if (!footerView) {
        footerView = [[TMXShareSettingFooterView alloc] initWithReuseIdentifier:shareSettingFooterViewID];
    }
    if (section == 1) {
        footerView.delegate = self;
        return footerView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TMXShareSettingCell * cell = [tableView dequeueReusableCellWithIdentifier:shareSettingCellID];
    if (!cell) {
        cell = [[TMXShareSettingCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:shareSettingCellID];
    }
    if (indexPath.section == 0) {
        cell.describLabel.text = @"共享人数：";
        cell.countLabel.text = @"人";
    }else{
    
        cell.describLabel.text = @"有效时间：";
        cell.countLabel.text = @"分钟";
    }
    return cell;
}

#pragma mark - TMXShareSettingFooterViewDelegate
-(void)sharePrinter
{
    TMXSharePrinterVC *shareVC = [[TMXSharePrinterVC alloc] init];
    [self.navigationController pushViewController:shareVC animated:YES];
}

@end
