//
//  EWFootRefresh.h
//  Fantasy
//
//  Created by wansy on 15/5/28.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EWFootRefresh : UIView

//@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *aiv;

+(instancetype)foot;

- (void)beginRefreshing;
- (void)endRefreshing;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (nonatomic, assign, getter = isRefreshing) BOOL refreshing;
@end
