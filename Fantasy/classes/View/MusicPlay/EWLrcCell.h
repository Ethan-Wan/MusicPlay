//
//  EWLrcCell.h
//  Fantasy
//
//  Created by wansy on 15/5/20.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EWLrcLine;

@interface EWLrcCell : UITableViewCell
/**
 *  初始化cell
 */
+(instancetype)cellWithTableView:(UITableView *)tableView;


@property (nonatomic,strong) EWLrcLine *lrcLine;
@end
