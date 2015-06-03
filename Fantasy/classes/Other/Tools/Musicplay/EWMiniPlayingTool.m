//
//  EWMiniPlayingTool.m
//  Fantasy
//
//  Created by wansy on 15/5/26.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWMiniPlayingTool.h"
#import "EWMiniPlayingViewController.h"

@implementation EWMiniPlayingTool

static EWMiniPlayingViewController *_miniPlayingVc;

/**
 *  得到控制器
 */
+(EWMiniPlayingViewController *)miniPlayingVc{
    return _miniPlayingVc;
}

/**
 *  设置控制器
 */
+(void)setMiniPlayingVc:(EWMiniPlayingViewController *)miniPlayingVc{
    _miniPlayingVc = miniPlayingVc;
}

/**
 *  隐藏控制器
 */
+(void)hiddenMiniPlaying{
    //带动画隐藏
    [UIView animateWithDuration:animateDuration animations:^{
         _miniPlayingVc.view.y = screen.bounds.size.height;
    } completion:^(BOOL finished) {
        _miniPlayingVc.view.hidden = YES;
    }];
}

/**
 *  显示控制器view
 */
+(void)showMiniPlaying{
    _miniPlayingVc.view.y = screen.bounds.size.height;
    
    //带动画出现
    [UIView animateWithDuration:animateDuration animations:^{
          _miniPlayingVc.view.hidden = NO;
        
        _miniPlayingVc.view.y = screenH - miniPlayheight;
    }];
}


@end
