//
//  KBDragTableView.h
//  KBDragTableViewCell
//
//  Created by kobe on 16/9/23.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KBDragTableView;

@protocol  KBDragTableViewDataSource<UITableViewDataSource>
@required
-(NSArray *)originalDataSource:(KBDragTableView *)tableView;
@end

@protocol KBDragTableViewDelegate <UITableViewDelegate>
@required
-(void)tableView:(KBDragTableView *)tableView newDataSource:(NSArray *)dataSource;
@optional
-(void)tableView:(KBDragTableView *)tableView touchBeginAtIndexPath:(NSIndexPath *)indexPath;
-(void)touchMoving:(KBDragTableView *)tableView;
-(void)touchEndMoving:(KBDragTableView *)tableView
        fromIndexPath:(NSIndexPath *)fromIndexPath
          toIndexPath:(NSIndexPath *)toIndexPath;
@end

@interface KBDragTableView : UITableView
@property (nonatomic ,weak) id<KBDragTableViewDataSource>dataSource;
@property (nonatomic, weak) id<KBDragTableViewDelegate>delegate;
@end
