//
//  EWAccountTool.m
//  Fantasy
//
//  Created by wansy on 15/5/25.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWAccountTool.h"
#import "EWAccount.h"
#import "MJExtension.h"
#define EWAccountFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]
#define EWAccountsFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"accounts.plist"]

@implementation EWAccountTool

/**
 *  保存账号
 *
 *  @param account 账号信息
 */
+(void)save:(EWAccount *)account{
    //将对象存入文件(归档)
    [NSKeyedArchiver archiveRootObject:account toFile:EWAccountFilePath];
}
/**
 *  获取账号
 *
 *  @return 账号
 */
+(EWAccount *)account{
    //解挡
    EWAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:EWAccountFilePath];
    return account;
}
/**
 *  添加帐号
 *
 *  @param account 帐号信息
 */
+(NSString *)addAccount:(EWAccount *)account{
    //1.判断目录中文件是否存在，不存在就从mainBundle中复制过去
    [[[EWAccountTool alloc] init] copyFileIfNeed];
    
    //2.得到用户数组
    NSMutableArray *accounts = [[NSMutableArray alloc] initWithContentsOfFile:EWAccountsFilePath];
    
    //3.检查用户名是否存在
    for (int i = 0;i<accounts.count;i++) {
        NSDictionary *dict = accounts[i];
        if([[dict objectForKey:@"userName"] isEqualToString:account.userName]){
            return @"当前账号已存在";
        }
    }

    //4.将用新的账号信息放入数组
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:@[account.userName,account.userName,account.passWord,@""] forKeys:@[@"userName",@"nickName",@"passWord",@"userIcon"]];
    
    [accounts addObject:dic];
    
//    NSLog(@"%@",accounts);
    //5.将数组重新写到文件里
    [accounts writeToFile:EWAccountsFilePath atomically:YES];
    
    return SUCCESS;
}

/**
 *  删除账号
 */
+(void)delectAccount{
    NSFileManager* fileManager=[NSFileManager defaultManager];
    
    //删除account（这里就不判断有无文件了）
    [fileManager removeItemAtPath:EWAccountFilePath error:nil];
    
}
/**
 *  修改账号
 */
+(void)modifyAccount:(EWAccount *)account{
    //1.得到用户数组
    NSMutableArray *accounts = [[NSMutableArray alloc] initWithContentsOfFile:EWAccountsFilePath];
    
    //2.判断用户信息
    for (int i = 0;i<accounts.count;i++) {
        NSDictionary *dict = accounts[i];
        if([[dict objectForKey:@"userName"] isEqualToString:account.userName]){
            //3.移除该用户
            [accounts removeObjectAtIndex:i];
            
            //4.添加新用户
            NSDictionary *dic = [NSDictionary dictionaryWithObjects:@[account.userName,account.nickName,account.passWord,account.userIcon] forKeys:@[@"userName",@"nickName",@"passWord",@"userIcon"]];
            [accounts addObject:dic];
            
            //5.将数组重新写入文档
            [accounts writeToFile:EWAccountsFilePath atomically:YES];
            
            //6.归档
            [EWAccountTool save:account];
            return;
        }
    }
}
/**
 *  检查账号
 *
 *  @param userName 用户名
 *  @param passWord 密码
 *
 *  @return 验证结果
 */
+(NSString *)checkAccountWithUserName:(NSString *)userName andPassWord:(NSString *)passWord{
    //1.得到用户数组
    NSMutableArray *accounts = [[NSMutableArray alloc] initWithContentsOfFile:EWAccountsFilePath];
    
    //2.判断用户信息
    for (NSDictionary *account in accounts) {
        if([[account objectForKey:@"userName"] isEqualToString:userName]){
            if([[account objectForKey:@"passWord"] isEqualToString:passWord]){
                
                //3.归档
                EWAccount *account1 = [[EWAccount alloc] init];
                account1.userName = userName;
                account1.passWord = passWord;
                account1.nickName = [account objectForKey:@"nickName"];
                account1.userIcon = [account objectForKey:@"userIcon"];
                [EWAccountTool save:account1];
                
                return SUCCESS;
            }
            else {
                return @"密码错误";
            }
        }
    }
    return @"账号不存在";
}

#pragma mark - 私有方法
/**
 *  判断目录中文件是否存在，不存在就从mainBundle中复制过去
 */
-(void)copyFileIfNeed{
    NSFileManager *fileManage = [NSFileManager defaultManager];
    
    BOOL dbexits = [fileManage fileExistsAtPath:EWAccountsFilePath];
    // 如果没有文件则从mainBundle中复制过去
    if(!dbexits){
        NSString *defaultDBPath = [[NSBundle mainBundle] pathForResource:@"accounts.plist" ofType:nil];
        [fileManage copyItemAtPath:defaultDBPath toPath:EWAccountsFilePath error:nil];
    }
}


@end
