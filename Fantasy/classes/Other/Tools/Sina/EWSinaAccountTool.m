//
//  EWAccountTool.m
//  新浪微博
//
//  Created by wansy on 15/4/8.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWSinaAccountTool.h"
#import "EWSinaAccount.h"
#define EWAccountFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"sinaAccount.data"]

@implementation EWSinaAccountTool
//存储账号
+(void)save:(EWSinaAccount *)account{
    //将对象存入文件(归档)
    [NSKeyedArchiver archiveRootObject:account toFile:EWAccountFilePath];
}
//得到账号
+(EWSinaAccount *)account{
    //解挡
    EWSinaAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:EWAccountFilePath];
    //判断账号是不是过期
    NSDate *now = [NSDate date];
    if([account.expires_time compare:now] != NSOrderedDescending){
        return nil;
    }
    return account;
}
@end
