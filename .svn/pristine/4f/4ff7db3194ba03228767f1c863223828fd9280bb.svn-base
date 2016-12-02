//
//  TMXInformationFeedbackVC.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/6/8.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXInformationFeedbackVC.h"
#import "TMXAccountModel.h"

@interface TMXInformationFeedbackVC ()<UITextViewDelegate>
{
    UILabel *placeholderLabel;
    TMXAccountLoginModel *tMXAccountLoginModel;
}
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backViewTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backViewLeft;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backViewRiht;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sendTp;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sendHeiht;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *linkWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelTop;

@property (strong, nonatomic) IBOutlet UILabel *link;

@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet KBTextField *inputContactInfo;
@property (strong, nonatomic) IBOutlet UITextView *contentTextView;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;

@end

@implementation TMXInformationFeedbackVC

//修改属性
- (void)modify
{
    self.link.font = [UIFont systemFontOfSize:13*AppScale];
    self.inputContactInfo.font = [UIFont systemFontOfSize:12*AppScale];
    self.labelTop.constant = 50*AppScale;
    self.linkWidth.constant = 80*AppScale;
    self.sendTp.constant = 30*AppScale;
    self.sendHeiht.constant = 40*AppScale;
    self.backViewTop.constant = 64+30*AppScale;
    self.backViewLeft.constant =30*AppScale;
    self.backViewRiht.constant = 30*AppScale;
    self.backViewHeight.constant = 300*AppScale;
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 10.0;
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.borderWidth = 1.0;
    self.backView.layer.borderColor = RGBColor(192, 192, 192).CGColor;
    self.inputContactInfo.borderStyle = UITextBorderStyleNone;
    self.contentTextView.backgroundColor = [UIColor whiteColor];
    self.sendButton.layer.cornerRadius = 5.0;
    self.sendButton.layer.masksToBounds = YES;
    
    self.contentTextView.delegate = self;
    placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(5*AppScale, 5*AppScale, SCREENWIDTH-20, 20)];
    placeholderLabel.enabled = NO;
    placeholderLabel.textColor = RGBColor(227, 227, 229);
    placeholderLabel.text = NSLocalizedString(@"Content_input", nil);
    placeholderLabel.font = [UIFont systemFontOfSize:11*AppScale];
    placeholderLabel.hidden = NO;
    [self.contentTextView addSubview:placeholderLabel];
    self.link.text = NSLocalizedString(@"Contact", nil);
    self.inputContactInfo.placeholder = NSLocalizedString(@"Contact_input", nil);
    [self.sendButton setTitle:NSLocalizedString(@"Send", nil) forState:UIControlStateNormal];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self enableOpenLeftDrawer:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self enableOpenLeftDrawer:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self modify];
    [self.navigationItem setTitle:NSLocalizedString(@"Info_feedback", nil)];
    self.view.backgroundColor = backGroundColor;
    
    tMXAccountLoginModel=[[TMXAccountLoginModel alloc]init];
    
}

//发送
- (IBAction)setSend:(UIButton *)sender {
    
    [self.contentTextView resignFirstResponder];
    
    
    if ([self isValidateSuccess])
    {
        
        NSMutableDictionary *params=[NSMutableDictionary dictionary];
        params[@"contact"]=self.inputContactInfo.text;
        params[@"content"]=self.contentTextView.text;
        
        [tMXAccountLoginModel FetchTMXAccountFeedBackData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
            
            if (isSuccess) {
                [[MBProgressHUD showMessage:NSLocalizedString(@"Feedback_Suc", nil)]hide:YES afterDelay:0.5];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [MBProgressHUD showError:NSLocalizedString(@"Feedback_Fail", nil)];
            }
        }];
    }
   
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (self.contentTextView.text.length == 0) {
        placeholderLabel.hidden = NO;
    }else
    {
        placeholderLabel.hidden = YES;
    }
}

//设置textView的placeholder
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}


-(BOOL)isValidateSuccess{
    
    if (![KBRegexp checkPhoneNumInput:self.inputContactInfo.text]) {
        
        [MBProgressHUD showError:NSLocalizedString(@"Form_Error", nil)];
        return NO;
        
    }else if(self.contentTextView.text.length==0 && self.contentTextView.text==nil)
    {
        [MBProgressHUD showError:NSLocalizedString(@"Content_Null", nil)];
        return NO;
    }else{
        return YES;
    }
}
@end
