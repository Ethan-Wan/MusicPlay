//
//  EWMusicListView.h
//  Fantasy
//
//  Created by wansy on 15/5/20.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EWMusicListViewDelegate <NSObject>

-(void)musicListViewDidSelectMusic;

@end

@interface EWMusicListView : UIView

@property (nonatomic,strong) id<EWMusicListViewDelegate> delegate;

/**
 *  重载tableView
 */
-(void)reloadTableView;

@end
