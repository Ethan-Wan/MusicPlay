//
//  EWMusicTool.h
//  Fantasy
//
//  Created by wansy on 15/5/26.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EWMusic;

@interface EWMusicTool : NSObject
/**
 *  返回所有歌曲列表
 */
+(NSArray *)musics;

/**
 *  返回正在播放的歌曲
 */
+(EWMusic *)playingMusic;

/**
 *  设置正在播放的歌曲
 */
+(void) setPlayingMusic:(EWMusic *)playingMusic;

/**
 *  返回下一首播放的歌曲
 */
+(EWMusic *)nextMusic;

/**
 *  返回上一首播放的歌曲
 */
+(EWMusic *)previousMusic;

/**
 *  返回一首随机播放的歌曲
 */
+(EWMusic *)randomMusic;

@end
