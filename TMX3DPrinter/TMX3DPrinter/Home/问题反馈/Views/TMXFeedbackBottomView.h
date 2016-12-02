//
//  TMXFeedbackBottomView.h
//  TMX3DPrinter
//
//  Created by wutaobo on 16/9/18.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TMXFeedbackBottomViewDelegate <NSObject>

- (void)TMXFeedbackBottomView:(NSString *)content textField:(KBTextField *)textField;

@end
@interface TMXFeedbackBottomView : UIView

@property (nonatomic, weak)id<TMXFeedbackBottomViewDelegate>delegate;

@property (nonatomic, copy)NSString *placeholder;
@property (nonatomic, copy)NSString *btnContent;

@end
