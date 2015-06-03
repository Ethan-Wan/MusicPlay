//
//  EWSendStatusParam.h
//  新浪微博
//
//  Created by wansy on 15/4/18.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EWBaseParam.h"

@interface EWSendStatusParam : EWBaseParam

/**	string	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
@property (nonatomic,copy) NSString *status;

@end
