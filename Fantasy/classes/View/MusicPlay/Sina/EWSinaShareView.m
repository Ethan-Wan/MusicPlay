//
//  EWSinaShareView.m
//  Fantasy
//
//  Created by wansy on 15/5/27.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWSinaShareView.h"
#import "EWMusic.h"
#import "EWMusicTool.h"
#import "EWSendStatusResult.h"
#import "EWSendStatusParam.h"
#import "EWUserService.h"
#import "MBProgressHUD+MJ.h"
#define sinaShareW self.width

@interface EWSinaShareView()

@property (nonatomic,weak) UILabel *titleLabel;

@property (nonatomic,weak) UILabel *colorLable;

@property (nonatomic,weak) UITextView *textView;

@property (nonatomic,weak) UIButton *cancelButton;

@property (nonatomic,weak) UIButton *sureButton;
@end

@implementation EWSinaShareView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        //1.标题
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont boldSystemFontOfSize:17];
        titleLabel.text = @"分享到新浪微博";
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        //2.分割线
        UILabel *colorLable = [[UILabel alloc] init];
        colorLable.backgroundColor = EWBlueColor;
        [self addSubview:colorLable];
        self.colorLable = colorLable;
        
        //3.文本框
        UITextView *textView = [[UITextView alloc] init];
        [self addSubview:textView];
        self.textView = textView;
        //设置textView的一些属性
        [self setupTextView];
        
        //4.取消按钮
        UIButton *cancelButton = [[UIButton alloc] init];
//        [cancelButton.layer setBorderColor: [[UIColor grayColor] CGColor]];
//        [cancelButton.layer setBorderWidth: 1.0];
//        [cancelButton.layer setMasksToBounds:YES];
//        
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:cancelButton];
        self.cancelButton = cancelButton;
        [self.cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        
        //5.确定按钮
        UIButton *sureButton = [[UIButton alloc] init];
//        [sureButton.layer setBorderColor: [[UIColor grayColor] CGColor]];
//        [sureButton.layer setBorderWidth: 1.0];
//        [sureButton.layer setMasksToBounds:YES];
        
        [sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [sureButton setTitleColor:EWBlueColor forState:UIControlStateNormal];

        [self addSubview:sureButton];
        self.sureButton = sureButton;
        [self.sureButton addTarget:self action:@selector(upload) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //定义5个控件的frame
    self.titleLabel.frame = CGRectMake(0, 0, sinaShareW, 40);
    
    self.colorLable.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame),sinaShareW , 5);
    
    self.textView.frame = CGRectMake(5, CGRectGetMaxY(self.colorLable.frame)+5,sinaShareW-10 , 75);
    
    self.cancelButton.frame = CGRectMake(5, CGRectGetMaxY(self.textView.frame)+5,(sinaShareW-10)*0.5 , 30);
    
    self.sureButton.frame = CGRectMake(CGRectGetMaxX(self.cancelButton.frame), CGRectGetMaxY(self.textView.frame)+5,(sinaShareW-10)*0.5 , 30);
    
}

/**
 *  设置textView的一些属性
 */
-(void)setupTextView{
    EWMusic *music = [EWMusicTool playingMusic];
    
    //设置边框样式
    [self.textView.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [self.textView.layer setBorderWidth: 1.0];
    [self.textView.layer setCornerRadius:8.0f];
    [self.textView.layer setMasksToBounds:YES];
    
    //设置text的默认内容
    self.textView.font = [UIFont systemFontOfSize:15];
    self.textView.text = [NSString stringWithFormat:@"分享歌曲,#%@-%@#真的很好听喔,介绍给你们（来自#FantasyIOS客户端＃）",music.singer,music.name];
    
}
//
-(void)cancel{
    [[NSNotificationCenter defaultCenter] postNotificationName:EWSinaShareDidClickNotification object:nil];
}

/**
 *  上传微博
 */
- (void)upload {
    EWSendStatusParam *param = [[EWSendStatusParam alloc] init];
    param.status = self.textView.text;
    //发表微博
    [EWUserService sendStatusWithParam:param success:^(EWSendStatusResult *responseObj) {
        [MBProgressHUD showSuccess:@"发表成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发表失败"];
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:EWSinaShareDidClickNotification object:nil];
}
@end
