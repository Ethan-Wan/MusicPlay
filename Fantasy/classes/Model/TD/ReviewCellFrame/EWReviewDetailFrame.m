//
//  EWReviewDetailFrame.m
//  Fantasy
//
//  Created by wansy on 15/5/29.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWReviewDetailFrame.h"
#import "EWReview.h"

@implementation EWReviewDetailFrame

-(void)setReview:(EWReview *)review{
    _review = review;
    
    //1.评论正文的frame
    CGFloat textX = EWintervalH;
    CGFloat textY = EWintervalV;
    CGFloat textW = screenW - 2*EWintervalH;
    //根据输入的内容来计算评论内容的尺寸
    NSDictionary *attribute = @{NSFontAttributeName: EWReviewTextFont};
    CGSize textSize = [review.content boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    self.textLabelFrame = (CGRect){{textX, textY},textSize};
    
//    //2.发布地点的frame
//    CGSize locationSize = [self sizeWithFont:EWReviewLocationFont andString:review.location];
//    CGFloat locationX = screenW - EWintervalH - locationSize.width;
//    CGFloat locationY = CGRectGetMaxY(self.textLabelFrame) + EWintervalV;
//    self.locationlabelFrame = (CGRect){{locationX, locationY},locationSize};
    
    
    self.frame = CGRectMake(0, 0, screenW, CGRectGetMaxY(self.textLabelFrame) + EWintervalV+2);
}

/**
 *  计算文字的尺寸
 */
-(CGSize) sizeWithFont:(UIFont *)font andString:(NSString *)str{
    NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:font,NSFontAttributeName,nil];
    return [str sizeWithAttributes:dic];
}
@end
