//
//  TMXSelectWifiView.h
//  TMX3DPrinter
//
//  Created by kobe on 16/8/9.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TMXSelectWifiViewDelegate <NSObject>
-(void)selectWifiName:(NSString *)name password:(NSString *)password;
@end
@interface TMXSelectWifiView : UIView
@property (nonatomic, weak) id<TMXSelectWifiViewDelegate>delegate;
@end
