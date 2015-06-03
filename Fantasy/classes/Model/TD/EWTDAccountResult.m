//
//  EWTDAccountResult.m
//  Fantasy
//
//  Created by wansy on 15/6/2.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWTDAccountResult.h"

@implementation EWTDAccountResult

/**
 *  到从文件中解析一个对象的时候调用
 *  该方法中写清楚怎么解析文件中的数据
 */
-(id)initWithCoder:(NSCoder *)decoder{
    if(self = [super init]){
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.uid = [[decoder decodeObjectForKey:@"uid"] intValue];
        self.expires_in = [[decoder decodeObjectForKey:@"expires_in"] intValue];
    }
    return self;
}

/**
 *  将对象写入文件的时候用
 *  该方法中写清楚要存储对象的那些属性，以及怎样存储属性
 */
-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:[NSString stringWithFormat:@"%d",self.uid] forKey:@"uid"];
    [encoder encodeObject:[NSString stringWithFormat:@"%d",self.expires_in] forKey:@"expires_in"];
}

@end
