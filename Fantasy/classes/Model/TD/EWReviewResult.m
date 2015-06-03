//
//  EWReviewResult.m
//  Fantasy
//
//  Created by wansy on 15/5/29.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWReviewResult.h"
#import "EWReview.h"
#import "MJExtension.h"

@implementation EWReviewResult

- (NSDictionary *)objectClassInArray
{
    return @{@"results" : [EWReview class]};
}
@end
