//
//  EWReviewContent.h
//  Fantasy
//
//  Created by wansy on 15/5/29.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EWReviewContentFrame;

@interface EWReviewContentView : UIView

/**
 *  用户头像
 */
@property (nonatomic,weak) UIImageView *userIconView;

/**
 *  用户昵称
 */
@property (nonatomic,weak) UILabel *nickNameLabel;
/**
  *  发布时间
*/
@property (nonatomic,weak) UILabel *userIdLabel;

/**
 *  点赞按钮
 */
@property (nonatomic,weak) UIButton *button;

@property (nonatomic,strong) EWReviewContentFrame *contentFrame;

@end
