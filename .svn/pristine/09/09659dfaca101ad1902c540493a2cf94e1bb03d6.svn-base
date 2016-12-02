//
//  TMXShareUserListViewController.m
//  TMX3DPrinter
//
//  Created by arom on 16/8/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXShareUserListViewController.h"
#import "TMXShareUserListCell.h"
#import "TMXPrinterHeadView.h"
#import "TMXShareUserListModel.h"

@interface TMXShareUserListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    TMXShareUserListModel *shareUesrModel;      ///<分享用户列表
    NSMutableDictionary *params;                ///<传入参数
    
    TMXRemoveShareUserModel *removeShareModel;  ///<分享着解绑自己下的共享者
    NSMutableDictionary *removeParams;
}

@property (nonatomic,strong)UITableView * tableView;

@end

@implementation TMXShareUserListViewController

static NSString * const shareUserListCellID = @"shareUserListCellID";
static NSString * const shareUserListHeadViewID = @"shareUserListHeadViewID";

#pragma mark -- 懒加载
- (UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+10*AppScale, SCREENWIDTH, SCREENHEIGHT-64-10*AppScale) style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGBColor(228, 233, 234);
        _tableView.tableFooterView = [[UITableViewHeaderFooterView alloc] init];
    }
    return _tableView;
}

#pragma mark -- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self enableOpenLeftDrawer:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self enableOpenLeftDrawer:YES];
}

#pragma mark -- init UI
- (void)initUI{

    self.navigationItem.title = NSLocalizedString(@"UserList", nil);
    self.view.backgroundColor = RGBColor(228, 233, 234);
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerClass:[TMXShareUserListCell class] forCellReuseIdentifier:shareUserListCellID];
    [self.tableView registerClass:[TMXPrinterHeadView class] forHeaderFooterViewReuseIdentifier:shareUserListHeadViewID];
    [self.view addSubview:self.tableView];
    
    shareUesrModel = [[TMXShareUserListModel alloc] init];
    params = [NSMutableDictionary dictionary];
    removeShareModel = [[TMXRemoveShareUserModel alloc] init];
    removeParams = [NSMutableDictionary dictionary];
}

#pragma mark - loadData
- (void)loadData
{
    params[@"printerId"] = @(self.printerId);
    [shareUesrModel FetchTMXShareUserListModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            shareUesrModel = result;
            [self.tableView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

- (void)loadRemoveShareData
{
    removeParams[@"userId"] = [FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
    [removeShareModel FetchTMXShareUserListModel:removeParams callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:result];
            [self loadData];
            
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark -- table view datasource delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return shareUesrModel.shareUsers.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44*AppScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 50*AppScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    TMXPrinterHeadView * headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:shareUserListHeadViewID];
    if (!headView) {
        headView = [[TMXPrinterHeadView alloc] initWithReuseIdentifier:shareUserListHeadViewID];
    }
    headView.listModel = shareUesrModel;
    
    headView.contentView.backgroundColor = [UIColor whiteColor];
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    TMXShareUserListCell * cell = [tableView dequeueReusableCellWithIdentifier:shareUserListCellID];
    if (!cell) {
        cell = [[TMXShareUserListCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:shareUserListCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.shareListModel = shareUesrModel.shareUsers[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

-(NSArray<UITableViewRowAction*>*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TMXShareUserListListModel *listModel = shareUesrModel.shareUsers[indexPath.row];
    
    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                         title:NSLocalizedString(@"Cancel", nil) handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                             removeParams[@"printerShareId"] = listModel.printerShareId;
                                                                             [self loadRemoveShareData];
                                                                             
                                                                         }];
    rowAction.backgroundColor = systemColor;
    
    NSArray *array = @[rowAction];
    return array;
}

#pragma mark - setter getter
-(void)setPrinterId:(NSInteger )printerId
{
    _printerId = printerId;
}

@end
