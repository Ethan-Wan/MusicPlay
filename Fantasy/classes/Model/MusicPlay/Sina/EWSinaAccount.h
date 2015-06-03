//
//  EWAccount.h
//  
//
//  Created by wansy on 15/4/8.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EWSinaAccount : NSObject <NSCoding>

/** String 当前授权用户的Id。*/
@property (nonatomic,copy) NSString *uid;

/** String 当前授权用户得到的accessToken。*/
@property (nonatomic,copy) NSString *access_token;

/** String 当前授权户用的生命周期。*/
@property (nonatomic,copy) NSString *expires_in;

/** NSDate 当前授权户用的过期时间。*/
@property (nonatomic,strong) NSDate *expires_time;

/** String 当前授权户用的昵称。*/
@property (nonatomic,copy) NSString *name;

+(instancetype) accountWithDict:(NSDictionary *)dict;
@end
