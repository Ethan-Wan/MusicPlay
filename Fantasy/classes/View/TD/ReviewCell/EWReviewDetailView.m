//
//  EWReviewDetailView.m
//  Fantasy
//
//  Created by wansy on 15/5/29.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWReviewDetailView.h"
#import "EWReview.h"
#import "EWReviewDetailFrame.h"

@interface EWReviewDetailView()
@property (nonatomic,weak) UILabel *colorLabel;


@end
@implementation EWReviewDetailView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *textlabel = [[UILabel alloc] init];
        textlabel.numberOfLines = 0;
        textlabel.font = EWReviewTextFont;
        [self addSubview:textlabel];
        self.textLabel = textlabel;
        
    }
    return self;
}

-(void)setDetailFrame:(EWReviewDetailFrame *)detailFrame{
    _detailFrame = detailFrame;
    
    EWReview *review = detailFrame.review;
    
    self.textLabel.frame = detailFrame.textLabelFrame;
    self.textLabel.text = review.content;
    
    self.frame = detailFrame.frame;
}

@end
