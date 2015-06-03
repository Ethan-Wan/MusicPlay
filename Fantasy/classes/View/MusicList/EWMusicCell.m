//
//  EWMusicCell.m
//  Fantasy
//
//  Created by wansy on 15/5/17.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWMusicCell.h"
#import "EWMusic.h"

@implementation EWMusicCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"musics";
    
    EWMusicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if(cell == nil)
    {
        cell = [[EWMusicCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

-(void)setMusic:(EWMusic *)music{
    _music = music;
    
    //设置cell中的相关内容
    self.imageView.image = [UIImage imageNamed:music.singerIcon];
    self.textLabel.text = music.name;
    self.detailTextLabel.text = music.singer;

}
@end
