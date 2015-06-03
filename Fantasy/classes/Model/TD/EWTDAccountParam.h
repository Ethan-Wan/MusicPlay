//
//  EWTDAccountParam.h
//  Fantasy
//
//  Created by wansy on 15/6/2.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EWTDAccountParam : NSObject

/**String	通过authorize接口返回的请求口令 */
@property (nonatomic,copy) NSString *code;

/**String	申请应用时分配的AppKey*/
@property (nonatomic,copy) NSString *client_id;

/**String	申请应用时分配的AppSecret*/
@property (nonatomic,copy) NSString *client_secret;

@end
