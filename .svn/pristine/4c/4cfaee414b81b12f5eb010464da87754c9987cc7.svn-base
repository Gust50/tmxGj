//
//  TMXReplyBottomView.h
//  TMX3DPrinter
//
//  Created by kobe on 16/9/12.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMXReplyBottomView;
@protocol  TMXReplyBottomViewDelegate<NSObject>
-(void)replyContent:(NSString *)content textField:(KBTextField *)textField;
@end

@interface TMXReplyBottomView : UIView

@property (nonatomic, copy) NSString *placeholderContent;
@property (nonatomic, weak)id <TMXReplyBottomViewDelegate>delegate;
@property (nonatomic, assign) BOOL isFirstResponse;
@property (nonatomic, strong) TMXReplyBottomView *inputView;
@end
