//
//  TMXPersonSelectSexVC.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/6/24.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXPersonSelectSexVC.h"
#import "TMXAccountProfileInfo.h"
#import "TMXSexCell.h"

@interface TMXPersonSelectSexVC ()<UITableViewDelegate, UITableViewDataSource>
{
    TMXAccountProfileInfo *profileInfoModel;    ///<修改个人信息数据模型
    NSMutableDictionary *params;    ///<传入参数
    BOOL select;    ///<判断是否选择
    NSString *sexType;
}
@property (nonatomic, strong) NSArray *sexArray;    ///<性别数组
@property (nonatomic, strong)UITableView *tableView;
@end


@implementation TMXPersonSelectSexVC
static NSString *ID = @"cell";

#pragma mark - lazyLoad
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor = backGroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSArray *)sexArray
{
    if (!_sexArray) {
        NSString *_man = NSLocalizedString(@"Man", nil);
        NSString *_woman = NSLocalizedString(@"Woman", nil);
        NSString *_confidentiality = NSLocalizedString(@"Confidentiality", nil);
        _sexArray = [NSArray arrayWithObjects:_man ,_woman, _confidentiality, nil];
    }
    return _sexArray;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self enableOpenLeftDrawer:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:NSLocalizedString(@"Update_sex", nil)];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TMXSexCell" bundle:nil] forCellReuseIdentifier:ID];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.scrollEnabled = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self enableOpenLeftDrawer:NO];
    if ([self.sexString isEqualToString:@"0"]) {
        
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        
    }else if([self.sexString isEqualToString:@"1"]){
        
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }else if([self.sexString isEqualToString:@"2"]){
        
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TMXSexCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[TMXSexCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.sex.text = self.sexArray[indexPath.row];
    if ([cell.sex.text isEqualToString:sexType]) {
        cell.selected = YES;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 10;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TMXSexCell *cell = (TMXSexCell *)[tableView cellForRowAtIndexPath:indexPath];
    [self loadData:[NSString stringWithFormat:@"%zi", indexPath.row]];
    cell.selected = YES;
}

#pragma mark- loadData
- (void)loadData:(NSString *)sex
{
    profileInfoModel = [[TMXAccountProfileInfo alloc] init];
    params = [NSMutableDictionary dictionary];
    params[@"gender"] = sex;
    [profileInfoModel FetchTMXAccountUpdateProfileInfoData:params callBack:^(BOOL isSuccess, id  _Nonnull result){
        if (isSuccess) {
            [MBProgressHUD showSuccess:NSLocalizedString(@"Modify_Suc", nil)];
        
            [self.tableView reloadData];
           [self.navigationController popViewControllerAnimated:YES];
            
        }else
        {
            [MBProgressHUD showError:NSLocalizedString(@"Modify_Fail", nil)];
        }
    }];
}

-(void)setSexString:(NSString *)sexString
{
    _sexString = sexString;
    if ([sexString isEqualToString:@"0"]) {
        sexType = NSLocalizedString(@"Man", nil);
    }else if ([sexString isEqualToString:@"1"]) {
        sexType = NSLocalizedString(@"Woman", nil);
    }else if ([sexString isEqualToString:@"2"]) {
        sexType = NSLocalizedString(@"Confidentiality", nil);
    }
}

@end
