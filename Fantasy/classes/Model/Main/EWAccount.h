//
//  EWAccount.h
//  Fantasy
//
//  Created by wansy on 15/5/25.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EWAccount : NSObject<NSCoding>
/**
 *  用户名
 */
@property (nonatomic,copy) NSString *userName;

/**
 *  密码
 */
@property (nonatomic,copy) NSString *passWord;

/**
 *  用户头像
 */
@property (nonatomic,copy) NSString *userIcon;


/**
 *  昵称
 */
@property (nonatomic,copy) NSString *nickName;

@end
