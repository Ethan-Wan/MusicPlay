//
//  EWPlayingViewController.m
//  Fantasy
//
//  Created by wansy on 15/5/17.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "EWPlayingViewController.h"
#import "EWMusicTool.h"
#import "EWVadioTool.h"
#import "EWMusic.h"
#import "EWLrcView.h"
#import "EWMusicListView.h"
#import "EWMiniPlayingViewController.h"
#import "EWShareView.h"
#import "EWSinaShareView.h"

#import "EWSinaOAuthView.h"
#import "EWSinaAccount.h"
#import "EWSinaAccountTool.h"


@interface EWPlayingViewController ()<AVAudioPlayerDelegate,EWMusicListViewDelegate,EWSinaOAuthViewDelegate>
- (IBAction)exit;
- (IBAction)playOrPauseMusic;
- (IBAction)nextMusic;
- (IBAction)previousMusic;
- (IBAction)musicList:(UIButton *)sender;
- (IBAction)shareMusic;

- (IBAction)playMode:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *playingTime;
@property (weak, nonatomic) IBOutlet UILabel *totalTime;
@property (weak, nonatomic) IBOutlet UILabel *musicName;
@property (weak, nonatomic) IBOutlet UILabel *singer;
@property (weak, nonatomic) IBOutlet UIImageView *musicBackgroundIcon;
@property (weak, nonatomic) IBOutlet UIButton *playOrPause;
@property (weak, nonatomic) IBOutlet UILabel *playModeLabel;
@property (weak, nonatomic) IBOutlet UIButton *playMode;
@property (weak, nonatomic) IBOutlet UISlider *musicProgress;
@property (weak, nonatomic) IBOutlet EWLrcView *lrcView;
@property (weak, nonatomic) IBOutlet UIView *musicButtonsView;

@property (nonatomic,strong) EWMusic *playingMusic;
@property (nonatomic,strong) NSTimer *currentTime;
@property (nonatomic,strong) CADisplayLink *lrcTimer;
@property (nonatomic,strong) AVAudioPlayer *player;
@property (nonatomic,strong) EWMusicListView *musicListView;
@property (nonatomic,strong) EWShareView *shareView;
@property (nonatomic,strong) EWSinaShareView *sinaShareView;


@property (nonatomic,strong) UIButton *backgroundButton;


@end

@implementation EWPlayingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置音乐列表
    [self setupMusicListView];
    
    //设置滑条
    [self setupMusicProgress];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareViewDidSelected) name:EWSinaDidSelectedNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeButton) name:EWSinaShareDidClickNotification object:nil];
    
}

-(void)dealloc{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 公共方法
/**
 *  显示播放界面
 */
-(void)show{
    
    if (self.player.isPlaying) {
        self.playOrPause.selected = YES;
        //进来的时候，如果是播放了 就把定时器加上
        [self addCurrentTime];
        [self addLrcTimer];
    }else{
        self.playOrPause.selected = NO;
    }
    
    //1.不让app能够点击
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.view.frame = window.bounds;
    window.userInteractionEnabled = NO;
    [window addSubview:self.view];
    
//    NSLog(@"%@",window.subviews);
    
    self.view.hidden = NO;
    
    //2.如果换了歌曲,就重置播放界面的一些信息
    if (_playingMusic != [EWMusicTool playingMusic]) {
        [self resetPlayingMusic];
    }
    
    self.view.y = self.view.height;
    [UIView animateWithDuration:animateDuration animations:^{
        self.view.y = 0;
    } completion:^(BOOL finished) {
        window.userInteractionEnabled = YES;
        [self startPlayingMusic];
    }];
    
}

#pragma mark - 定时器处理方法

#pragma mark 关于进度条的定时器
-(void)addCurrentTime{
    [self removeCurrentTime];
    
    //定时器会有一秒延迟
    [self updateCurrentTime];
    
    self.currentTime = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateCurrentTime) userInfo:nil repeats:YES];
    
    //        [[NSRunLoop mainRunLoop] addTimer:self.currentTime forMode:NSRunLoopCommonModes];
}

-(void)removeCurrentTime{
    [self.currentTime invalidate];
    self.currentTime = nil;
}

/**
 *  更新进度条
 */
-(void)updateCurrentTime{
    //1.更新进度条
    self.musicProgress.value = self.player.currentTime/self.player.duration;
    
    //2.更新时间label
    self.playingTime.text = [self strWithTime:self.player.currentTime];
    
    
    //    NSLog(@"%f",self.musicProgress.value);
}

#pragma mark 关于歌词的定时器
-(void)addLrcTimer{
    [self removeLrcTimer];
    
    //定时器会有一秒延迟
    [self updateLrcProgress];
    
    self.lrcTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateLrcProgress)];
    
    [self.lrcTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)removeLrcTimer{
    [self.lrcTimer invalidate];
    self.lrcTimer = nil;
}

/**
 *  更新
 */
-(void)updateLrcProgress{
    //    NSLog(@"%f",self.player.currentTime);
    //将当前时间传给歌词界面
    self.lrcView.currentTime = self.player.currentTime;
}

#pragma mark - 私有方法

/**
 *  创建新浪分享界面
 */
-(void)shareViewDidSelected{
    NSLog(@"%@",documentPath);
    //判断当前是否有新浪用户来确定是否已授权
    if(![EWSinaAccountTool account]){
        
        //1.初始化授权界面
        EWSinaOAuthView *oauth = [[EWSinaOAuthView alloc] init];
        oauth.delegate = self;
        oauth.height = screenH * 0.8;
        oauth.width = screenW * 0.8;
        oauth.center = self.backgroundButton.center;
        
        [self.backgroundButton addSubview:oauth];
    
    }else{
        //1.初始sina化分享界面
        EWSinaShareView *sinaShare = [[EWSinaShareView alloc] init];
        sinaShare.width = 250;
        sinaShare.height = 161;
        sinaShare.center = self.backgroundButton.center;
        
        //2.将分享界面添加到背景按钮
        [self.backgroundButton addSubview:sinaShare];
        self.sinaShareView = sinaShare;
        
        //3.添加消息通知 监听键盘frame变化
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
    }
    
}
/**
 *  键盘frame变化时所触发的事件
 *
 *  @param notification 一些参数
 */
-(void)keyBoardWillChangeFrame:(NSNotification *)notification{

    NSDictionary *info = [notification userInfo];
    
    //1.键盘frame变化所所需要的时间
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    //2.得到键盘frame改变结束后的frame
    CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];

    //3.执行动画，让toolBar根据键盘frame的变化而变化
    if(endKeyboardRect.origin.y == keyboardH){
        [UIView animateWithDuration:duration animations:^{
           self.sinaShareView.center = self.backgroundButton.center;
        }];
    }
    else{
        [UIView animateWithDuration:duration animations:^{
            self.sinaShareView.y = endKeyboardRect.origin.y - self.sinaShareView.height;
        }];
    }
}


/**
 *  开始播放音乐
 */
-(void)startPlayingMusic{
    // 如果是同一首歌
    if(self.playingMusic == [EWMusicTool playingMusic]) {
        //        if(self.player.isPlaying){
        //            [self addLrcTimer];
        //            [self addCurrentTime];
        //        }
        return;
    }
    
    //1.设置当前歌曲
    self.playingMusic = [EWMusicTool playingMusic];
    
    //2.设置播放界面基本信息
    self.musicBackgroundIcon.image =[UIImage imageNamed:self.playingMusic.icon];
    self.musicName.text = self.playingMusic.name;
    self.singer.text = self.playingMusic.singer;
    self.lrcView.lrcName = self.playingMusic.lrcname;
    self.playOrPause.selected = YES;
    
    //3.播放
    self.player = [EWVadioTool playMusic:self.playingMusic.filename];
    self.player.delegate = self;
    
    self.totalTime.text = [self strWithTime:self.player.duration];
    
    //4.添加定时器
    [self addCurrentTime];
    [self addLrcTimer];
    
    //5.更新音乐列表
    [self.musicListView reloadTableView];
    
    if ([self.delegate respondsToSelector:@selector(playingVcChangePlayingStatus)]) {
        [self.delegate playingVcChangePlayingStatus];
    }

    
}

/**
 *  设置音乐列表
 */
-(void)setupMusicListView{
    EWMusicListView *musicListView = [[EWMusicListView alloc] init];
    
    // 设置listView的frame
    musicListView.y = navigationBarMaxY;
    musicListView.x = self.view.width;
    musicListView.width = self.view.width*2/3;
    musicListView.height = self.view.height - self.musicButtonsView.height-2 - navigationBarMaxY;
    
    musicListView.hidden = YES;
    musicListView.delegate = self;
    //    musicListView.alpha = 0.5;
    //    musicListView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    musicListView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:musicListView];
    self.musicListView = musicListView;
}

/**
 *  将歌曲时间转化成指定字符串
 */
-(NSString *)strWithTime:(NSTimeInterval)totalTime{
    int minute = totalTime/60;
    int seconde = (int)totalTime%60;
    return  [NSString stringWithFormat:@"%d:%02d",minute,seconde];
}

/**
 *  重置播放界面信息
 */
-(void)resetPlayingMusic{
    //
    self.musicBackgroundIcon.image = [UIImage imageNamed:@"musicBackground.png"];
    self.musicName.text = @"暂无歌曲";
    self.singer.text = nil;
    self.playOrPause.selected = NO;
    self.totalTime.text = nil;
    self.lrcView.lrcName = nil;
    
    [EWVadioTool stopMusic:self.playingMusic.filename];
    
    self.player = nil;
    
    //停止定时器
    [self removeCurrentTime];
    [self removeLrcTimer];
}

/**
 *  推出播放界面
 */
- (IBAction)exit {
    //    为了内外进度条一致就不移除定时器了
    //    [self removeCurrentTime];
    //    [self removeLrcTimer];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //1.防止用户多次点击
    window.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:animateDuration animations:^{
        self.view.y = self.view.height;
    } completion:^(BOOL finished) {
        self.view.hidden = YES;
        window.userInteractionEnabled = YES;
    }];
}
/**
 *  暂停或播放歌曲
 */
- (IBAction)playOrPauseMusic {

    if(self.playOrPause.selected){
        //移除定时器
        [self removeCurrentTime];
        [self removeLrcTimer];
        
        [EWVadioTool pauseMusic:self.playingMusic.filename];
        self.playOrPause.selected = NO;
        
    }else{
        //先播放再添加定时器
        [EWVadioTool playMusic:self.playingMusic.filename];
        self.playOrPause.selected = YES;
        
        [self addCurrentTime];
        [self addLrcTimer];
        
        //第一次进来的时候，点击播放随机一首歌
        if (!self.playingMusic) {
            [EWMusicTool setPlayingMusic:[EWMusicTool randomMusic]];
            [self startPlayingMusic];
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(playingVcChangePlayingStatus)]) {
        [self.delegate playingVcChangePlayingStatus];
    }
}
/**
 *  播放下一首歌
 */
- (IBAction)nextMusic {
    //1.重置歌曲(暂停当前播放歌曲)
    [self resetPlayingMusic];
    
    //2.得到下一首歌的信息
    if(self.playMode.selected){
        [EWMusicTool setPlayingMusic:[EWMusicTool randomMusic]];
    }else {
        [EWMusicTool setPlayingMusic:[EWMusicTool nextMusic]];
    }
    
    //3.播放下一首
    [self startPlayingMusic];
    
    if ([self.delegate respondsToSelector:@selector(playingVcChangePlayingStatus)]) {
        [self.delegate playingVcChangePlayingStatus];
    }
}
/**
 *  播放上一首歌
 */
- (IBAction)previousMusic {
    //1.重置歌曲(暂停当前播放歌曲)
    [self resetPlayingMusic];
    
    //2.得到上一首歌的信息
    if(self.playMode.selected){
        [EWMusicTool setPlayingMusic:[EWMusicTool randomMusic]];
    }else {
        [EWMusicTool setPlayingMusic:[EWMusicTool previousMusic]];
    }
    
    //3.播放上一首
    [self startPlayingMusic];
    
    if ([self.delegate respondsToSelector:@selector(playingVcChangePlayingStatus)]) {
        [self.delegate playingVcChangePlayingStatus];
    }
}

/**
 *  打开关闭音乐播放界面
 */
- (IBAction)musicList:(UIButton *)button {
    //1.防止狂点
    button.userInteractionEnabled = NO;
    
    //2.展现或退出音乐列表
    if(button.selected){
        [UIView animateWithDuration:animateDuration animations:^{
            self.musicListView.x = self.view.width ;
        } completion:^(BOOL finished) {
            self.musicListView.hidden = YES;
            button.userInteractionEnabled = YES;
        }];
        button.selected = NO;
    }else{
        [UIView animateWithDuration:animateDuration animations:^{
            self.musicListView.hidden = NO;
            self.musicListView.x = self.view.width/3;
        } completion:^(BOOL finished) {
            button.userInteractionEnabled = YES;
        }];
        button.selected = YES;
    }
    
}
/**
 *  点击分享按钮
 */
- (IBAction)shareMusic {
    //1.创建背景按钮
    UIButton *backgroundButton = [[UIButton alloc] init];
    backgroundButton.frame = self.view.bounds;
    backgroundButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    backgroundButton.alpha = 0;
    
    //2.初始化分享界面
    EWShareView *shareView = [[EWShareView alloc] init];
    
    shareView.y = 165;
    shareView.x = 70;
    shareView.width = backgroundButton.width - 140;
    shareView.height = backgroundButton.height -330;
    
    //3.将分享界面添加到背景按钮
    [backgroundButton addSubview:shareView];
    
    [backgroundButton addTarget:self action:@selector(removeButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backgroundButton];
    
    //4.添加显示动画
    [UIView animateWithDuration:animateDuration animations:^{
        backgroundButton.alpha = 1.0;
    }];
    
    self.backgroundButton = backgroundButton;
}


/**
 *  切换播放模式
 */
- (IBAction)playMode:(UIButton *)button {
    button.userInteractionEnabled = NO;
    if(button.selected){
        [self showModeLabel:@"循环模式" Button:button];
        button.selected = NO;
    }else{
        [self showModeLabel:@"随机模式" Button:button];
        button.selected = YES;
    }
}

-(void)showModeLabel:(NSString *)modeName Button:(UIButton *)button{
    //1.设置圆角
    self.playModeLabel.layer.cornerRadius = 5;
    self.playModeLabel.layer.masksToBounds = YES;
    
    self.playModeLabel.alpha = 1;
    self.playModeLabel.text = modeName;
    self.playModeLabel.hidden = NO;
    
    //2. 1.5秒后消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:animateDuration animations:^{
            self.playModeLabel.alpha = 0;
        } completion:^(BOOL finished) {
            self.playModeLabel.hidden = YES;
            button.userInteractionEnabled = YES;
        }];
    });
}

/**
 *  设置滑条
 */
-(void) setupMusicProgress{
    //自定义
    [self.musicProgress setThumbImage:[UIImage imageNamed:@"sliderThumb_small.png"] forState:UIControlStateNormal];
    [self.musicProgress setThumbImage:[UIImage imageNamed:@"sliderThumb_small.png"] forState:UIControlStateHighlighted];
    // 放手时触发
    [self.musicProgress addTarget:self action:@selector(dragSlider:) forControlEvents:UIControlEventTouchUpInside];
    
    // 按下时触发
    [self.musicProgress addTarget:self action:@selector(dragSlider2) forControlEvents:UIControlEventTouchDown];
    
    // 值改变时触发
    [self.musicProgress addTarget:self action:@selector(dragSlider1:) forControlEvents:UIControlEventValueChanged];
}
#pragma mark - 控件监听事件

/**
 *  监听slider
 */
-(void)dragSlider:(UISlider *)slider{
    self.musicProgress.value = slider.value;
    
    //1.调整歌曲播放进度
    self.player.currentTime = slider.value * self.player.duration;
    
    [self addCurrentTime];
}

-(void)dragSlider1:(UISlider *)slider{
    //    //1.排除掉在拖拽过程中定时器的干扰
    //    [self removeCurrentTime];
    
    self.musicProgress.value = slider.value;
    
    self.playingTime.text = [self strWithTime:slider.value * self.player.duration];
}

-(void)dragSlider2{
    //1.排除掉在拖拽过程中定时器的干扰
    if (self.player.isPlaying) {
        [self removeCurrentTime];
    }
}

/**
 *  将按钮移除
 *
 *  @param button 按钮
 */
-(void)removeButton {
    [self.backgroundButton removeFromSuperview];
}

#pragma mark - AVAudioPlayerDelegate

/**
 *  播放完时
 */
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    [self nextMusic];
}

/**
 *  播放器中断开始时
 */
-(void)audioPlayerBeginInterruption:(AVAudioPlayer *)player{
    if(self.player.isPlaying){
        [EWVadioTool pauseMusic:self.playingMusic.filename];
    }
}

/**
 *  播放器中断结束时
 */
-(void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags{
    
}

#pragma mark - EWMusicListViewDelegate

/**
 *  当列表中有歌曲被选中时
 */
-(void)musicListViewDidSelectMusic{
    //
    [EWVadioTool stopMusic:self.playingMusic.filename];
    [self removeCurrentTime];
    
    //播放音乐
    [self startPlayingMusic];
}

#pragma mark - EWSinaOAuthViewDelegate

-(void)OAuthViewReturn{
    [self shareViewDidSelected];
}

@end
