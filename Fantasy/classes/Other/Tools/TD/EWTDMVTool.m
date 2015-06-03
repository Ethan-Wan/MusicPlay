//
//  EWTDMVTool.m
//  Fantasy
//
//  Created by wansy on 15/5/29.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWTDMVTool.h"
#import "EWMV.h"

@implementation EWTDMVTool

static EWMV *_tdMV;
/**
 *  得到mv
 */
+(EWMV *)tdMV{
    return _tdMV;
}

/**
 *  设置mv
 */
+(void)setTDMV:(EWMV *)tdMV{
    _tdMV = tdMV;
}

@end
