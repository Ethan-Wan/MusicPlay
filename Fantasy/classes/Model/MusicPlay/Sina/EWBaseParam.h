//
//  EWBaseParam.h
//  新浪微博
//
//  Created by wansy on 15/4/19.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EWBaseParam : NSObject

/** string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。*/
@property (nonatomic,copy) NSString *access_token;

@end
