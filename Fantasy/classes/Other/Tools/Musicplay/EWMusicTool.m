//
//  EWMusicTool.m
//  Fantasy
//
//  Created by wansy on 15/5/17.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWMusicTool.h"
#import "EWMusic.h"
#import "MJExtension.h"

@implementation EWMusicTool
static NSArray *_musics;
static EWMusic *_playingMusic;

+(NSArray *)musics{
    if(!_musics){
        _musics = [EWMusic objectArrayWithFilename:@"Musics.plist"];
    }
    return _musics;
}

/**
 *  返回正在播放的歌曲
 */
+(EWMusic *)playingMusic{
    return _playingMusic;
}

/**
 *  设置正在播放的music
 */
+(void) setPlayingMusic:(EWMusic *)playingMusic{
    //1.判断正在播放的音乐是否是空或者在列表中
    if (!playingMusic || ![[self musics] containsObject:playingMusic]) return;
    
    //2.判断是否和现在的音乐相同
    if(_playingMusic == playingMusic) return;
    
    _playingMusic = playingMusic;
}

/**
 *  返回下一首播放的歌曲
 */
+(EWMusic *)nextMusic{
    //  NSLog(@"%@",_playingMusic.name);
    int nextIndex = 0;
    //当前要有播放的歌曲
    if (_playingMusic) {
        nextIndex = (int)[_musics indexOfObject:_playingMusic]+1;
        if (nextIndex >= _musics.count) {
            nextIndex = 0;
        }
    }
    return _musics[nextIndex];
}

/**
 *  返回上一首播放的歌曲
 */
+(EWMusic *)previousMusic{
    int previousIndex = 0;
    //当前要有播放的歌曲
    if (_playingMusic) {
        previousIndex = (int)[_musics indexOfObject:_playingMusic]-1;
        if (previousIndex < 0) {
            previousIndex = (int)_musics.count-1;
        }
    }
    return _musics[previousIndex];
}

/**
 *  返回下一首随机播放的歌曲
 */
+(EWMusic *)randomMusic{
    if(!_musics)
        [EWMusicTool musics];
    int randomIndex = arc4random()%_musics.count;
    //当前要有播放的歌曲
    if (_playingMusic) {
        int index = (int)[_musics indexOfObject:_playingMusic];
        if (randomIndex == index) {
            if (randomIndex + 1 >= _musics.count) {
                randomIndex = arc4random()%_musics.count;
            }
        }
    }
    return _musics[randomIndex];
}

@end
