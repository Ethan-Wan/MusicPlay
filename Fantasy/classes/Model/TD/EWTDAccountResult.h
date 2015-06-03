//
//  EWTDAccountResult.h
//  Fantasy
//
//  Created by wansy on 15/6/2.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EWTDAccountResult : NSObject<NSCoding>

/**string	授权后生成的Token，用于调用授权接口的凭证*/
@property (nonatomic,copy) NSString *access_token;

/**string	授权后生成的Token，用于调用授权接口的凭证*/
@property (nonatomic,assign) int expires_in;

/**	int	土豆用户ID*/
@property (nonatomic,assign) int uid;
@end
