//
//  EWReviewCall.h
//  Fantasy
//
//  Created by wansy on 15/5/29.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EWReview.h"
@class EWReviewFrame;

@interface EWReviewCell : UITableViewCell

+(EWReviewCell *) cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) EWReviewFrame *reviewFrame;


@end
