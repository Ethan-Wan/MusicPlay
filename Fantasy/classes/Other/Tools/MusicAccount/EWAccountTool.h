//
//  EWAccountTool.h
//  Fantasy
//
//  Created by wansy on 15/5/25.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EWAccount;

@interface EWAccountTool : NSObject
/**
 *  保存账号
 *
 *  @param account 账号信息
 */
+(void)save:(EWAccount *)account;
/**
 *  获取账号
 *
 *  @return 账号
 */
+(EWAccount *)account;
/**
 *  删除账号
 */
+(void)delectAccount;
/**
 *  修改账号
 */
+(void)modifyAccount:(EWAccount *)account;
/**
 *  添加帐号
 *
 *  @param account 帐号信息
 */
+(NSString *)addAccount:(EWAccount *)account;

/**
 *  检查账号
 *
 *  @param userName 用户名
 *  @param passWord 密码
 *
 *  @return 验证结果
 */
+(NSString *)checkAccountWithUserName:(NSString *)userName andPassWord:(NSString *)passWord;
@end
