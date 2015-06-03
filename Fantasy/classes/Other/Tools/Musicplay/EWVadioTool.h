//
//  EWVadioTool.h
//  Fantasy
//
//  Created by wansy on 15/5/17.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface EWVadioTool : NSObject
/**
 *  播放音乐
 *
 *  @param filename 音乐的文件名
 */
+ (AVAudioPlayer *)playMusic:(NSString *)filename;
/**
 *  暂停音乐
 *
 *  @param filename 音乐的文件名
 */
+ (void)pauseMusic:(NSString *)filename;
/**
 *  停止音乐
 *
 *  @param filename 音乐的文件名
 */
+ (void)stopMusic:(NSString *)filename;
@end
