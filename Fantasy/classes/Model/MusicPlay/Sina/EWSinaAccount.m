//
//  EWAccount.m
//  
//
//  Created by wansy on 15/4/8.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWSinaAccount.h"

@implementation EWSinaAccount

+(instancetype) accountWithDict:(NSDictionary *)dict{
    EWSinaAccount *account = [[self alloc] init];
    account.access_token = dict[@"access_token"];
    account.uid = dict[@"uid"];
    account.expires_in = dict[@"expires_in"];
    
    //获取过期时间
    NSDate *now = [NSDate date];
    account.expires_time = [now dateByAddingTimeInterval:account.expires_in.doubleValue];
    
    return account;
}

/**
 *  到从文件中解析一个对象的时候调用
 *  该方法中写清楚怎么解析文件中的数据
 */
-(id)initWithCoder:(NSCoder *)decoder{
    if(self = [super init]){
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.expires_time = [decoder decodeObjectForKey:@"expires_time"];
        self.name = [decoder decodeObjectForKey:@"name"];
    }
    return self;
}

/**
 *  将对象写入文件的时候用
 *  该方法中写清楚要存储对象的那些属性，以及怎样存储属性
 */
-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.expires_time forKey:@"expires_time"];
    [encoder encodeObject:self.name forKey:@"name"];
}

@end
