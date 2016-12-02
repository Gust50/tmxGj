//
//  TMXPrinterPromptView.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/8/26.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXPrinterPromptView.h"

@interface TMXPrinterPromptView()
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backViewLeft;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backViewRight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *titleHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contetLeft;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contentRight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *remarkHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *remarkWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cancelWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cancelHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cancelRight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cancelTop;


@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *content;
@property (strong, nonatomic) IBOutlet UIButton *goRemark;
@property (strong, nonatomic) IBOutlet UIImageView *cancel;



@end
@implementation TMXPrinterPromptView

//修改
- (void)modify
{
    self.backViewLeft.constant = 40*AppScale;
    self.backViewRight.constant = 40*AppScale;
    self.backViewHeight.constant = 200*AppScale;
    self.titleHeight.constant = 40*AppScale;
    self.contetLeft.constant = 20*AppScale;
    self.contentRight.constant = 20*AppScale;
    self.contentHeight.constant = 80*AppScale;
    self.remarkHeight.constant = 30*AppScale;
    self.remarkWidth.constant = 100*AppScale;
    self.cancelWidth.constant = 20*AppScale;
    self.cancelHeight.constant = 20*AppScale;
    self.cancelTop.constant = -5*AppScale;
    self.cancelRight.constant = -5*AppScale;
//    self.backView.layer.cornerRadius = 10*AppScale;
//    self.backView.layer.masksToBounds = YES;
    self.goRemark.layer.cornerRadius = 5*AppScale;
    self.goRemark.layer.masksToBounds = YES;
    self.goRemark.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
    self.content.font = [UIFont systemFontOfSize:12*AppScale];
    self.title.font = [UIFont systemFontOfSize:13*AppScale];
    
    self.cancel.layer.cornerRadius = 10*AppScale;
    self.cancel.layer.masksToBounds = YES;
    self.cancel.layer.borderWidth = 1;
    self.cancel.layer.borderColor = [UIColor whiteColor].CGColor;
    self.cancel.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelPrompt)];
    [self addGestureRecognizer:gesture];
    self.title.text = NSLocalizedString(@"Finish_Print", nil);
    [self.goRemark setTitle:NSLocalizedString(@"GoComment", nil) forState:UIControlStateNormal];
    self.content.text = NSLocalizedString(@"Finish_suc", nil);
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self modify];
    self.backgroundColor = RGBAColor(0, 0, 0, 0.7);
}

//去评论
- (IBAction)gocomment:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(goToRemark)]) {
        [self.delegate goToRemark];
    }
    [self removeFromSuperview];
}

//取消提示
- (void)cancelPrompt
{
    [self removeFromSuperview];
}
@end
