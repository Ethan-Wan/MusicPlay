//
//  EWSearchListViewController.m
//  Fantasy
//
//  Created by wansy on 15/5/26.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWSearchListViewController.h"
#import "EWMusicTool.h"
#import "EWMusicCell.h"
#import "EWPlayingViewController.h"
#import "EWMiniPlayingViewController.h"
#import "EWMusic.h"
#import "EWMiniPlayingTool.h"


@interface EWSearchListViewController ()<UISearchBarDelegate>

@property (nonatomic,strong) EWMiniPlayingViewController *miniPlayVc;

@property (nonatomic,strong) NSMutableArray *musics;

@end

@implementation EWSearchListViewController

-(NSMutableArray *)musics{
    if (!_musics) {
        self.musics = [NSMutableArray arrayWithArray:[EWMusicTool musics]];
    }
    return _musics;
}

-(EWMiniPlayingViewController *)miniPlayVc{
    if (!_miniPlayVc) {
        self.miniPlayVc = [EWMiniPlayingTool miniPlayingVc];
    }
    return _miniPlayVc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置NaigationItem的相关属性
    [self setupNaigationItem];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0,miniPlayheight, 0);
}

#pragma mark - 私有方法
/**
 *  退出
 */
-(void)exit{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  NaigationItem的相关属性
 */
-(void)setupNaigationItem{
    //1.设置searchBar
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.placeholder = @"歌曲";
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    
    //2.设置左边的按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"后退" style:UIBarButtonItemStylePlain target:self action:@selector(exit)];
}

#pragma mark - UISearchBarDelegate

/**
 *  搜索栏内容改变的时候进行搜索
 */
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    //1.没有内容时,查询为所有
    if(searchBar.text.length < 1)
    {
        self.musics = [NSMutableArray arrayWithArray:[EWMusicTool musics]];
        [self.tableView reloadData];
        return;
    }
    NSPredicate *predicate;
    NSArray *tempArray;
    
    //2.设置查询条件
    predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[cd] %@",searchBar.text];
    //3.查询
    tempArray = [[EWMusicTool musics] filteredArrayUsingPredicate:predicate];
    self.musics = [NSMutableArray arrayWithArray:tempArray];
    
    //4.刷新tableView
    [self.tableView reloadData];
    

}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.musics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //1.初始化cell
    EWMusicCell *cell = [EWMusicCell cellWithTableView:tableView];
    
    //2.给cell的内容赋值
    cell.music = self.musics[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.取消cell的选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //2.设置当前所播放的音乐
    [EWMusicTool setPlayingMusic:self.musics[indexPath.row]];
    
    //3.播放音乐
    [self.miniPlayVc didPlayingMusic];
}
@end
