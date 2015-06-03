//
//  EWDTMVCell.h
//  Fantasy
//
//  Created by wansy on 15/5/28.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EWMV;
@interface EWTDMVCell : UITableViewCell

/**
 *  初始化cell
 *
 *  @param tableView tableView
 *
 *  @return cell
 */
+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) EWMV *mv;
@end
