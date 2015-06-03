//
//  EWLocationView.h
//  Fantasy
//
//  Created by wansy on 15/6/1.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EWLocationView : UIView
/**
 *  初始化
 */
+(instancetype)location;

@property (weak, nonatomic) IBOutlet UIView *privinceView;
@end
