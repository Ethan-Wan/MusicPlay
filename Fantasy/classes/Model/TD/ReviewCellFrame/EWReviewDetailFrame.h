//
//  EWReviewDetailFrame.h
//  Fantasy
//
//  Created by wansy on 15/5/29.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EWReview;

@interface EWReviewDetailFrame : NSObject

@property (nonatomic,assign) CGRect textLabelFrame;


@property (nonatomic,strong) EWReview *review;

/** 自己的frame*/
@property (nonatomic,assign) CGRect frame;

@end
