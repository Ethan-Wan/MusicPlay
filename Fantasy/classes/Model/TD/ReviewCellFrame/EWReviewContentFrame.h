//
//  EWReviewContentFrame.h
//  Fantasy
//
//  Created by wansy on 15/5/29.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EWReview;

@interface EWReviewContentFrame : NSObject
/**  用户头像Frame*/
@property (nonatomic,assign) CGRect userIconViewFrame;

/**用户昵称Frame*/
@property (nonatomic,assign) CGRect nickNameLabelFrame;

/**  发布时间Frame*/
@property (nonatomic,assign) CGRect userIdLabelFrame;

/**  点赞按钮Frame*/
@property (nonatomic,assign) CGRect buttonFrame;

@property (nonatomic,strong) EWReview *review;

/** 自己的frame*/
@property (nonatomic,assign) CGRect frame;

@end
