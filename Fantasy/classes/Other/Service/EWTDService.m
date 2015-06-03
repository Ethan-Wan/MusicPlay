//
//  EWTDService.m
//  Fantasy
//
//  Created by wansy on 15/5/28.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWTDService.h"

@implementation EWTDService

/**
 *  获得MV列表
 */
+(void)getMVListWithParam:(EWMVParam *)param success:(void(^)(EWMVResult *responseObj))success failure:(void(^)(NSError *error))failure{
    [self getWithURL:@"http://api.tudou.com/v6/video/top_list" paramters:param resultClass:[EWMVResult class] success:success failure:failure];
}

/**
 *  获得评论列表
 */
+(void)getReviewListWithParam:(EWReviewParam *)param success:(void(^)(EWReviewResult *responseObj))success failure:(void(^)(NSError *error))failure{
    [self getWithURL:@"http://api.tudou.com/v6/video/comment_list" paramters:param resultClass:[EWReviewResult class] success:success failure:failure];
}

/**
 *  获得搜索列表
 */
+(void)getSearchListWithParam:(EWSearchParam *)param success:(void(^)(EWSearchResult *responseObj))success failure:(void(^)(NSError *error))failure{
    [self getWithURL:@"http://api.tudou.com/v6/video/search" paramters:param resultClass:[EWSearchResult class] success:success failure:failure];
}

/**
 *  获取AccessToken
 */
+(void)getAccessTokenWithParam:(EWTDAccountParam *)param success:(void(^)(EWTDAccountResult *responseObj))success failure:(void(^)(NSError *error))failure{
    [self postWithURL:@"https://api.tudou.com/oauth2/access_token" paramters:param resultClass:[EWTDAccountResult class] success:success failure:failure];
}
/**
 *  发送评论
 */
+(void)sendReviewWithParam:(EWSendReviewParam *)param success:(void(^)(EWSendReviewResult *responseObj))success failure:(void(^)(NSError *error))failure{
    [self getWithURL:@"http://api.tudou.com/v6/video/comment_add" paramters:param resultClass:[EWSendReviewResult class] success:success failure:failure];
}

@end
