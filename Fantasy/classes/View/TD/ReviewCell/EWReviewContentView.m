//
//  EWReviewContent.m
//  Fantasy
//
//  Created by wansy on 15/5/29.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWReviewContentView.h"
#import "EWReviewContentFrame.h"
#import "EWReview.h"
#import "UIImageView+WebCache.h"


@implementation EWReviewContentView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //1.添加头像view
        UIImageView *userIconView = [[UIImageView alloc] init];
        [self addSubview:userIconView];
        self.userIconView = userIconView;
        
        //2.添加昵称
        UILabel *nickNameLabel = [[UILabel alloc] init];
        nickNameLabel.font = EWReviewNickNameFont;
        [self addSubview:nickNameLabel];
        self.nickNameLabel = nickNameLabel;
        
        //3.添加发布时间
        UILabel *userIdLabel = [[UILabel alloc] init];
        userIdLabel.font = EWReviewTimeFont;
        [self addSubview:userIdLabel];
        self.userIdLabel = userIdLabel;
        
        //4.添加点赞按钮
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"zan.jpg"] forState:UIControlStateNormal];
        [self addSubview:button];
        self.button = button;
        
        
        
    }
    return self;
}

-(void)setContentFrame:(EWReviewContentFrame *)contentFrame{
    _contentFrame = contentFrame;
    
    EWReview *review = contentFrame.review;
    
    self.userIconView.frame = contentFrame.userIconViewFrame;
    [self.userIconView sd_setImageWithURL:[NSURL URLWithString:review.userPic]];
    
    self.nickNameLabel.frame = contentFrame.nickNameLabelFrame;
    self.nickNameLabel.text = review.nickName;
    
    self.userIdLabel.frame = contentFrame.userIdLabelFrame;
    self.userIdLabel.text = [NSString stringWithFormat:@"id:%d",review.userId];
    
    self.button.frame = contentFrame.buttonFrame;
    
    self.frame = contentFrame.frame;
    
    
}

@end
