//
//  EWVadioTool.m
//  Fantasy
//
//  Created by wansy on 15/5/17.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWVadioTool.h"

@implementation EWVadioTool

+ (void)initialize
{
    // 音频会话
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    // 设置会话类型（播放类型、播放模式,会自动停止其他音乐的播放）
    [session setCategory:AVAudioSessionCategorySoloAmbient error:nil];
    
    // 激活会话
    [session setActive:YES error:nil];
}

/**
 *  存放所有的音乐播放器
 */
static NSMutableDictionary *_musicPlayers;
+ (NSMutableDictionary *)musicPlayers
{
    if (!_musicPlayers) {
        _musicPlayers = [NSMutableDictionary dictionary];
    }
    return _musicPlayers;
}

/**
 *  播放音乐
 */
+ (AVAudioPlayer *)playMusic:(NSString *)filename
{
    if (!filename) return nil;
    
    // 1.取出对应的播放器
    AVAudioPlayer *player = [self musicPlayers][filename];
    
    // 2.播放器没有创建，进行初始化
    if (!player) {
        // 音频文件的URL
        NSURL *url = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        if (!url) return nil;
        
        // 创建播放器(一个AVAudioPlayer只能播放一个URL)
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        
        if (![player prepareToPlay]) return nil;
        
        // 存入字典
        [self musicPlayers][filename] = player;
    }
    
    // 3.播放
    if (!player.isPlaying) {
        [player play];
    }
  
    return player;
}

/**
 *  暂停音乐
 */
+ (void)pauseMusic:(NSString *)filename
{
    if (!filename) return;
    
    // 1.取出对应的播放器
    AVAudioPlayer *player = [self musicPlayers][filename];
    
    // 2.暂停
    if (player.isPlaying) {
        [player pause];
    }
}

/**
 *  停止音乐
 */
+ (void)stopMusic:(NSString *)filename
{
    if (!filename) return;
    
    // 1.取出对应的播放器
    AVAudioPlayer *player = [self musicPlayers][filename];
    
    // 2.停止
    [player stop];
    
    // 3.将播放器从字典中移除
    [[self musicPlayers] removeObjectForKey:filename];
}
@end
