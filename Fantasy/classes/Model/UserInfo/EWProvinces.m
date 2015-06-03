//
//  EWProvinces.m
//  Fantasy
//
//  Created by wansy on 15/6/1.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWProvinces.h"
#import "MJExtension.h"
#import "EWCities.h"

@implementation EWProvinces

- (NSDictionary *)objectClassInArray
{
    return @{@"cities" : [EWCities class]};
}

@end
