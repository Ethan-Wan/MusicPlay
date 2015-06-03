//
//  EWPlayingViewController.h
//  Fantasy
//
//  Created by wansy on 15/5/17.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EWPlayingVcDelegate <NSObject>
/**
 *   当前页面中歌曲状态发生变化的时候
 */
-(void)playingVcChangePlayingStatus;

@end
@interface EWPlayingViewController : UIViewController

-(void)show;

@property (nonatomic,strong) id<EWPlayingVcDelegate> delegate;
@end
