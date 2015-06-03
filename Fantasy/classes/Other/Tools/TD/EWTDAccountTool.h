//
//  EWTDAccountTool.h
//  Fantasy
//
//  Created by wansy on 15/6/2.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EWTDAccountResult;

@interface EWTDAccountTool : NSObject

//存储账号
+(void)save:(EWTDAccountResult *)account;

//得到账号
+(EWTDAccountResult *)account;
@end
