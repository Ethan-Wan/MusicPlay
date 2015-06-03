//
//  EWTDService.h
//  Fantasy
//
//  Created by wansy on 15/5/28.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWBaseTool.h"
#import "EWMVParam.h"
#import "EWMVResult.h"
#import "EWReviewParam.h"
#import "EWReviewResult.h"
#import "EWSearchParam.h"
#import "EWSearchResult.h"
#import "EWTDAccountParam.h"
#import "EWTDAccountResult.h"
#import "EWSendReviewParam.h"
#import "EWSendReviewResult.h"

@interface EWTDService : EWBaseTool

/**
 *  获得MV列表
 *
 *  @param param   请求参数
 *  @param success 请求成功返回额block
 *  @param failure 请求失败返回的block
 */
+(void)getMVListWithParam:(EWMVParam *)param success:(void(^)(EWMVResult *responseObj))success failure:(void(^)(NSError *error))failure;

/**
 *  获得评论列表
 *
 *  @param param   请求参数
 *  @param success 请求成功返回额block
 *  @param failure 请求失败返回的block
 */
+(void)getReviewListWithParam:(EWReviewParam *)param success:(void(^)(EWReviewResult *responseObj))success failure:(void(^)(NSError *error))failure;

/**
 *  获得搜索列表
 *
 *  @param param   请求参数
 *  @param success 请求成功返回额block
 *  @param failure 请求失败返回的block
 */
+(void)getSearchListWithParam:(EWSearchParam *)param success:(void(^)(EWSearchResult *responseObj))success failure:(void(^)(NSError *error))failure;

/**
 *  获取AccessToken
 *
 *  @param param   请求参数
 *  @param success 请求成功返回额block
 *  @param failure 请求失败返回的block
 */
+(void)getAccessTokenWithParam:(EWTDAccountParam *)param success:(void(^)(EWTDAccountResult *responseObj))success failure:(void(^)(NSError *error))failure;

/**
 *  发送评论
 *
 *  @param param   请求参数
 *  @param success 请求成功返回额block
 *  @param failure 请求失败返回的block
 */
+(void)sendReviewWithParam:(EWSendReviewParam *)param success:(void(^)(EWSendReviewResult *responseObj))success failure:(void(^)(NSError *error))failure;
@end
