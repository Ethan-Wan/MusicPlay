//
//  EWHttpTool.h
///  Fantasy
//
//  Created by wansy on 15/5/26.
//  Copyright (c) 2015年 wansy. All rights reserved.
//  用来封装项目中的网络请求

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface EWHttpTool : NSObject

/**
 *  Http get方法
 *
 *  @param url     请求路径
 *  @param param   请求参数
 *  @param success 请求成功后返回的block
 *  @param failure 请求失败后返回的block
 */
+(void)getWithURL:(NSString *)url paramters:(id)param success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;
/**
 *  Http post方法
 *
 *  @param url     请求路径
 *  @param param   请求参数
 *  @param success 请求成功后返回的block
 *  @param failure 请求失败后返回的block
 */
+(void)postWithURL:(NSString *)url paramters:(id)param success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;
/**
 *  Http post方法
 *
 *  @param url     请求路径
 *  @param param   请求参数
 *  @param constructingBodyWithBlock 请求的二进制参数所要的block
 *  @param success 请求成功后返回的block
 *  @param failure 请求失败后返回的block
 */
+(void)postWithURL:(NSString *)url paramters:(id)param constructingBodyWithBlock:(void(^)(id formData))constructingBodyWithBlock success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

@end
