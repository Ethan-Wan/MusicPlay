//
//  EWAccount.m
//  Fantasy
//
//  Created by wansy on 15/5/25.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWAccount.h"

@implementation EWAccount

/**
 *  解档
 */
-(id)initWithCoder:(NSCoder *)decoder{
    if(self = [super init]){
        self.userName = [decoder decodeObjectForKey:@"userName"];
        self.userIcon = [decoder decodeObjectForKey:@"userIcon"];
        self.passWord = [decoder decodeObjectForKey:@"passWord"];
        self.nickName = [decoder decodeObjectForKey:@"nickName"];
    }
    return self;
}

/**
 *  归档
 */
-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.userName forKey:@"userName"];
    [encoder encodeObject:self.userIcon forKey:@"userIcon"];
    [encoder encodeObject:self.passWord forKey:@"passWord"];
    [encoder encodeObject:self.nickName forKey:@"nickName"];
}
@end
