//
//  EWReview.h
//  Fantasy
//
//  Created by wansy on 15/5/29.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EWReview : NSObject

/**string	评论内容*/
@property (nonatomic,copy) NSString *content;

/**int	用户id*/
@property (nonatomic,assign) int userId;

/**string	用户名称*/
@property (nonatomic,copy) NSString *userName;

/**long	发表时间*/
@property (nonatomic,assign) long publishTime;

/**string	用户所在地点*/
@property (nonatomic,copy) NSString *location;

/**string	用户昵称*/
@property (nonatomic,copy) NSString *nickName;

/**string	用户图片*/
@property (nonatomic,copy) NSString *userPic;

/**int	评论id*/
@property (nonatomic,assign) int commentId;

/**ItemParentComment	父评论，字段描述*/
@property (nonatomic,strong) EWReview *parentComment;
@end
