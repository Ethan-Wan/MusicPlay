//
//  EWBaseParam.m
//  新浪微博
//
//  Created by wansy on 15/4/19.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWBaseParam.h"
#import "EWSinaAccount.h"
#import "EWSinaAccountTool.h"

@implementation EWBaseParam

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.access_token = [EWSinaAccountTool account].access_token;
    }
    return self;
}

@end
