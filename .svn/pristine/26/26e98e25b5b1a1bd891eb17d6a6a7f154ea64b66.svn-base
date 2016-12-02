//
//  KBTimer.m
//  ClshUser
//
//  Created by kobe on 16/6/6.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "KBTimer.h"
#import "KBLabel.h"

@implementation KBTimer

-(void)countDown:(UILabel *)lable{
    __block NSInteger timeout=119;
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    dispatch_source_t  _timer=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout<=0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置Label属性
                lable.text=NSLocalizedString(@"Get_code", nil);
                lable.userInteractionEnabled=YES;
                
            });
        }else{
            NSInteger seconds=timeout%120;
            NSString *strTime=[NSString stringWithFormat:@"%0.2ld",seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的显示界面
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                NSString *sen = NSLocalizedString(@"Resend", nil);
                lable.text=[NSString stringWithFormat:@"%@%@",strTime, sen];
                [UIView commitAnimations];
                lable.userInteractionEnabled=NO;
                timeout--;
            });
        }
    });
    dispatch_resume(_timer);
}

@end
