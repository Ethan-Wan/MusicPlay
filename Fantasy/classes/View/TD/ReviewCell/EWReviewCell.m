//
//  EWReviewCall.m
//  Fantasy
//
//  Created by wansy on 15/5/29.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWReviewCell.h"
#import "EWReviewContentView.h"
#import "EWReviewDetailView.h"
#import "EWReviewFrame.h"

@interface EWReviewCell()

@property (nonatomic,strong) EWReviewDetailView *detailView;

@property (nonatomic,strong) EWReviewContentView *rcontentView;

@end
@implementation EWReviewCell

+(EWReviewCell *) cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"reviewCell";
    
    EWReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if(cell == nil)
    {
        cell = [[EWReviewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        //1.添加内容视图
        EWReviewDetailView *detailView = [[EWReviewDetailView alloc] init];
        [self.contentView addSubview:detailView];
        self.detailView = detailView;
        
        //2.添加细节
        EWReviewContentView *contentView = [[EWReviewContentView alloc] init];
        [self.contentView addSubview:contentView];
        self.rcontentView = contentView;
    }
    return self;
}

-(void)setReviewFrame:(EWReviewFrame *)reviewFrame{
    _reviewFrame = reviewFrame;
    
    self.rcontentView.contentFrame = reviewFrame.contentFrame;
    
    self.detailView.detailFrame = reviewFrame.detailFrame;

}

@end
