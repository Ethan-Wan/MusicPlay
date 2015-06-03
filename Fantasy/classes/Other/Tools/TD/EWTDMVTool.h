//
//  EWTDMVTool.h
//  Fantasy
//
//  Created by wansy on 15/5/29.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EWMV;

@interface EWTDMVTool : NSObject
/**
 *  得到控制器
 */
+(EWMV *)tdMV;

/**
 *  设置控制器
 */
+(void)setTDMV:(EWMV *)tdMV;
@end
