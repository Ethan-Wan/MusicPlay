//
//  EWSinaOAuthView.h
//  Fantasy
//
//  Created by wansy on 15/6/2.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EWSinaOAuthViewDelegate <NSObject>
/**
 *  授权页面回调的时候调用
 */
-(void)OAuthViewReturn;

@end
@interface EWSinaOAuthView : UIView

@property (nonatomic,strong) id<EWSinaOAuthViewDelegate> delegate;

@end
