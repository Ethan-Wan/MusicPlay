//
//  EWSendReviewParam.h
//  Fantasy
//
//  Created by wansy on 15/6/2.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWTDBaseParam.h"

@interface EWSendReviewParam : EWTDBaseParam

/**
 *  string	通过土豆OAuth2登录获得
 */
@property (nonatomic,copy) NSString *access_token;

/**
 *  string	视频编码。例如：HRq7tp8_hR8
 */
@property (nonatomic,copy) NSString *itemCode;

/**
 *  string	评论内容
 */
@property (nonatomic,copy) NSString *comment;
@end
