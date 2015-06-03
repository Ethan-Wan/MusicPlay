//
//  EWLrcView.m
//  Fantasy
//
//  Created by wansy on 15/5/20.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWLrcView.h"
#import "EWLrcLine.h"
#import "EWLrcCell.h"

@interface EWLrcView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *lrcLines;

@property (nonatomic,assign) int currentIndex;
@end

@implementation EWLrcView

-(NSMutableArray *)lrcLines{
    if (!_lrcLines) {
        self.lrcLines = [NSMutableArray array];
    }
    return _lrcLines;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubView];
    }
    return self;
}

//一般文件中或xib、storyboard加载过来的话用这个方法
-(id)initWithCoder:(NSCoder *)decoder{
    if (self = [super initWithCoder:decoder]) {
        [self setupSubView];
    }
    return self;
}

/**
 *   初始化设置
 */
-(void)setupSubView{
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.showsVerticalScrollIndicator = NO;
    //去掉cell之间的分割线
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //使得歌词从中间出现
    tableView.contentInset = UIEdgeInsetsMake(self.width*0.5, 0, self.width*0.5, 0);
    [self addSubview:tableView];
    self.tableView = tableView;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.tableView.frame = self.bounds;
}

-(void)setLrcName:(NSString *)lrcName{
    _lrcName = [lrcName copy];
    
    [self.tableView scrollToRowAtIndexPath:0 atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    //先清空数组
    [self.lrcLines removeAllObjects];
    
    //1.获得歌词字符串数组
    NSURL *url = [[NSBundle mainBundle] URLForResource:lrcName withExtension:nil];
    NSString *lrcStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSArray *lrcList = [lrcStr componentsSeparatedByString:@"\n"];
    
    //2.将字符串数组转化成模型数组
    for (NSString *lrc in lrcList) {
        EWLrcLine *lrcLine = [[EWLrcLine alloc] init];
        [self.lrcLines addObject:lrcLine];
        //不包含就添加空串
        if(![lrc hasPrefix:@"["]) continue;
        
        if([lrc hasPrefix:@"[ti:"] || [lrc hasPrefix:@"[ar:"] || [lrc hasPrefix:@"[al:"]){
            NSString *text = [[lrc componentsSeparatedByString:@":"] lastObject];
            lrcLine.content = [text substringToIndex:text.length-1];
        }else{
            lrcLine.time = [[[lrc componentsSeparatedByString:@"]"] firstObject] substringFromIndex:1];
            lrcLine.content = [[lrc componentsSeparatedByString:@"]"] lastObject];
        }
    }
    [self.tableView reloadData];
}

/**
 *
 */
-(void)setCurrentTime:(NSTimeInterval)currentTime{
    
    //1.预防往回推拽
    if (currentTime < _currentTime) {
        self.currentIndex = -1;
    }
    
    _currentTime = currentTime;
    
    //2.将当前时间转化成相应的字符串类型
    int minute = currentTime/60;
    int seconde = (int)currentTime%60;
    int mseconde = (currentTime - (int)currentTime)*100;
    
    NSString *currentTimeStr = [NSString stringWithFormat:@"%02d:%02d.%02d",minute,seconde,mseconde];
    
    
    //3.找到当前时间所对应的那句歌词
    for (int idx = self.currentIndex + 1; idx<self.lrcLines.count; idx++) {
        EWLrcLine *currentLine = self.lrcLines[idx];
        // 当前模型的时间
        NSString *currentLineTime = currentLine.time;
        
        // 下一个模型的时间
        NSString *nextLineTime = nil;
        NSUInteger nextIdx = idx + 1;
        if (nextIdx < self.lrcLines.count) {
            EWLrcLine *nextLine = self.lrcLines[nextIdx];
            nextLineTime = nextLine.time;
        }
        // 判断是否为正在播放的歌词
        if (
            ([currentTimeStr compare:currentLineTime] != NSOrderedAscending)&& ([currentTimeStr compare:nextLineTime] == NSOrderedAscending)&& self.currentIndex != idx) {
            // 刷新tableView
            NSArray *reloadRows = @[
                                    [NSIndexPath indexPathForRow:self.currentIndex inSection:0],
                                    [NSIndexPath indexPathForRow:idx inSection:0]
                                    ];
            self.currentIndex = idx;
            [self.tableView reloadRowsAtIndexPaths:reloadRows withRowAnimation:UITableViewRowAnimationNone];
            
            // 滚动到对应的行
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
            
            //            break;
        }
    }
    
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.lrcLines.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EWLrcCell *cell = [EWLrcCell cellWithTableView:tableView];
    
    //1.内容赋值
    cell.lrcLine = self.lrcLines[indexPath.row];
    
    //2.区分演唱歌词和其他歌词
    if(indexPath.row == self.currentIndex){
        cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
    }
    else{
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    }
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}
@end
