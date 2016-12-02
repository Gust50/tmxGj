//
//  TMXUnbindViewController.m
//  TMX3DPrinter
//
//  Created by arom on 16/8/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXUnbindViewController.h"
#import "TMXUnBindCell.h"
#import "TMXUnbindListCell.h"
#import "TMXUnbindModel.h"

@interface TMXUnbindViewController ()<UITableViewDelegate, UITableViewDataSource, TMXUnBindCellDelegate>
{
    NSInteger selectTag;                ///<判断是否是解除管理者还是所有者
    
    TMXUnbindInfoModel *unbindInfoModel;///<解除打印机页面信息
    NSMutableDictionary *infoParams;
    
    TMXUnbindModel *unbindModel;        ///<绑定打印机解绑
    NSMutableDictionary *params;        ///<传入参数
    NSInteger printerShareID;           ///<共享者ID
}

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation TMXUnbindViewController
static NSString *const unbindID = @"TMXUnBindCell";
static NSString *const listID = @"TMXUnbindListCell";

#pragma mark - lazyLoad
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = backGroundColor;
    }
    return _tableView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self enableOpenLeftDrawer:NO];
    [self loadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self enableOpenLeftDrawer:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:NSLocalizedString(@"Remove_printer", nil)];
    self.view.backgroundColor = backGroundColor;
    [self.view addSubview:self.tableView];
    [self loadFooter];
    unbindModel = [[TMXUnbindModel alloc] init];
    params = [NSMutableDictionary dictionary];
    unbindInfoModel = [[TMXUnbindInfoModel alloc] init];
    infoParams = [NSMutableDictionary dictionary];
    
    selectTag = 1;
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"TMXUnBindCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:unbindID];
    [self.tableView registerClass:[TMXUnbindListCell class] forCellReuseIdentifier:listID];
}

#pragma mark - loadData
- (void)loadData
{
    infoParams[@"printerId"] = @(self.printerID);
    [unbindInfoModel FetchTMXUnbindInfoModel:infoParams callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            unbindInfoModel = result;
            [self.tableView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

- (void)loadFooter
{
    UIButton *confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(10*AppScale, 0, SCREENWIDTH-20*AppScale, 35*AppScale)];
    confirmBtn.backgroundColor = RGBColor(234, 97, 1);
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn setTitle:NSLocalizedString(@"Confirm", nil) forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
    confirmBtn.layer.cornerRadius = 5*AppScale;
    confirmBtn.layer.masksToBounds = YES;
    [confirmBtn addTarget:self action:@selector(confirmUnbind) forControlEvents:UIControlEventTouchUpInside];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 35*AppScale)];
    view.backgroundColor = backGroundColor;
    [view addSubview:confirmBtn];
    self.tableView.tableFooterView = view;
}

//确认解除绑定
- (void)confirmUnbind
{
    params[@"printerId"] = @(self.printerID);
    
    if (selectTag == 1) {
        params[@"ShareUserId"] = @(printerShareID);
        params[@"type"] = @(0);
        if (printerShareID > 0) {
            [unbindModel FetchTMXUnbindModel:params callBack:^(BOOL isSuccess, id result) {
                if (isSuccess) {
                    [MBProgressHUD showSuccess:result];
                    [self.navigationController popViewControllerAnimated:YES];
                }else
                {
                    [MBProgressHUD showError:result];
                }
            }];
            
        }else
        {
            [MBProgressHUD showError:NSLocalizedString(@"Select_ShareUser", nil)];
        }
    }else
    {
        [params removeObjectForKey:@"ShareUserId"];
        params[@"type"] = @(1);
        [unbindModel FetchTMXUnbindModel:params callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                [MBProgressHUD showSuccess:result];
                [self.navigationController popViewControllerAnimated:YES];
            }else
            {
                [MBProgressHUD showError:result];
            }
        }];
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (selectTag == 1) {
        return 2;
    }else
    {
        return 1;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (selectTag == 1) {
        if (section == 0) {
            return 1;
        }else
        {
            return unbindInfoModel.shareUsers.count;
        }
    }else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TMXUnBindCell *unBindCell = [tableView dequeueReusableCellWithIdentifier:unbindID];
    TMXUnbindListCell *listCell = [tableView dequeueReusableCellWithIdentifier:listID];
    if (!unBindCell) {
        unBindCell = [[TMXUnBindCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:unbindID];
    }
    unBindCell.delegate  = self;
    unBindCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!listCell) {
        listCell = [[TMXUnbindListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:listID];
    }
    listCell.selected = YES;
    
    listCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (selectTag == 1) {
        if (indexPath.section == 0) {
            unBindCell.printerName = unbindInfoModel.productName;
            unBindCell.date = unbindInfoModel.bindDate;
            return unBindCell;
        }else
        {
            listCell.listModel = unbindInfoModel.shareUsers[indexPath.row];
            return listCell;
        }
    }else
    {
        unBindCell.printerName = unbindInfoModel.productName;
        unBindCell.date = unbindInfoModel.bindDate;
        return unBindCell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectTag == 1) {
        if (indexPath.section == 0) {
            return 150*AppScale;
        }else
        {
            return 50*AppScale;
        }
    }else
    {
        return 150*AppScale;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (selectTag == 1) {
        if (section == 1) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 35*AppScale)];
            view.backgroundColor = [UIColor whiteColor];
            UILabel *describe = [[UILabel alloc] initWithFrame:CGRectMake(10*AppScale, 0, SCREENWIDTH-20*AppScale, 35*AppScale)];
            describe.font = [UIFont systemFontOfSize:11*AppScale];
            NSString *str = [NSString stringWithFormat:@"%ld", unbindInfoModel.shareUsersCount];
            NSString *com = NSLocalizedString(@"ComHave", nil);
            NSString *trans = NSLocalizedString(@"Trans", nil);
            describe.text = [NSString stringWithFormat:@"%@ %@ %@", com,str,trans];
            [NSString labelString:describe font:[UIFont systemFontOfSize:11*AppScale] range:NSMakeRange(com.length+1, str.length) color:systemColor];
            [view addSubview:describe];
            return view;
        }
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (selectTag == 2) {
        if (section == 0) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 30*AppScale)];
            view.backgroundColor = backGroundColor;
            UILabel *describe = [[UILabel alloc] initWithFrame:CGRectMake(10*AppScale, 10*AppScale, SCREENWIDTH-20*AppScale, 15*AppScale)];
            describe.textColor = RGBColor(151, 152, 152);
            describe.font = [UIFont systemFontOfSize:10*AppScale];
            describe.textAlignment = NSTextAlignmentCenter;
            describe.text = NSLocalizedString(@"Remove_dess", nil);
            [view addSubview:describe];
            return view;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10*AppScale;
    }else
    {
        return 35*AppScale;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (selectTag == 1) {
        if (section == 0) {
            return 10*AppScale;
        }else
        {
            return 30*AppScale;
        }
    }else
    {
        return 60*AppScale;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectTag == 1) {
        if (indexPath.section == 1) {
            TMXUnbindListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.selected = YES;
            TMXUnbindInfoListModel *listModel = [unbindInfoModel.shareUsers objectAtIndexCheck:indexPath.row];
            printerShareID = listModel.printerShareId;
        }
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectTag == 1) {
        if (indexPath.section == 1) {
            TMXUnbindListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.selected = NO;
        }
    }
}

#pragma mark - TMXUnBindCellDelegate
-(void)clickUnbind:(NSInteger)tag
{
    selectTag = tag;
    [self.tableView reloadData];
}

#pragma mark - setter getter
-(void)setPrinterID:(NSInteger)printerID
{
    _printerID = printerID;
}

@end
