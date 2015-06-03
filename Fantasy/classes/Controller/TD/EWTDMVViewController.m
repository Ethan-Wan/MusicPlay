//
//  EWTDMVViewController.m
//  Fantasy
//
//  Created by wansy on 15/5/28.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWTDMVViewController.h"
#import "EWTDService.h"
#import "MBProgressHUD+MJ.h"
#import "EWMV.h"
#import "EWTDMVTool.h"
#import "EWMVPage.h"
#import "EWMiniPlayingTool.h"
#import "EWFootRefresh.h"
#import "EWTDMVCell.h"
#import "EWTDMVPlayerViewController.h"

@interface EWTDMVViewController ()<UISearchBarDelegate>

@property (nonatomic,assign) int pageNo;

@property (nonatomic,strong) NSMutableArray *mvs;

@property (nonatomic,strong) EWFootRefresh *footer;

@property (nonatomic,strong) UIRefreshControl *refresh;
@end

@implementation EWTDMVViewController

-(NSMutableArray *)mvs{
    if (!_mvs) {
        self.mvs = [NSMutableArray array];
    }
    return _mvs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //隐藏小播放器并加上推出按钮
    [EWMiniPlayingTool hiddenMiniPlaying];
    
    [self setupBarbutton];
    
    //下拉刷行功能
    [self dropDownRefresh];
    
    //设置上拉刷新控件
    [self setupFootRefresh];
}

#pragma mark - 私有方法
/**
 *  下啦刷新功能
 */
-(void)dropDownRefresh{
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:refresh];
    self.refresh = refresh;
    
    //1.添加监听事件
    [refresh addTarget:self action:@selector(refreshMV:) forControlEvents:UIControlEventValueChanged];
    
    //2.第一次进来的时候加载整个tableView的数据
    [refresh beginRefreshing];
    [self refreshMV:refresh];
}
/**
 *  刷行mv列表
 */
-(void)refreshMV:(UIRefreshControl *) refreshControl{
    //1.设置请求参数
    EWMVParam *mvParam = [[EWMVParam alloc] init];
    mvParam.channelId = EWMVChannelId;
    mvParam.pageNo = 1;
//    if (!self.pageNo && self.pageNo-1>0) {
//        mvParam.pageNo = self.pageNo -1;
//    }
//    else if(!self.pageNo){
//        mvParam.pageNo = 1;
//    }else{
//        // 让刷新控件停止刷新（恢复默认的状态）
//        [refreshControl endRefreshing];
//        return;
//    }
    
    //2.得到mv列表
    [EWTDService getMVListWithParam:mvParam success:^(EWMVResult *responseObj) {
        NSArray *mvList = responseObj.results;
        self.pageNo = responseObj.page.pageNo;
        
//        //插入数据
//        NSRange range = NSMakeRange(0,mvList.count);
//        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
//        [self.mvs insertObjects:mvList atIndexes:indexSet];
        if (self.mvs.count > 0) {
            [self.mvs removeAllObjects];
        }
        [self.mvs addObjectsFromArray:mvList];
        
        //重新加载tableView
        [self.tableView reloadData];
        
        // 让刷新控件停止刷新（恢复默认的状态）
        [refreshControl endRefreshing];
        self.footer.hidden = NO;
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"获取MV列表失败"];
    
        // 让刷新控件停止刷新（恢复默认的状态）
        [refreshControl endRefreshing];

    }];
}
/**
 *  设置上拉刷新
 */
-(void)setupFootRefresh{
    EWFootRefresh *footer = [EWFootRefresh foot];
    self.tableView.tableFooterView = footer;
    self.footer =footer;
    self.footer.hidden = YES;
}

/**
 *  加载更多的mv
 */
- (void)loadMoreMVs
{
    //1.设置请求参数
    EWMVParam *mvParam = [[EWMVParam alloc] init];
    mvParam.channelId = EWMVChannelId;
    if (self.pageNo + 1 > 20) {
        return;
    }
    mvParam.pageNo = self.pageNo + 1;
    
    //2.得到mv列表
    [EWTDService getMVListWithParam:mvParam success:^(EWMVResult *responseObj) {
        NSArray *mvList = responseObj.results;
        self.pageNo += 1;
        
        //插入数据
        [self.mvs addObjectsFromArray:mvList];
        
        //重新加载tableView
        [self.tableView reloadData];
        
        // 让刷新控件停止刷新（恢复默认的状态）
        [self.footer endRefreshing];
        
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"获取MV列表失败"];
        
        // 让刷新控件停止刷新（恢复默认的状态）
        [self.footer endRefreshing];
        
    }];
    
}
/**
 *
 */
-(void)setupBarbutton{
    //1.设置searchBar
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.placeholder = @"mv";
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    
    UIBarButtonItem *leftBB = [[UIBarButtonItem alloc] initWithTitle:@"后退" style:UIBarButtonItemStylePlain target:self action:@selector(exit)];
    self.navigationItem.leftBarButtonItem = leftBB;
    [leftBB setTintColor:[UIColor whiteColor]];
    
}
/**
 *  退出
 */
-(void)exit{
    [self dismissViewControllerAnimated:YES completion:nil];
    [EWMiniPlayingTool showMiniPlaying];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mvs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EWTDMVCell *cell = [EWTDMVCell cellWithTableView:tableView];
    
    //传参数
    cell.mv = self.mvs[indexPath.row];
    
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

/**
 *  计算什么时候上拉加载
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.mvs.count <= 0 || self.footer.isRefreshing) return;
    
    // 1.差距
    CGFloat delta = scrollView.contentSize.height - scrollView.contentOffset.y;
    // 刚好能完整看到footer的高度
    CGFloat sawFooterH = self.view.height;
    
    // 2.如果能看见整个footer
    if (delta <= sawFooterH ) {
        // 进入上拉刷新状态
        [self.footer beginRefreshing];
        //延时两秒执行
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 加载更多的mv
            [self loadMoreMVs];
        });
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    EWMV *mv = self.mvs[indexPath.row];
    //2.添加到工具类
    [EWTDMVTool setTDMV:mv];
//    //
    EWTDMVPlayerViewController *tdMVPlayer = [[EWTDMVPlayerViewController alloc] init];
//
//    MPMoviePlayerController *mpc = [[MPMoviePlayerController alloc] init];
//    mpc.contentURL = [NSURL URLWithString:mv.playUrl];
//    mpc.view.frame = CGRectMake(0, 0, 320, 200);
//    
//    [tdMVPlayer.view addSubview:mpc.view];
//    [mpc play];
//    
//    [self.navigationController pushViewController:tdMVPlayer animated:YES];
//    
//    self.player = [[VLCMediaPlayer alloc] init];
//    
//    //设置多媒体文件
//    self.player.media = [VLCMedia mediaWithURL:[NSURL URLWithString:mv.outerPlayerUrl]];
//    
//    self.player.drawable = tdMVPlayer.view;
//    
//    [self.player play];
//
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:mv.outerGPlayerUrl]];
    
    //2.创建一个webView
    UIWebView *wv = [[UIWebView alloc] init];
    wv.frame = CGRectMake(0, 64, 320, 200);
    [wv loadRequest:request];
    [tdMVPlayer.view addSubview:wv];
    
    [self.navigationController pushViewController:tdMVPlayer animated:YES];
    
}
#pragma mark - UISearchBarDelegate
/**
 *  值发生变化时搜索
 */
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSString *text = searchBar.text;
    
    //没内容时返回所有
    if (text.length < 1) {
        [self.refresh beginRefreshing];
        [self refreshMV:self.refresh];
        return;
    }
    
    //1.设置参数
    EWSearchParam *searchParam = [[EWSearchParam alloc] init];
    searchParam.kw = text;
    
    //2.发送请求
    [EWTDService getSearchListWithParam:searchParam success:^(EWSearchResult *responseObj) {
        NSArray *mvList = responseObj.results;
        //插入数据
        NSRange range = NSMakeRange(0,mvList.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.mvs insertObjects:mvList atIndexes:indexSet];
        
        //重新加载tableView
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"搜索失败"];
    }];
    
}

@end
