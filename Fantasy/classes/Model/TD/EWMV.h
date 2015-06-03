//
//  EWMVResult.h
//  Fantasy
//
//  Created by wansy on 15/5/28.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EWMV : NSObject

/**string	视频编码。11位字符型编码,视频唯一标识*/
@property (nonatomic,copy) NSString *itemCode;

/**string	视频名字*/
@property (nonatomic,copy) NSString *title;

/**string	视频标签*/
@property (nonatomic,copy) NSString *tags;

/**string	视频描述*/
@property (nonatomic,copy) NSString *description;

/**string	视频截图*/
@property (nonatomic,copy) NSString *picUrl;

/**string	视频时长*/
@property (nonatomic,assign) int totalTime;

/**string	视频发布时间*/
@property (nonatomic,copy) NSString *pubDate;

/**int	播客id*/
@property (nonatomic,assign) int ownerId;

/**string	播客名*/
@property (nonatomic,copy) NSString *ownerName;

/**string	播客昵称*/
@property (nonatomic,copy) NSString *ownerNickname;

/**string	播客头像地址*/
@property (nonatomic,copy) NSString *ownerPic;

/**string	播客地址*/
@property (nonatomic,copy) NSString *ownerURL;

/**int	所属频道ID*/
@property (nonatomic,assign) int channelId;

/**string	站外播放器Url*/
@property (nonatomic,copy) NSString *outerPlayerUrl;

/**string	播放页Url*/
@property (nonatomic,copy) NSString *playUrl;

/**string	媒体类型*/
@property (nonatomic,copy) NSString *mediaType;

/**bool	私密*/
@property (nonatomic,assign,getter=isSecret) BOOL secret;

/**string	视频清晰度*/
@property (nonatomic,copy) NSString *hdType;

/**int	播放次数*/
@property (nonatomic,assign) int playTimes;

/**int	评论次数*/
@property (nonatomic,assign) int commentCount;

/**string	视频大图*/
@property (nonatomic,copy) NSString *bigPicUrl;

/**string	别名*/
@property (nonatomic,copy) NSString *alias;

/**bool	是否可以下载*/
@property (nonatomic,assign,getter=isDownEnble) bool downEnable;

/**string	视频位置*/
@property (nonatomic,copy) NSString *location;

/**int	收藏次数*/
@property (nonatomic,assign) int favorCount;

/**string	站外通用播放器Url*/
@property (nonatomic,copy) NSString *outerGPlayerUrl;

/**int	挖次数*/
@property (nonatomic,assign) int digCount;

/**int	埋次数*/
@property (nonatomic,assign) int buryCount;

@end
