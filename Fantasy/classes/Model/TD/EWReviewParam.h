//
//  EWReviewParam.h
//  Fantasy
//
//  Created by wansy on 15/5/29.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWTDBaseParam.h"

@interface EWReviewParam : EWTDBaseParam

/**string	视频编码。例如：HRq7tp8_hR8*/
@property (nonatomic,copy) NSString *itemCode;

/**int 当前页码*/
@property (nonatomic,assign) int pageNo;
@end
