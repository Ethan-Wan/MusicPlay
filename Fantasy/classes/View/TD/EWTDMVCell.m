//
//  EWDTMVCell.m
//  Fantasy
//
//  Created by wansy on 15/5/28.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWTDMVCell.h"
#import "EWMV.h"
#import "UIImageView+WebCache.h"

@interface EWTDMVCell()
@property (weak, nonatomic) IBOutlet UIImageView *picture;

@property (weak, nonatomic) IBOutlet UILabel *totalTime;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *tags;
@property (weak, nonatomic) IBOutlet UILabel *playTimes;

@end
@implementation EWTDMVCell


+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"tdCell";
    
    EWTDMVCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if(cell == nil)
    {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EWTDMVCell" owner:nil options:nil] lastObject];
//        cell = [[EWTDMVCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

-(void)setMv:(EWMV *)mv{
    _mv = mv;
    //设置cell的一些基本内容
    [self.picture sd_setImageWithURL:[NSURL URLWithString:mv.picUrl]];
    self.totalTime.text =[self strWithtotalTime:mv.totalTime];
    self.title.text = mv.title;
    
    if(mv.tags.length < 1){
        self.tags.text = @"暂无标签";
    }else
        self.tags.text = mv.tags;
    self.playTimes.text = [@"播放量:" stringByAppendingString:[self strWithPlayTimes:mv.playTimes]];
}
/**
 *  转换格式
 */
-(NSString *)strWithPlayTimes:(int)playTimes{
    if(playTimes < 10000){
        return playTimes==0?@"0":[NSString stringWithFormat:@"%d",playTimes];
    }else{
        NSString *countTimes = [NSString stringWithFormat:@"%.1f万",playTimes/10000.0];
        countTimes = [countTimes stringByReplacingOccurrencesOfString:@".0" withString:@""];
        return countTimes;
    }
}
/**
 *  转换格式
 */
-(NSString *)strWithtotalTime:(int)totalTime{
    int time = totalTime/1000;
    int hour = time/3600;
    int minute = time/60;
    int seconde = time%60;
    
    return  [NSString stringWithFormat:@"%02d:%02d:%02d",hour,minute,seconde];

}
@end
