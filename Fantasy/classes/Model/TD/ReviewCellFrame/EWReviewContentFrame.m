//
//  EWReviewContentFrame.m
//  Fantasy
//
//  Created by wansy on 15/5/29.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWReviewContentFrame.h"
#import "EWReview.h"

@implementation EWReviewContentFrame

-(void)setReview:(EWReview *)review{
    _review = review;
   
    //1.设置用户头像的frame
    CGFloat userIconX = EWintervalH;
    CGFloat userIconY = EWintervalV;
    CGFloat userIconW = 40;
    CGFloat userIconH = 40;
    self.userIconViewFrame = CGRectMake(userIconX, userIconY, userIconW, userIconH);
    
    //1.设置用户昵称的frame
    CGFloat nickNameX = CGRectGetMaxX(self.userIconViewFrame) + EWintervalM;
    CGFloat nickNameY = userIconY;
    CGSize nickNameSize = [self sizeWithFont:EWReviewNickNameFont andString:review.nickName];
    self.nickNameLabelFrame = (CGRect){{nickNameX,nickNameY},nickNameSize};
    
    //3.设置发布时间的frame
    CGFloat userIdX = nickNameX;
    CGFloat userIdY = CGRectGetMaxY(self.nickNameLabelFrame) + EWintervalM;
    CGSize  userIdSize = [self sizeWithFont:EWReviewTimeFont andString:[NSString stringWithFormat:@"id:%d",review.userId]];
    self.userIdLabelFrame = (CGRect){{userIdX,userIdY},userIdSize};
    
    //4.设置点赞按钮的frame
    CGFloat buttonX = screenW - EWintervalH - 25;
    CGFloat buttonY = EWintervalV;
    self.buttonFrame = CGRectMake(buttonX, buttonY, 25, 30);
    
    
    self.frame = CGRectMake(0, 0, screenW, userIconH);
}
-(CGSize) sizeWithFont:(UIFont *)font andString:(NSString *)str{
    NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:font,NSFontAttributeName,nil];
    return [str sizeWithAttributes:dic];
}

@end
