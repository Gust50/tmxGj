//
//  TMXUnBindCell.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/8/31.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXUnBindCell.h"

@interface TMXUnBindCell ()
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *view1Height;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *nameWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *nameRight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *managerLeft;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *managerHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *allRight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *allLeft;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomViewBttom;


@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *time;

@property (strong, nonatomic) IBOutlet UIButton *manager;
@property (strong, nonatomic) IBOutlet UIButton *all;

@end
@implementation TMXUnBindCell

- (void)modify
{
    self.bottomViewBttom.constant = -8*AppScale;
    self.managerLeft.constant = 40*AppScale;
    self.managerHeight.constant = 30*AppScale;
    self.allRight.constant = 40*AppScale;
    self.allLeft.constant = 25*AppScale;
    self.view1Height.constant = 40*AppScale;
    self.nameWidth.constant = 80*AppScale;
    self.nameRight.constant = 5*AppScale;
    self.nameLabel.font = [UIFont systemFontOfSize:13*AppScale];
    self.name.font = [UIFont systemFontOfSize:13*AppScale];
    self.time.font = [UIFont systemFontOfSize:13*AppScale];
    self.timeLabel.font = [UIFont systemFontOfSize:13*AppScale];
    self.manager.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
    self.all.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
    self.manager.layer.cornerRadius = 15*AppScale;
    self.manager.layer.masksToBounds = YES;
    self.all.layer.cornerRadius = 15*AppScale;
    self.all.layer.masksToBounds = YES;
    self.manager.backgroundColor = RGBColor(234, 97, 1);
    [self.manager setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.all.backgroundColor = [UIColor whiteColor];
    [self.all setTitleColor:RGBColor(234, 91, 1) forState:UIControlStateNormal];
    self.all.layer.borderColor = RGBColor(234, 97, 1).CGColor;
    self.all.layer.borderWidth = 1;
    self.nameLabel.text = NSLocalizedString(@"Definition", nil);
    self.timeLabel.text = NSLocalizedString(@"Add_time", nil);
    [self.manager setTitle:NSLocalizedString(@"Manager", nil) forState:UIControlStateNormal];
    [self.all setTitle:NSLocalizedString(@"All", nil) forState:UIControlStateNormal];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    [self modify];
}

//管理者解除/所有者解除
- (IBAction)removeManager:(UIButton *)sender {
    
    if (sender.tag == 1) {
        self.manager.backgroundColor = RGBColor(234, 97, 1);
        [self.manager setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.all.backgroundColor = [UIColor whiteColor];
        [self.all setTitleColor:RGBColor(234, 91, 1) forState:UIControlStateNormal];
        self.all.layer.borderColor = RGBColor(234, 97, 1).CGColor;
        self.all.layer.borderWidth = 1;
    }else
    {
        self.all.backgroundColor = RGBColor(234, 97, 1);
        [self.all setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.manager.backgroundColor = [UIColor whiteColor];
        [self.manager setTitleColor:RGBColor(234, 91, 1) forState:UIControlStateNormal];
        self.manager.layer.borderColor = RGBColor(234, 97, 1).CGColor;
        self.manager.layer.borderWidth = 1;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickUnbind:)]) {
        [self.delegate clickUnbind:sender.tag];
    }
}

#pragma mark - setter getter
-(void)setDate:(NSString *)date
{
    _date = date;
//    NSDate *tim = [[KBDateFormatter shareInstance]dateFromTimeInterval:([date doubleValue]/1000.0)];
//    _time.text = [NSDate caculatorTime:tim];
//    NSDate *date = [[KBDateFormatter shareInstance]dateFromTimeInterval:([profileListModel.updatedDate doubleValue]/1000.0)];
//    NSString *timeString = [[KBDateFormatter shareInstance] stringFromDate:date];
//    _timeLab.text = timeString;
    NSDate *dateStr = [[KBDateFormatter shareInstance]dateFromTimeInterval:([date doubleValue]/1000.0)];
    NSString *timeString = [[KBDateFormatter shareInstance] stringFromDate:dateStr];
    _time.text = timeString;
}

-(void)setPrinterName:(NSString *)printerName
{
    _printerName = printerName;
    _name.text = _printerName;
}

@end
