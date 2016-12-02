//
//  TMXPopMenuView.m
//  TMX3DPrinter
//
//  Created by arom on 16/8/26.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXPopMenuView.h"
#import "TMXPopMenuHeadView.h"
#import "TMXPopFooterView.h"
#import "TMXPopMenuSelectTableViewCell.h"
#import "TMXPrinterListModel.h"

@interface TMXPopMenuView ()<UITableViewDelegate,UITableViewDataSource, TMXPopMenuSelectTableViewCellDelegate>
{
    TMXPrinterInfoModel *printerInfoModel;                    ///<打印机信息
    NSMutableDictionary *infoParams;                          ///<传入参数
    
    NSInteger printerID;        ///<打印机ID
    NSString *name;             ///<打印机名
    BOOL printerType;          ///<打印机类型
    NSInteger count;           ///<共享用户列表人数
    BOOL isHaveQrcode;        ///<判断是否创建了二维码
    NSString *state;           ///<打印机状态
    
    BOOL isDefault;
}

@property (nonatomic,strong)UITableView * tableView;

@end
@implementation TMXPopMenuView

static NSString * const PopMenuHeadaViewID = @"PopMenuHeadaViewID";
static NSString * const PopMenuTableViewCell = @"PopMenuTableViewCell";
static NSString * const PopMenuFooterViewID = @"PopMenuFooterViewID";
static NSString * const TMXPopMenuSelectViewID = @"TMXPopMenuSelectViewID";

#pragma mark -- 懒加载
- (UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-420*AppScale, SCREENWIDTH, 420*AppScale) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = backGroundColor;
        _tableView.scrollEnabled = NO;
    }
    
    return _tableView;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self == [super initWithFrame:frame]) {
        [self initUI];
        printerInfoModel = [TMXPrinterInfoModel new];
        infoParams = [NSMutableDictionary dictionary];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dealPrinter:) name:@"modifyPrinterState" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivePrinterID:) name:@"postPrinterID" object:nil];
        
    }
    return self;
}

//接受打印机ID
- (void)receivePrinterID:(NSNotification *)noti
{
    NSDictionary *dic = noti.userInfo;
    infoParams[@"printerId"] = dic[@"printerId"];
    [self loadPrinterInfoData];
}

-(void)dealPrinter:(NSNotification *)notification{
    NSDictionary *info=notification.userInfo;
    if ([info[@"isSuccess"] isEqualToString:@"YES"]) {
        isDefault = YES;
        
    }else if([info[@"isSuccess"] isEqualToString:@"NO"]){
        isDefault = NO;
    }else if([info[@"isSuccess"] isEqualToString:@"Fail"])
    {
        isDefault = !isDefault;
        [self.tableView reloadData];
    }
}

- (void)initUI{

    self.backgroundColor = backGroundColor;
    [self.tableView registerClass:[TMXPopMenuHeadView class] forHeaderFooterViewReuseIdentifier:PopMenuHeadaViewID];
    ;
    [self.tableView registerClass:[TMXPopMenuSelectTableViewCell class] forCellReuseIdentifier:TMXPopMenuSelectViewID];
    [self addSubview:self.tableView];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

//加载打印机信息数据
- (void)loadPrinterInfoData
{
    
    [printerInfoModel FetchTMXHigherSetupModel:infoParams callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            printerInfoModel = result;
            name = printerInfoModel.printerName;
            count = printerInfoModel.userCount;
            [self.tableView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (self.isSecondSection) {
        return 3;
    }else
    {
        return 8;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 40*AppScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 50*AppScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 50*AppScale;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    TMXPopMenuHeadView * headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:PopMenuHeadaViewID];
    if (!headView) {
        headView = [[TMXPopMenuHeadView alloc] initWithReuseIdentifier:PopMenuHeadaViewID];
    }
    headView.headLabel.text = name;
    return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    TMXPopFooterView * footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:PopMenuFooterViewID];
    if (!footerView) {
        footerView = [[TMXPopFooterView alloc] initWithReuseIdentifier:PopMenuFooterViewID];
    }
    footerView.removeblock = ^(){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:nil];
        [self removeViewWithAnimation];
    };
    return footerView;
}


-(void)removeViewWithAnimation{
    
    self.backgroundColor=[UIColor clearColor];
    [UIView animateWithDuration:.5 animations:^{
        self.frame=CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, SCREENHEIGHT);
    } completion:^(BOOL finished) {
         [self removeFromSuperview];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * const cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    TMXPopMenuSelectTableViewCell * selectCell = [tableView dequeueReusableCellWithIdentifier:TMXPopMenuSelectViewID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellID];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:13*AppScale];
    cell.textLabel.textColor = RGBColor(45, 45, 45);
    cell.detailTextLabel.font = [UIFont systemFontOfSize:11*AppScale];
    cell.detailTextLabel.textColor = RGBColor(143, 143, 143);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!selectCell) {
        selectCell = [[TMXPopMenuSelectTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:TMXPopMenuSelectViewID];
    }
    selectCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_isSecondSection) {
        
        if (indexPath.row == 0) {
            NSString *_name = NSLocalizedString(@"Name", nil);
            cell.textLabel.text = _name;
            cell.detailTextLabel.text = self.shareListModel.printerName;
        }else if (indexPath.row == 1){
            selectCell.isDefault = isDefault;
            selectCell.delegate = self;
            
            return selectCell;
        }else if (indexPath.row == 2){
            NSString *_remove = NSLocalizedString(@"Remove", nil);
            cell.textLabel.text = _remove;
            cell.detailTextLabel.text = @"";
        }
        return cell;
    }else{
    
        if (indexPath.row == 0) {
            NSString *_sharePrinter = NSLocalizedString(@"SharePrinter", nil);
            cell.textLabel.text = _sharePrinter;
            cell.detailTextLabel.text =@"";
        }else if (indexPath.row == 1){
            NSString *_shareUser = NSLocalizedString(@"ShareUser", nil);
            cell.textLabel.text = _shareUser;
            NSString *coun = NSLocalizedString(@"Several", nil);
            cell.detailTextLabel.text =[NSString stringWithFormat:@"%ld %@", count,coun];
        }else if (indexPath.row == 2){
            NSString *_printTask = NSLocalizedString(@"Print_Task", nil);
            cell.textLabel.text = _printTask;
            cell.detailTextLabel.text = @"";
        }else if (indexPath.row == 3){
            
            NSString *_name = NSLocalizedString(@"Name", nil);
            cell.textLabel.text = _name;
            cell.detailTextLabel.text = name;
        }else if (indexPath.row == 4){
            //设置默认打印机的属性
            selectCell.isDefault = isDefault;
            
            selectCell.delegate = self;
            return selectCell;
        }else if (indexPath.row == 5){
            NSString *_reset_Wifi = NSLocalizedString(@"Reset_Wifi", nil);
            cell.textLabel.text = _reset_Wifi;
            cell.detailTextLabel.text = @"";
        }else if (indexPath.row == 6){
            
            NSString *_remove = NSLocalizedString(@"Remove", nil);
            cell.textLabel.text = _remove;
            cell.detailTextLabel.text = @"";
        }else if (indexPath.row == 7){
            NSString *_advanced = NSLocalizedString(@"Advanced", nil);
            cell.textLabel.text = _advanced;
            cell.detailTextLabel.text = @"";
        }
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"%ld",indexPath.row);
    NSLog(@"---%d",_isSecondSection);
    if (!_isSecondSection) {
        switch (indexPath.row) {
            case 0:{
                if (self.delegate && [self.delegate respondsToSelector:@selector(goShareSettingVC:isCreateQR:)]) {
                    [self.delegate goShareSettingVC:printerID isCreateQR:isHaveQrcode];
                }
            }
                break;
            case 1:{
            
                if (self.delegate && [self.delegate respondsToSelector:@selector(goShareUserListVC:)]) {
                    [self.delegate goShareUserListVC:printerID];
                }
            }
                break;
            case 2:{
            
                if (self.delegate && [self.delegate respondsToSelector:@selector(goPrinterTaskListVC:)]) {
                    [self.delegate goPrinterTaskListVC:printerID];
                }
            }
                break;
            case 3:{
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(goUpdatePrinterName:name:printerType:)]) {
                    [self.delegate goUpdatePrinterName:printerID name:name printerType:printerType];
                }
            }
                break;
            case 5:{
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(goResetPrinterWifiVC:status:)]) {
                    [self.delegate goResetPrinterWifiVC:printerID status:state];
                }
            }
                break;
            case 6:{
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(unBindPrinter:isSecondView:)]) {
                    [self.delegate unBindPrinter:printerID isSecondView:NO];
                }
            }
                break;
            case 7:{
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(goAdvancedSetting:status:)]) {
                    [self.delegate goAdvancedSetting:printerID status:state];
                }
            }
                break;
            default:
                break;
        }
    }else
    {
        switch (indexPath.row) {
            case 0:{
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(goUpdatePrinterName:name:printerType:)]) {
                    [self.delegate goUpdatePrinterName:printerID name:self.shareListModel.printerName printerType:printerType];
                }
            }
                break;
            case 2:{
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(unBindPrinter:isSecondView:)]) {
                    [self.delegate unBindPrinter:printerID isSecondView:YES];
                }
            }
                break;
            default:
                break;
        }
    }
}

#pragma mark -TMXPopMenuSelectTableViewCellDelegate
-(void)clickTMXPopMenuSelectTableViewCellDelegate:(BOOL)isDefaut
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickSelectDefault:printerType:isDefault:)]) {
        [self.delegate clickSelectDefault:printerID printerType:printerType isDefault:isDefaut];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:nil];
    [self removeViewWithAnimation];
}

#pragma mark - setter getter
-(void)setIsSecondSection:(BOOL)isSecondSection
{
    _isSecondSection = isSecondSection;
    if (isSecondSection) {
        _tableView.frame = CGRectMake(0, SCREENHEIGHT-220*AppScale, SCREENWIDTH, 220*AppScale);
    }else
    {
         _tableView.frame = CGRectMake(0, SCREENHEIGHT-420*AppScale, SCREENWIDTH, 420*AppScale);
    }
    [self.tableView reloadData];
    
}

-(void)setBindModel:(TMXPrinterListListModel *)bindModel
{
    _bindModel = bindModel;
    printerID = bindModel.printerListID;
    printerType = bindModel.printerType;
    isDefault = bindModel.isDefault;
    isHaveQrcode = bindModel.isQrCode;
    state = bindModel.status;
    [_tableView reloadData];
}

-(void)setShareListModel:(TMXPrinterListShareListModel *)shareListModel
{
    _shareListModel = shareListModel;
    printerID = shareListModel.sharePrinterListID;
    printerType = shareListModel.printerType;
    isDefault = shareListModel.isDefault;
    state = shareListModel.status;
    [_tableView reloadData];
}

@end
