//
//  EWUserService.m
//  Fantasy
//
//  Created by wansy on 15/4/18.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWUserService.h"

@implementation EWUserService

+(void)getAccessTokenWithParam:(EWSinaAccountParam *)param success:(void (^)(EWSinaAccountResult *))success failure:(void (^)(NSError *))failure{

    [self postWithURL:@"https://api.weibo.com/oauth2/access_token" paramters:param resultClass:[EWSinaAccountResult class]  success:success failure:failure];
}

+(void)sendStatusWithParam:(EWSendStatusParam *)param success:(void (^)(EWSendStatusResult *))success failure:(void (^)(NSError *))failure{
    
    [self postWithURL:@"https://api.weibo.com/2/statuses/update.json" paramters:param resultClass:[EWSendStatusResult class]  success:success failure:failure];
}
@end
