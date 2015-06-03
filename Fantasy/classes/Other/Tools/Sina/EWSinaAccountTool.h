//
//  EWAccountTool.h
//  新浪微博
//
//  Created by wansy on 15/4/8.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EWSinaAccount;
@interface EWSinaAccountTool : NSObject

+(void)save:(EWSinaAccount *)account;

+(EWSinaAccount *)account;
@end
