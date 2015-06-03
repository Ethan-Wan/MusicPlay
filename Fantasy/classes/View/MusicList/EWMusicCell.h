//
//  EWMusicCell.h
//  Fantasy
//
//  Created by wansy on 15/5/17.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EWMusic;

@interface EWMusicCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) EWMusic *music;
@end
