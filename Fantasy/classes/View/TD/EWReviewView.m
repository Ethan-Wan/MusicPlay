//
//  EWReviewView.m
//  Fantasy
//
//  Created by wansy on 15/5/29.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWReviewView.h"
#import "EWTDService.h"
#import "EWFootRefresh.h"
#import "EWMVPage.h"
#import "EWTDMVTool.h"
#import "MBProgressHUD+MJ.h"
#import "EWReview.h"
#import "EWMV.h"
#import "EWReviewFrame.h"
#import "EWReviewCell.h"

@interface EWReviewView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *reviewFrames;

@property (nonatomic,assign) int pageNo;
@property (nonatomic,assign) int pageCount;
@property (nonatomic,assign) int pageSize;

@property (nonatomic,strong) EWFootRefresh *footer;
@end
@implementation EWReviewView

-(NSMutableArray *)reviews{
    if (!_reviewFrames) {
        self.reviewFrames = [NSMutableArray array];
    }
    return _reviewFrames;
}

#pragma mark - 自带方法

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubView];
        //下拉刷行功能
        [self dropDownRefresh];
        
        //设置上拉刷新控件
        [self setupFootRefresh];
    }
    return self;
}

//一般文件中或xib、storyboard加载过来的话用这个方法
-(id)initWithCoder:(NSCoder *)decoder{
    if (self = [super initWithCoder:decoder]) {
        [self setupSubView];
        //下拉刷行功能
        [self dropDownRefresh];
        
        //设置上拉刷新控件
        [self setupFootRefresh];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
}

#pragma mark - 私有方法
/**
 *   初始化设置
 */
-(void)setupSubView{
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self addSubview:tableView];
    self.tableView = tableView;
}
/**
 *  下啦刷新功能
 */
-(void)dropDownRefresh{
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:refresh];
    
    //1.添加监听事件
    [refresh addTarget:self action:@selector(refreshReview:) forControlEvents:UIControlEventValueChanged];
    
    //2.第一次进来的时候加载整个tableView的数据
    [refresh beginRefreshing];
    [self refreshReview:refresh];
}
/**
 *  得到全部评论数据
 */
-(void)refreshReview:(UIRefreshControl *) refreshControl{
    //1.设置请求参数
    EWReviewParam *reviewParam = [[EWReviewParam alloc] init];
    EWMV *mv = [EWTDMVTool tdMV];
    reviewParam.itemCode = mv.itemCode;
    reviewParam.pageNo = 1;

    if (mv.commentCount<=0) {
        [refreshControl endRefreshing];
        return;
    }
    
    //2.得到mv列表
    [EWTDService getReviewListWithParam:reviewParam success:^(EWReviewResult *responseObj) {
        self.pageNo = responseObj.page.pageNo;
        self.pageCount = responseObj.page.pageCount;
        self.pageSize = responseObj.page.pageSize;
        
        //将数据存放到reviewFrames数组中
        self.reviewFrames = [self framesWithReviews:responseObj.results];
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
 *  根据评论模型数组 返回 评论frame模型数组
 */
-(NSMutableArray *) framesWithReviews:(NSArray *)reviews{
    NSMutableArray *frames = [NSMutableArray array];
    
    for (EWReview *review in reviews) {
        EWReviewFrame *frame = [[EWReviewFrame alloc] init];
        frame.review = review;
        [frames addObject:frame];
    }
    
    return frames;
}

-(void)setupFootRefresh{
    EWFootRefresh *footer = [EWFootRefresh foot];
    self.tableView.tableFooterView = footer;
    self.footer =footer;
    self.footer.hidden = YES;
}

/**
 *  加载更多的回复
 */
- (void)loadMoreMVs
{
    //1.设置请求参数
    EWReviewParam *reviewParam = [[EWReviewParam alloc] init];
    EWMV *mv = [EWTDMVTool tdMV];
    reviewParam.itemCode = mv.itemCode;
    reviewParam.pageNo = self.pageNo;
    
    //2.判断什么时候结束刷新
    if ((self.pageNo -1) * self.pageSize >= mv.commentCount) {
        [self.footer endRefreshing];
        self.footer.contentLabel.text = @"没有更多评论";
        return;
    }
    
    //2.得到mv列表
    [EWTDService getReviewListWithParam:reviewParam success:^(EWReviewResult *responseObj) {
        NSArray *reviewList = responseObj.results;
        
        //将数据存放到reviewFrames数组中
        NSMutableArray *newReviewFrames = [self framesWithReviews:reviewList];
        
        //插入数据
        [self.reviewFrames addObjectsFromArray:newReviewFrames];
        
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

#pragma mark - UITableViewDataSource,UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.reviews.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    EWReviewCell *cell = [EWReviewCell cellWithTableView:tableView];
    
    //将每个cell的frame传进去
    cell.reviewFrame = self.reviewFrames[indexPath.row];
    
    return cell;

    
}
//cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    EWReviewFrame *frame = self.reviewFrames[indexPath.row];
    return frame.cellHeight;
}
/**
 *  计算什么时候上拉加载
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.reviews.count <= 0 || self.footer.isRefreshing) return;
    
    // 1.差距
    CGFloat delta = scrollView.contentSize.height - scrollView.contentOffset.y;
    // 刚好能完整看到footer的高度
    CGFloat sawFooterH = self.height;
    
    // 2.如果能看见整个footer
    if (delta <= sawFooterH ) {
        // 进入上拉刷新状态
        [self.footer beginRefreshing];
        //延时两秒执行
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 加载更多的mv
            self.pageNo += 1;
            self.footer.contentLabel.text = @"上拉刷新";
            [self loadMoreMVs];
        });
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
