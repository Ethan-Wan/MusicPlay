//
//  EWProvinces.h
//  Fantasy
//
//  Created by wansy on 15/6/1.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EWProvinces : NSObject

/** ID*/
@property (nonatomic,copy) NSString *ID;

/** 城市名称*/
@property (nonatomic,copy) NSString *ProvinceName;

/** 城市数组*/
@property (nonatomic,strong) NSArray *cities;

@end
