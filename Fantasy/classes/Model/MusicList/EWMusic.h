//
//  EWMusic.h
//  Fantasy
//
//  Created by wansy on 15/5/17.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EWMusic : NSObject

/**String 歌曲名称*/
@property (nonatomic,copy) NSString *name;

/**String 歌曲文件名*/
@property (nonatomic,copy) NSString *filename;

/**String 歌词文件名*/
@property (nonatomic,copy) NSString *lrcname;

/**String 歌手名称*/
@property (nonatomic,copy) NSString *singer;

/**String 歌手图标*/
@property (nonatomic,copy) NSString *singerIcon;

/**String 歌手北京图标*/
@property (nonatomic,copy) NSString *icon;

@end
