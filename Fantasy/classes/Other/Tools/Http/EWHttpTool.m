//
//  EWHttpTool.m
//  Fantasy
//
//  Created by wansy on 15/5/26.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWHttpTool.h"

@implementation EWHttpTool

+(void)getWithURL:(NSString *)url paramters:(id)param success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    //1.获得http管理
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //2.发送请求
    [mgr GET:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

+(void)postWithURL:(NSString *)url paramters:(id)param success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    //1.获得http管理
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //2.发送请求
    [mgr POST:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)postWithURL:(NSString *)url paramters:(id)param constructingBodyWithBlock:(void(^)(id<AFMultipartFormData>))constructingBodyWithBlock success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    //1.获得http管理
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //2.发送请求
    [mgr POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (constructingBodyWithBlock) {
            constructingBodyWithBlock(formData);
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
