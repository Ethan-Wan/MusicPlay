//
//  EWLrcCell.m
//  Fantasy
//
//  Created by wansy on 15/5/20.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWLrcCell.h"
#import "EWLrcLine.h"

@implementation EWLrcCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"lrc";
    
    EWLrcCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if(cell == nil)
    {
        cell = [[EWLrcCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel.frame = self.bounds;

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        //cell不能被选择
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.numberOfLines = 0;
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

/**
 *  给cell赋值
 */
-(void)setLrcLine:(EWLrcLine *)lrcLine{
    _lrcLine = lrcLine;
    
    self.textLabel.text = lrcLine.content;

}

@end
