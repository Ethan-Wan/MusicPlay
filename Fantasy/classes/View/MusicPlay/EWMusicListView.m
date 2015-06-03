//
//  EWMusicListView.m
//  Fantasy
//
//  Created by wansy on 15/5/20.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWMusicListView.h"
#import "EWMusicTool.h"
#import "EWMusic.h"
#import "UIImage+EW.h"
#import "Colours.h"

@interface EWMusicListView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,weak) UITableView *tableView;
@end

@implementation EWMusicListView


#pragma mark - 初始化

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
//    tableView.backgroundColor = [UIColor colorWithHue:<#(CGFloat)#> saturation:<#(CGFloat)#> brightness:<#(CGFloat)#> alpha:<#(CGFloat)#>];
    
    tableView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    [self addSubview:tableView];
    self.tableView = tableView;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.tableView.frame = self.bounds;
}

#pragma mark - 共有方法
-(void)reloadTableView{
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [EWMusicTool musics].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"musicList";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    EWMusic *music = [EWMusicTool musics][indexPath.row];
    
    cell.backgroundColor = [UIColor clearColor];
    
    //若是正在播放的歌曲，则变换字体颜色
    if([EWMusicTool playingMusic].filename == music.filename){
        cell.imageView.image = [UIImage circleImageWithName:music.singerIcon borderWidth:3.0 borderColor:[UIColor blueberryColor]];
        cell.textLabel.textColor = EWBlueColor;
    }
    else {
        cell.imageView.image = [UIImage circleImageWithName:music.singerIcon borderWidth:3.0 borderColor:[UIColor coolGrayColor]];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@--%@",music.name,music.singer];
    return cell;
}

/**
 *  选中cell
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        //取消选中
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
        //是同一首歌就不用操作了
        if ([EWMusicTool playingMusic] == [EWMusicTool musics][indexPath.row]) return;
    
        //1.重新设置音乐
        [EWMusicTool setPlayingMusic:[EWMusicTool musics][indexPath.row]];
    
        //2.代理方法
        if ([self.delegate respondsToSelector:@selector(musicListViewDidSelectMusic)]) {
            [self.delegate musicListViewDidSelectMusic];
        }
    
        [tableView reloadData];
}


@end
