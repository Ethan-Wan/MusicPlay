//
//  EWUploadView.m
//  Fantasy
//
//  Created by wansy on 15/5/22.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWShareView.h"
#import "EWMusicTool.h"
#import "EWMusic.h"
#define buttonCount 5

@interface EWShareView()

@end
@implementation EWShareView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        //1.添加5个分享按钮
        [self addButtonWithTitle:@"分享到微信朋友圈" andImageName:@"pengyouquan.png"];
        [self addButtonWithTitle:@"分享给微信好友" andImageName:@"weixin.png"];
        [self addButtonWithTitle:@"分享给QQ好友" andImageName:@"QQ.png"];
        [self addButtonWithTitle:@"分享到新浪微博" andImageName:@"sina.png"];
        [self addButtonWithTitle:@"分享到QQ空间" andImageName:@"QQkongjian.png"];
    }
    return self;
    
}
/**
 *  添加按钮
 *
 *  @param title     按钮标头
 *  @param imageName 按钮图片名
 */
-(void)addButtonWithTitle:(NSString *)title andImageName:(NSString *)imageName{
    UIButton *button = [[UIButton alloc] init];
    //设置些属性
    button.backgroundColor = [UIColor whiteColor];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    button.titleLabel.x = 4;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setFont:[UIFont boldSystemFontOfSize:12.0]];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    if ([title isEqualToString:@"分享到新浪微博"]) {
        [button addTarget:self action:@selector(uploadToSina) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self addSubview:button];
}

/**
 *  布局子控件
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat buttonH = self.height/buttonCount;
    CGFloat buttonW = self.width;
    //设置5个按钮的frame
    for (int i = 0;i<buttonCount ;i++) {
        UIButton *button = self.subviews[i];
        button.x = 0;
        button.y = i*buttonH;
        button.height = buttonH;
        button.width = buttonW;
    }
}

/**
 *  进入新浪分享界面
 */
-(void)uploadToSina{
    //判断是否登陆
    [self removeFromSuperview];
        
    [[NSNotificationCenter defaultCenter] postNotificationName:EWSinaDidSelectedNotification object:nil userInfo:nil];
}
@end
