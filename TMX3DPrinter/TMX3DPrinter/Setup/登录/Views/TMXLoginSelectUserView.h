//
//  TMXLoginSelectUserView.h
//  TMX3DPrinterHD
//
//  Created by wutaobo on 2016/11/30.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TMXLoginSelectUserViewDelegate <NSObject>

- (void)clickUserName:(NSString *)name;

@end
@interface TMXLoginSelectUserView : UIView

@property (nonatomic, weak)id<TMXLoginSelectUserViewDelegate>delegate;

@end
