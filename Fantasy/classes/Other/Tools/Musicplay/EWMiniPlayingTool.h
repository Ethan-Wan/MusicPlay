//
//  EWMiniPlayingTool.h
//  Fantasy
//
//  Created by wansy on 15/5/26.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EWMiniPlayingViewController;

@interface EWMiniPlayingTool : NSObject
/**
 *  得到控制器
 */
+(EWMiniPlayingViewController *)miniPlayingVc;

/**
 *  设置控制器
 */
+(void)setMiniPlayingVc:(EWMiniPlayingViewController *)miniPlayingVc;

/**
 *  隐藏控制器view
 */
+(void)hiddenMiniPlaying;

/**
 *  显示控制器view
 */
+(void)showMiniPlaying;

@end
