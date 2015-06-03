//
//  EWMusicsViewController.m
//  Fantasy
//
//  Created by wansy on 15/5/17.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWMusicsViewController.h"
#import "EWMusicTool.h"
#import "EWMusicCell.h"
#import "EWPlayingViewController.h"
#import "EWMiniPlayingViewController.h"
#import "EWMiniPlayingTool.h"

@interface EWMusicsViewController ()


@property (nonatomic,strong) EWMiniPlayingViewController *miniPlayVc;
@end

@implementation EWMusicsViewController

-(EWMiniPlayingViewController *)miniPlayVc{
    if (!_miniPlayVc) {
        self.miniPlayVc = [EWMiniPlayingTool miniPlayingVc];
    }
    return _miniPlayVc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.tableView.contentInset = UIEdgeInsetsMake(0, 0,miniPlayheight, 0);
    //设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"后退" style:UIBarButtonItemStylePlain target:self action:@selector(exit)];
    
}

#pragma mark - 私有方法
/**
 *  退出
 */
-(void)exit{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [EWMusicTool musics].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //1.初始化cell
    EWMusicCell *cell = [EWMusicCell cellWithTableView:tableView];
    
    //2.给cell的内容赋值
    cell.music = [EWMusicTool musics][indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.取消cell的选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //2.设置当前所播放的音乐
    [EWMusicTool setPlayingMusic:[EWMusicTool musics][indexPath.row]];
    
    //3.播放歌曲
    [self.miniPlayVc didPlayingMusic];
}
@end
