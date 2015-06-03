//
//  EWMiniPlayingView.m
//  Fantasy
//
//  Created by wansy on 15/5/20.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "EWMiniPlayingViewController.h"
#import "EWMusicTool.h"
#import "EWMusic.h"
#import "EWVadioTool.h"
#import "EWPlayingViewController.h"

@interface EWMiniPlayingViewController()<EWPlayingVcDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *singerIcon;
@property (weak, nonatomic) IBOutlet UILabel *musicName;
@property (weak, nonatomic) IBOutlet UILabel *singer;
@property (weak, nonatomic) IBOutlet UISlider *musicProgress;
@property (weak, nonatomic) IBOutlet UIButton *playOrPause;

- (IBAction)playOrPauseMusic:(UIButton *)sender;
- (IBAction)nextMusic;
- (IBAction)interPlayView:(UITapGestureRecognizer *)sender;

@property (nonatomic,strong) EWMusic *playingMusic;
@property (nonatomic,strong) NSTimer *currentTime;
@property (nonatomic,strong) AVAudioPlayer *player;

@property (nonatomic,strong) EWPlayingViewController *playingVc;


@end

@implementation EWMiniPlayingViewController

-(EWPlayingViewController *)playingVc{
    if(!_playingVc){
        self.playingVc = [[EWPlayingViewController alloc] init];
        self.playingVc.delegate = self;
    }
    return _playingVc;
}

#pragma mark - 生命周期方法

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
        // 1.确定自己的frame
        self.view.y = window.height - self.view.height;
        self.view.x = 0;
        [window addSubview:self.view];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMusicProgress];
}


#pragma mark - 公共方法

-(void)didPlayingMusic{
    if(self.playingMusic == [EWMusicTool playingMusic]){
        return;
    }
    
    //1.先停掉之前播放的歌曲
    if (self.playingMusic) {
        [EWVadioTool stopMusic:self.playingMusic.filename];
    }
    
    //2.开始播放
    [self startPlayingMusic];
}

#pragma mark - 定时器方法
-(void)addCurrentTime{
    [self removeCurrentTime];
    
    //定时器会有一秒延迟
    [self updateCurrentTime];
    
    self.currentTime = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateCurrentTime) userInfo:nil repeats:YES];
}
-(void)removeCurrentTime{
    [self.currentTime invalidate];
    self.currentTime = nil;
}

-(void)updateCurrentTime{
    //更新进度条
    self.musicProgress.value = self.player.currentTime/self.player.duration;
}

#pragma mark - 私有方法
/**
 *  开始播放
 */
-(void)startPlayingMusic{
    if(self.playingMusic == [EWMusicTool playingMusic]){
        return;
    }
    
    //1.设置歌曲基本信息
    EWMusic *music = [EWMusicTool playingMusic];
    self.musicName.text = music.name;
    self.singer.text = music.singer;
    self.singerIcon.image = [UIImage imageNamed:music.singerIcon];
    
    //2.设置当前歌曲
    self.playingMusic = [EWMusicTool playingMusic];
    
    //3.开始播放
    self.player = [EWVadioTool playMusic:music.filename];
    self.playOrPause.selected = YES;
    
    //4.添加定时器
    [self addCurrentTime];
    
}

/**
 *  设置进度条
 */
-(void)setupMusicProgress{
    //该进度条不能拖拽
    self.musicProgress.userInteractionEnabled = NO;
    
    [self.musicProgress setThumbImage:[UIImage imageNamed:@"progress.png"] forState:UIControlStateNormal];
    [self.musicProgress setThumbImage:[UIImage imageNamed:@"progress.png"] forState:UIControlStateHighlighted];
}
/**
 *  播放或暂停
 */
- (IBAction)playOrPauseMusic:(UIButton *)button {
    //第一次进来的时候，点击播放随机一首歌
    if (!self.playingMusic) {
        [EWMusicTool setPlayingMusic:[EWMusicTool randomMusic]];
        [self startPlayingMusic];
        return;
    }
    if(button.selected){
        //移除定时器
        [self removeCurrentTime];
        [EWVadioTool pauseMusic:self.playingMusic.filename];
        button.selected = NO;
    }else{
        //添加定时器
        [self addCurrentTime];
        [EWVadioTool playMusic:self.playingMusic.filename];
        button.selected = YES;
    }
}

/**
 *  下一首歌曲
 */
- (IBAction)nextMusic {
    //1.暂停当前播放歌曲
    [EWVadioTool pauseMusic:self.playingMusic.filename];
    
    //2.得到下一首歌的信息
    [EWMusicTool setPlayingMusic:[EWMusicTool nextMusic]];
    
    //3.播放下一首
    [self startPlayingMusic];
}

/**
 *  点击进入播放界面
 */
- (IBAction)interPlayView:(UITapGestureRecognizer *)sender {
    [self.playingVc show];
}

#pragma mark - EWPlayingVcDelegate

/**
 *  改变页面中的一些播放状态信息
 */
-(void)playingVcChangePlayingStatus{
     [self startPlayingMusic];
    
    if (self.player.isPlaying) {
        [self addCurrentTime];
        self.playOrPause.selected = YES;
        
    }else {
        [self removeCurrentTime];
        self.playOrPause.selected = NO;
    }
    
}
@end
