//
//  EWMVResult.m
//  Fantasy
//
//  Created by wansy on 15/5/28.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWMVResult.h"
#import "EWMV.h"
#import "MJExtension.h"

@implementation EWMVResult

- (NSDictionary *)objectClassInArray
{
    return @{@"results" : [EWMV class]};
}
@end
