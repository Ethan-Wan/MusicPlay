//
//  EWFootRefresh.m
//  Fantasy
//
//  Created by wansy on 15/5/28.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWFootRefresh.h"

@interface EWFootRefresh ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *aiv;
@end

@implementation EWFootRefresh

+ (instancetype) foot{
    return [[[NSBundle mainBundle] loadNibNamed:@"EWFootRefresh" owner:nil options:nil] lastObject];
}
- (void)beginRefreshing
{
    [self.aiv startAnimating];
    self.refreshing = YES;
}

- (void)endRefreshing
{
    [self.aiv stopAnimating];
    self.refreshing = NO;
}

@end
