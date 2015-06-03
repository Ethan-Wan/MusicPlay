//
//  EWBaseTool.m
//  Fantasy
//
//  Created by wansy on 15/5/26.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWBaseTool.h"
#import "EWHttpTool.h"
#import "MJExtension.h"

@implementation EWBaseTool

+(void)postWithURL:(NSString *)url paramters:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    //将模型转化为字典
    NSDictionary *params = [param keyValues];

    [EWHttpTool postWithURL:url paramters:params success:^(id responseObj) {
        if(success){
            id result = [resultClass objectWithKeyValues:responseObj];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)getWithURL:(NSString *)url paramters:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    //将模型转化为字典
    NSDictionary *params = [param keyValues];
    
    [EWHttpTool getWithURL:url paramters:params success:^(id responseObj) {
        if(success){
            id result = [resultClass objectWithKeyValues:responseObj];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)postWithURL:(NSString *)url images:(NSArray *)images paramters:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure{
        NSDictionary *params = [param keyValues];
    
        [EWHttpTool postWithURL:url paramters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            //将图片文件转成二进制数
            NSData *data = UIImageJPEGRepresentation([images firstObject], 1.0);
            //拼接文件参数
            [formData appendPartWithFileData:data name:@"pic" fileName:@"status.jpg" mimeType:@"image/jpeg"];
        } success:^(id responseObj) {
            if (success) {
                id result = [resultClass objectWithKeyValues:responseObj];
                success(result);
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
}

@end
