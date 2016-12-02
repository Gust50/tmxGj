//
//  TMXLoginSelectUserCell.h
//  TMX3DPrinterHD
//
//  Created by wutaobo on 2016/11/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TMXLoginSelectUserCellDelegate <NSObject>

- (void)clickDeleteAccount:(NSString *)user;

@end
@interface TMXLoginSelectUserCell : UITableViewCell

@property (nonatomic, weak)id<TMXLoginSelectUserCellDelegate>delegate;
@property (nonatomic, copy)NSString *userNameLab;
@end
