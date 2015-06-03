//
//  EWTDAccountTool.m
//  Fantasy
//
//  Created by wansy on 15/6/2.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWTDAccountTool.h"
#import "EWTDAccountResult.h"
#define EWAccountFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"TDAccount.data"]

@implementation EWTDAccountTool

//存储账号
+(void)save:(EWTDAccountResult *)account{
    //将对象存入文件(归档)
    [NSKeyedArchiver archiveRootObject:account toFile:EWAccountFilePath];
}
//得到账号
+(EWTDAccountResult *)account{
    //解挡
    EWTDAccountResult *account = [NSKeyedUnarchiver unarchiveObjectWithFile:EWAccountFilePath];
    return account;
}
@end
