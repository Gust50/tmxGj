//
//  TMXPrinteringCell.m
//  TMX3DPrinter
//
//  Created by wutaobo on 16/6/12.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "TMXPrinteringCell.h"
#import "TMXAccountPrintTaskModel.h"

@interface TMXPrinteringCell ()
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *deleteWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *deleteHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *printerWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *printerStateWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconRight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *timeLeft;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *deleteRight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *deleteLeft;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *printerLeft;


@property (strong, nonatomic) IBOutlet UILabel *fileName;
@property (strong, nonatomic) IBOutlet UILabel *fileSize;    ///<时间
@property (strong, nonatomic) IBOutlet UIButton *printerButton;
- (IBAction)deleteButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *printState;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@end

@implementation TMXPrinteringCell

//修改约束
- (void)modify
{
    self.iconRight.constant = 10*AppScale;
    self.timeLeft.constant = 5*AppScale;
    self.deleteRight.constant = 5*AppScale;
    self.deleteLeft.constant = 10*AppScale;
    self.printerLeft.constant = 10*AppScale;
    self.iconWidth.constant = 40*AppScale;
    self.iconHeight.constant = 40*AppScale;
    self.deleteWidth.constant = 25*AppScale;
    self.deleteHeight.constant = 25*AppScale;
    self.printerWidth.constant = 60*AppScale;
    self.printerStateWidth.constant = 40*AppScale;
    self.printerButton.layer.cornerRadius = 3.0;
    self.printerButton.layer.masksToBounds = YES;
    self.fileName.font = [UIFont systemFontOfSize:13*AppScale];
    self.fileSize.font = [UIFont systemFontOfSize:10*AppScale];
    self.printState.font = [UIFont systemFontOfSize:13*AppScale];
    self.printerButton.titleLabel.font = [UIFont systemFontOfSize:11*AppScale];
    [self.printerButton setTitle:NSLocalizedString(@"Print", nil) forState:0];
    self.printerButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5*AppScale);
//    [self.printerButton setBackgroundImage :[UIImage imageNamed:@"PrinteringIcon_white"] forState:0];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self modify];
    self.backgroundColor = [UIColor whiteColor];
    

}
- (IBAction)setPrinter:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(printerFile:)]) {
        [self.delegate printerFile:_listModel.fileRealName];
    }
}


- (IBAction)deleteButton:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(deletePrinterFile:)]) {
        [self.delegate deletePrinterFile:_listModel.fileName];
    }
    
}

-(void)setListModel:(TMXAccountPrintTaskListModel *)listModel{
    _listModel=listModel;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:listModel.fileImage] placeholderImage:nil];
    self.fileName.text=listModel.fileName;
    self.printState.text=listModel.status;
    
    //时间戳
    NSDate *date=[[KBDateFormatter shareInstance]dateFromTimeInterval:([listModel.latestPrintedDate doubleValue]/1000.0)];
    NSString *timeString=[[KBDateFormatter shareInstance]stringFromDate:date];
    self.fileSize.text=timeString;

}

-(void)setIsHasTask:(BOOL)isHasTask{
    _isHasTask=isHasTask;
    
    if (isHasTask) {
        
        self.deleteButton.userInteractionEnabled=NO;
        self.printerButton.userInteractionEnabled=NO;
        [self.printerButton setImage:[UIImage imageNamed:@"PrinteringIcon_white"] forState:0];
        self.printerButton.backgroundColor=[UIColor lightGrayColor];
        self.deleteButton.backgroundColor=[UIColor clearColor];
        [self.deleteButton setImage:[UIImage imageNamed:@"delete_white"] forState:0];
    }else{
        
        self.deleteButton.userInteractionEnabled=YES;
        self.printerButton.userInteractionEnabled=YES;
        [self.printerButton setImage:[UIImage imageNamed:@"PrinteringIcon_white"] forState:0];
        self.printerButton.backgroundColor=systemColor;
        self.deleteButton.backgroundColor=[UIColor clearColor];
        [self.deleteButton setImage:[UIImage imageNamed:@"HistoryDelete"] forState:0];
    }
    
}
@end
