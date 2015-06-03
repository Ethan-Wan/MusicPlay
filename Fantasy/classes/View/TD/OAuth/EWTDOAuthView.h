//
//  EWTDOAuthView.h
//  Fantasy
//
//  Created by wansy on 15/6/2.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EWTDOAuthViewDelegate <NSObject>
/**
 *  授权页面回调的时候调用
 */
-(void)OAuthViewReturn;

@end

@interface EWTDOAuthView : UIView

@property (nonatomic,strong) id<EWTDOAuthViewDelegate> delegate;

@end
