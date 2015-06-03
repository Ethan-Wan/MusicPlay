//
//  EWReviewFrame.m
//  Fantasy
//
//  Created by wansy on 15/5/29.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWReviewFrame.h"
#import "EWReviewContentFrame.h"
#import "EWReviewDetailFrame.h"

@implementation EWReviewFrame

-(void)setReview:(EWReview *)review{
    _review = review;
    
    
    //1.设置评论内容的frame
    EWReviewContentFrame *contentFrame = [[EWReviewContentFrame alloc] init];
    contentFrame.review = review;
    self.contentFrame = contentFrame;
    
    //2.设置评论细节的frame
    EWReviewDetailFrame *detailFrame = [[EWReviewDetailFrame alloc] init];
    detailFrame.review = review;
    self.detailFrame = detailFrame;
    
    self.detailFrame.frame = (CGRect){{0,CGRectGetMaxY(self.contentFrame.frame)+EWintervalV},self.detailFrame.frame.size};
    
    //3.设置自己的frame
    self.cellHeight = CGRectGetMaxY(self.detailFrame.frame);
}
@end
