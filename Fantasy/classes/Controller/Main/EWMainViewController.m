//
//  EWMainViewController.m
//  Fantasy
//
//  Created by wansy on 15/5/22.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWMainViewController.h"
#import "EWAccount.h"
#import "EWAccountTool.h"
#import "EWLoginViewController.h"
#import "EWUserInfoNavigationController.h"
#import "EWMiniPlayingViewController.h"
#import  "EWMiniPlayingTool.h"
#import "EWSearchNavigationController.h"

@interface EWMainViewController ()<UIScrollViewDelegate,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UIView *searchView;

@property (weak, nonatomic) IBOutlet UIPageControl *imagePageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *showMusicView;
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UISearchBar *searchMusic;

- (IBAction)userInfo:(UITapGestureRecognizer *)sender;

@property (strong, nonatomic) NSTimer *scrollTimer;
@end

@implementation EWMainViewController

#pragma mark - vc生命周期方法

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置新音乐展示
    [self setupShowMusicView];
    
    //设置用户登录状态
    [self setupUserStatus];
    
    //设置searchBar代理
    self.searchMusic.delegate = self;
    
    //添加消息通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUserStatus) name:EWUserInfoDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUserStatus) name:EWNickNameDidChangeNotification object:nil];
    
//#warning 这个做法不是太好。。。
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showMiniPlaying];
    });
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //添加定时器
    [self addScrollTimer];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    //移除定时器
    [self removeScrollTimer];
}

-(void)dealloc{
    //移除消息通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 私有方法
/**
 *  设置新音乐展示
 */
-(void)setupShowMusicView{
    CGFloat imageViewH = self.showMusicView.height;
    CGFloat imageViewW = self.showMusicView.width;
    
    //1.添加4个imageView到SrollView里面去
    for (int i = 0; i < imageViewCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"newMusic%d.jpg",i+1]];
        imageView.x = i*imageViewW;
        imageView.y = 0;
        imageView.width = imageViewW;
        imageView.height = imageViewH;
        [self.showMusicView addSubview:imageView];
    }

    //2.设置srollView的一些属性
    self.showMusicView.contentSize = CGSizeMake(self.showMusicView.width*imageViewCount, 0);
    self.showMusicView.pagingEnabled = YES;
    self.showMusicView.delegate = self;
    self.showMusicView.showsHorizontalScrollIndicator = NO;
}

/**
 *  设置用户登录状态
 */
-(void)setupUserStatus{
    
    //判断用户的登录情况
    EWAccount *account = [EWAccountTool account];
    if ([EWAccountTool account]) {
        if(account.userIcon.length<1){
            self.userIcon.image = [UIImage imageNamed:@"userDefaultIcon.png"];
        }else{
            self.userIcon.image = [UIImage imageWithContentsOfFile:[documentPath stringByAppendingPathComponent:account.userIcon]];
        }
        self.userName.text = account.nickName;
    }
    else {
        self.userIcon.image = [UIImage imageNamed:@"userDefaultIcon.png"];
        self.userName.text = @"请先登录";
    }
}

- (IBAction)userInfo:(UITapGestureRecognizer *)sender {
    //判断用户的登录情况
    if ([EWAccountTool account]) {
        
        //1.如果有用户信息，就到设置界面
        EWUserInfoNavigationController *userInfoNc = [storyBoard instantiateViewControllerWithIdentifier:@"EWUserInfoNavigationController"];
        userInfoNc.modalPresentationStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:userInfoNc animated:YES completion:nil];
    }
    else{
        
        //2.如果当前没有用户信息，则进入登录界面
        EWLoginViewController *loginVc = [storyBoard instantiateViewControllerWithIdentifier:@"EWLoginViewController"];
        [self presentViewController:loginVc animated:YES completion:nil];
    }
    [EWMiniPlayingTool hiddenMiniPlaying];
}

- (void)showMiniPlaying {
    //小播放器初始化
    EWMiniPlayingViewController *miniPlayVc = [[EWMiniPlayingViewController alloc] init];
    [EWMiniPlayingTool setMiniPlayingVc:miniPlayVc];
}

#pragma mark - 定时器方法

/**
 *  添加定时器
 */
-(void)addScrollTimer{
    
    [self removeScrollTimer];
    
    self.scrollTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(scrollImageView) userInfo:nil repeats:YES];
    
}
/**
 *  移除定时器
 */
-(void)removeScrollTimer{
    [self.scrollTimer invalidate];
    self.scrollTimer = nil;
}

/**
 *  滚动scrollView
 */
-(void)scrollImageView{
    
    CGPoint newContentOffset = (CGPoint){self.showMusicView.contentOffset.x+self.showMusicView.width,0};
    
    //判断是不是滚到最后一页
    if (newContentOffset.x == imageViewCount*self.showMusicView.width ) {
        newContentOffset =(CGPoint){0,0};
    }
    
    //2.滚动
    [self.showMusicView setContentOffset:newContentOffset animated:YES];
    
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    得到当前的页数
    self.imagePageControl.currentPage =  ((self.showMusicView.contentOffset.x / self.showMusicView.width) + 0.5);
}

#pragma mark - UISearchBarDelegate
/**
 *  点击搜索按钮的时候
 *
 *  @param searchBar 搜索栏
 */
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    EWSearchNavigationController *searchNavigationVc = [storyBoard instantiateViewControllerWithIdentifier:@"EWSearchNavigationController"];
    
    [self presentViewController:searchNavigationVc animated:YES completion:nil];
}

@end
