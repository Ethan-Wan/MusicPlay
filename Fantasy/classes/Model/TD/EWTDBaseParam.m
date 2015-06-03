//
//  EWBaseParam.m
//  Fantasy
//
//  Created by wansy on 15/5/28.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWTDBaseParam.h"

@implementation EWTDBaseParam

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.app_key = EWAppKey;
    }
    return self;
}

@end
