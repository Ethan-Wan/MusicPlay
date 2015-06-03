//
//  EWMVResult.h
//  Fantasy
//
//  Created by wansy on 15/5/28.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EWMVPage;

@interface EWMVResult : NSObject

/** MV数组（装着EWMV模型）*/
@property (nonatomic,strong) NSArray *results;

/**EWMVPage page*/
@property (nonatomic,strong) EWMVPage *page;

@end
