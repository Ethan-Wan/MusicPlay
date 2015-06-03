//
//  EWUserService.h
//  Fantasy
//
//  Created by wansy on 15/4/18.
//  Copyright (c) 2015年 wansy. All rights reserved.
//  处理用户相关方法的类

#import "EWBaseTool.h"
#import "EWSinaAccountParam.h"
#import "EWSinaAccountResult.h"
#import "EWSendStatusParam.h"
#import "EWSendStatusResult.h"

@interface EWUserService : EWBaseTool

/**
 *  获得access_token
 *
 *  @param param   请求参数
 *  @param success 请求成功返回额block
 *  @param failure 请求失败返回的block
 */
+(void)getAccessTokenWithParam:(EWSinaAccountParam *)param success:(void(^)(EWSinaAccountResult *responseObj))success failure:(void(^)(NSError *error))failure;
/**
 *  发表没有图片的微博
 *
 *  @param param   请求参数
 *  @param success 请求成功返回额block
 *  @param failure 请求失败返回的block
 */
+(void)sendStatusWithParam:(EWSendStatusParam *)param success:(void(^)(EWSendStatusResult *responseObj))success failure:(void(^)(NSError *error))failure;

@end
