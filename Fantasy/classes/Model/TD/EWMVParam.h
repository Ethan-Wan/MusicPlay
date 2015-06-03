//
//  EWMVParam.h
//  Fantasy
//
//  Created by wansy on 15/5/28.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWTDBaseParam.h"

@interface EWMVParam : EWTDBaseParam

/** NSString 频道类型*/
@property (nonatomic,copy) NSString *channelId;

/**int 当前页码*/
@property (nonatomic,assign) int pageNo;

@end
