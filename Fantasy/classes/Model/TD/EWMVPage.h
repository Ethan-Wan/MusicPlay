//
//  EWMVPage.h
//  Fantasy
//
//  Created by wansy on 15/5/28.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EWMVPage : NSObject

/**int 总页数*/
@property (nonatomic,assign) int pageCount;

/**int 当前页码*/
@property (nonatomic,assign) int pageNo;

/**int 每页数量*/
@property (nonatomic,assign) int pageSize;

/**int 总的视频数*/
@property (nonatomic,assign) int totalCount;

@end
