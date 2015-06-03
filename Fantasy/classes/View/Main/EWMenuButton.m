//
//  EWMenuButton.m
//  Fantasy
//
//  Created by wansy on 15/5/25.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWMenuButton.h"

@implementation EWMenuButton


-(void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = EWColor(252, 252, 252);
    
    self.layer.borderWidth = 1.0;
    self.layer.cornerRadius = 8.0f;
    self.layer.masksToBounds = YES;
    
    //1.重定义按钮中imageView的frame
//    self.imageView.frame = self.bounds;
//    self.imageView.height = self.height*3/4;
    self.imageView.x = 20;
    self.imageView.y = 10;
    self.imageView.width = self.imageView.height = 40;
    
    //2.重定义按钮中label的frame
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height+10;
    self.titleLabel.width = self.width;
    self.titleLabel.height = 10;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

+(instancetype)menuButton{
    return [[self alloc] init];
}

@end
