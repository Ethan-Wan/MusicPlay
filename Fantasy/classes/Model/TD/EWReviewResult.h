//
//  EWReviewResult.h
//  Fantasy
//
//  Created by wansy on 15/5/29.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EWMVPage;

@interface EWReviewResult : NSObject

/** Review数组（装着EWReview模型）*/
@property (nonatomic,strong) NSArray *results;

/**EWMVPage page*/
@property (nonatomic,strong) EWMVPage *page;

@end
