//
//  TMXPersonInformationVC.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/6/8.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXPersonInformationVC.h"
#import "TMXPersonInfoIconCell.h"
#import "AppDelegate.h"
#import "TMXHomeVC.h"
#import "KBNavigationVC.h"
#import "TMXAccountProfileInfo.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "TMXPersonMyNickNameVC.h"
#import "TMXPersonSelectSexVC.h"

@interface TMXPersonInformationVC ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    TMXAccountProfileInfo *accountProfileInfo;  ///<获取个人信息数据模型
    TMXAccountUploadImageModel * uploadImageModel;///<上传图片模型
    UIImagePickerController *_imagePicker;
    UIImage * iconImage;//touxiang
}

@property (nonatomic, strong)NSArray *leftArray;

@end

static NSString *const ID = @"cell";
static NSString *const iconID = @"TMXPersonInfoIconCell";

@implementation TMXPersonInformationVC

#pragma mark-lazyLoad
-(NSArray *)leftArray
{
    if (!_leftArray) {
        NSString *_nickName = NSLocalizedString(@"NickName", nil);
        NSString *_sex = NSLocalizedString(@"Sex", nil);
        NSString *_date = NSLocalizedString(@"Date", nil);
        NSString *_signature = NSLocalizedString(@"Signature", nil);
        NSString *_phoneNum = NSLocalizedString(@"PhoneNum", nil);
        _leftArray = @[_nickName, _sex, _date, _signature, _phoneNum];
    }
    return _leftArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:NSLocalizedString(@"Person_info", nil)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16*AppScale],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.tableView.backgroundColor = backGroundColor;
    iconImage = [UIImage imageNamed:@"1"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TMXPersonInfoIconCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:iconID];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
     self.navigationItem.leftBarButtonItem=[UIBarButtonItem normalImage:@"Return_white" selectImage:@"Return_white" target:self action:@selector(back)];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(234, 97, 1) colorWithAlphaComponent:1]];
    [self loadData];
}

#pragma mark <loadData>
- (void)loadData
{
    accountProfileInfo = [[TMXAccountProfileInfo alloc] init];
    uploadImageModel = [[TMXAccountUploadImageModel alloc] init];
    [accountProfileInfo FetchTMXAccountProfileInfoData:nil callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            accountProfileInfo = result;
            NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:accountProfileInfo.avatar]];
            iconImage = [UIImage imageWithData:data];
            [self.tableView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

-(void)back{
    
     [ShareApp.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
//    
//    TMXCenterVC *center=[[TMXCenterVC alloc]init];
//    KBNavigationVC *nav=[[KBNavigationVC alloc]initWithRootViewController:center];
//    [ShareApp.drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    TMXPersonInfoIconCell *infoIconCell = [tableView dequeueReusableCellWithIdentifier:iconID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.textLabel.textColor = RGBColor(84, 85, 86);
    cell.detailTextLabel.textColor = RGBColor(84, 85, 86);
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!infoIconCell) {
        infoIconCell = [[TMXPersonInfoIconCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iconID];
    }
    
    if (indexPath.row == 0) {
        infoIconCell.selectionStyle = UITableViewCellSelectionStyleNone;
        infoIconCell.icon.image = iconImage;
        return infoIconCell;
    }else if(indexPath.row == 1)
    {
        cell.textLabel.text = self.leftArray[0];
        if (accountProfileInfo.nickName == nil) {
            cell.detailTextLabel.text = NSLocalizedString(@"Write", nil);
        }else
        {
            cell.detailTextLabel.text = accountProfileInfo.nickName;
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if(indexPath.row == 2)
    {
        cell.textLabel.text = self.leftArray[1];
        if (accountProfileInfo.gender == nil) {
            cell.detailTextLabel.text = NSLocalizedString(@"Please_select", nil);
        }else if([accountProfileInfo.gender isEqualToString:@"0"])
        {
            cell.detailTextLabel.text = NSLocalizedString(@"Man", nil);
        }else if([accountProfileInfo.gender isEqualToString:@"1"])
        {
            cell.detailTextLabel.text = NSLocalizedString(@"Woman", nil);
        }else if([accountProfileInfo.gender isEqualToString:@"2"])
        {
            cell.detailTextLabel.text = NSLocalizedString(@"Confidentiality", nil);
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if(indexPath.row == 3)
    {
        cell.textLabel.text = self.leftArray[2];
        if (accountProfileInfo.birthDay == nil) {
            cell.detailTextLabel.text = NSLocalizedString(@"Please_select", nil);
        }else
        {
            cell.detailTextLabel.text = accountProfileInfo.birthDay;
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else if(indexPath.row == 4)
    {
        cell.textLabel.text = self.leftArray[3];
        if (accountProfileInfo.signature == nil) {
            cell.detailTextLabel.text = NSLocalizedString(@"Write", nil);
        }else
        {
            cell.detailTextLabel.text = accountProfileInfo.signature;
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (indexPath.row == 5) {
        cell.textLabel.text = self.leftArray[4];
        if (accountProfileInfo.mobile == nil) {
            cell.detailTextLabel.text = NSLocalizedString(@"NoBind", nil);
        }else
        {
            cell.detailTextLabel.text = accountProfileInfo.mobile;
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 60;
        }
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UIActionSheet *  sheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"SelectIcon", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Photograph", nil),NSLocalizedString(@"Photos", nil), nil];
            [sheet showInView:self.view];
        }else if (indexPath.row == 1)
        {
            TMXPersonMyNickNameVC *myNickName = [[TMXPersonMyNickNameVC alloc] init];
            myNickName.tag = 1;
            myNickName.name = accountProfileInfo.nickName;
            [self.navigationController pushViewController:myNickName animated:YES];
        }else if (indexPath.row == 2)
        {
            TMXPersonSelectSexVC *selectSex = [[TMXPersonSelectSexVC alloc] init];
            
            selectSex.sexString = accountProfileInfo.gender;
            
            [self.navigationController pushViewController:selectSex animated:YES];
        }
        else if (indexPath.row == 4)
        {
            TMXPersonMyNickNameVC *myNickName = [[TMXPersonMyNickNameVC alloc] init];
            myNickName.tag = 4;
            myNickName.name = accountProfileInfo.signature;
            [self.navigationController pushViewController:myNickName animated:YES];
        }
    }
}


#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 0) {
        [self initPickCameraPicker];
    }else if(buttonIndex == 1){
    
        [self initPickImagePicker];
    }
}

#pragma mark 调取系统相册
- (void)initPickImagePicker{

    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//数据来源，摄像头
    _imagePicker.allowsEditing = YES; //允许编辑
    _imagePicker.delegate = self; //设置代理，检测操作
    [self presentViewController:_imagePicker animated:YES completion:nil];
}

#pragma mark 调取系统相机
- (void)initPickCameraPicker{
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:^{
        
    }];//进入照相界面
}

#pragma marl UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    TMXPersonInfoIconCell * cell = [[TMXPersonInfoIconCell alloc] init];
    iconImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    cell.icon.image = iconImage;
    
    NSString * mediatype = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediatype isEqualToString:(NSString *)kUTTypeImage]) {//如果是拍照
        UIImage * orignalImage = nil;
        UIImage * cropImage = nil;
        if (_imagePicker.allowsEditing) {
            
            cropImage = [info objectForKey:UIImagePickerControllerEditedImage];//获取编辑后的照片
            UIImageWriteToSavedPhotosAlbum(cropImage, nil, nil, nil);//保存到相册
            iconImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
            cell.icon.image = iconImage;
            
        }else{
        
            orignalImage = [info objectForKey:UIImagePickerControllerOriginalImage];//获取原始照片
            UIImageWriteToSavedPhotosAlbum(orignalImage, nil, nil, nil);//保存到相册
            iconImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            cell.icon.image = iconImage;
        }
    }
    
    NSData * originImageDate = UIImageJPEGRepresentation(iconImage,0.5f);
    NSString * imgStr = [originImageDate base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"fileName"] = @"avatar.png";
    params[@"base64Data"] = imgStr;
    //执行长传头像的代码
    
    [uploadImageModel FetchTMXAccountIconData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            uploadImageModel = result;
            
            NSLog(@"----------------%@",uploadImageModel.url);
            [MBProgressHUD showSuccess:NSLocalizedString(@"Upload_Suc", nil)];
            NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:uploadImageModel.url]];
            iconImage = [UIImage imageWithData:data];
            //[self.tableView reloadData];
            [self updateData];
            
        }else{
        
            [MBProgressHUD showError:result];
        }
        
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
    
}

#pragma mark 更新数据
- (void)updateData{

    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"avatar"] = uploadImageModel.src;
    [accountProfileInfo FetchTMXAccountUpdateProfileInfoData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
//            [MBProgressHUD showSuccess:result];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateName" object:nil userInfo:nil];
            [self loadData];
        }else{
        
            [MBProgressHUD showError:result];
        }
    }];
}

@end
