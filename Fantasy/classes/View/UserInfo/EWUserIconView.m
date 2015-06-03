//
//  EWUserIconView.m
//  Fantasy
//
//  Created by wansy on 15/5/26.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWUserIconView.h"

@interface EWUserIconView()

@property (weak, nonatomic) IBOutlet UIButton *photo;

@property (weak, nonatomic) IBOutlet UIButton *picture;

- (IBAction)photoClick;
- (IBAction)pictureClick;
@end

@implementation EWUserIconView

+(instancetype)userIcon{
    return [[[NSBundle mainBundle] loadNibNamed:@"EWUserIconView" owner:nil options:nil] lastObject];
}

/**
 *  点击拍照按钮
 */
- (IBAction)photoClick {
    NSLog(@"photo");
}

/**
 *  点击照片获取按钮
 */
- (IBAction)pictureClick {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:EWUserIconNotification object:nil];
}

@end
