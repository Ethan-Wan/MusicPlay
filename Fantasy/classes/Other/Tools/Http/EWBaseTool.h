//
//  EWBaseTool.h
//  Fantasy
//
//  Created by wansy on 15/4/18.
//  Copyright (c) 2015年 wansy. All rights reserved.
//  处理网络事件的基础类

#import "EWBaseTool.h"

@interface EWBaseTool : NSObject
/**
 *  post请求
 *
 *  @param url         请求的url
 *  @param param       传入请求参数
 *  @param resultClass 返回类型
 *  @param success     请求成功返回的block
 *  @param failure     请求失败返回的block
 */
+(void)postWithURL:(NSString *)url paramters:(id)param resultClass:(Class)resultClass success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;
/**
 *  post请求
 *
 *  @param url         请求的url
 *  @param images      装有图片的数组
 *  @param param       传入请求参数
 *  @param resultClass 返回类型
 *  @param success     请求成功返回的block
 *  @param failure     请求失败返回的block
 */
#warning 这个方法还有待改善，传入参数不应该只加一个NSArray
+(void)postWithURL:(NSString *)url images:(NSArray *)images paramters:(id)param resultClass:(Class)resultClass success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

/**
 *  get请求
 *
 *  @param url         请求的url
 *  @param param       传入请求参数
 *  @param resultClass 返回类型
 *  @param success     请求成功返回的block
 *  @param failure     请求失败返回的block
 */
+(void)getWithURL:(NSString *)url paramters:(id)param resultClass:(Class)resultClass success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

@end
