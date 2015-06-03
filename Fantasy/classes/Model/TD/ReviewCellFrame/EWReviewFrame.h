//
//  EWReviewFrame.h
//  Fantasy
//
//  Created by wansy on 15/5/29.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EWReview,EWReviewContentFrame,EWReviewDetailFrame;

@interface EWReviewFrame : NSObject

/** 评论细节的frame*/
@property (nonatomic,strong) EWReviewDetailFrame *detailFrame;

/** 评论内容的frame*/
@property (nonatomic,strong) EWReviewContentFrame *contentFrame;

/** cell的高度*/
@property (nonatomic,assign) CGFloat cellHeight;

@property (nonatomic,strong) EWReview *review;

@end
