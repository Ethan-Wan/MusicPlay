//
//  EWTDMVPlayerViewController.m
//  Fantasy
//
//  Created by wansy on 15/5/28.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWTDMVPlayerViewController.h"
#import "EWTDAccountTool.h"
#import "EWTDOAuthView.h"
#import "EWTDService.h"
#import "EWTDMVTool.h"
#import "EWMV.h"
#import "MBProgressHUD+MJ.h"

@interface EWTDMVPlayerViewController ()<EWTDOAuthViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *contentLabel;

@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic)  UIButton *backgroundButton;
- (IBAction)addButoon:(id)sender;

@end

@implementation EWTDMVPlayerViewController

#pragma mark － 生命周期方法

- (void)viewDidLoad {
    [super viewDidLoad];
}
#pragma mark - 私有方法
//点击评论按钮
- (IBAction)addButoon:(UIButton *)button {
    if (!button.selected) {
        //判断是否已授权
        if (![EWTDAccountTool account]) {
            [self setupOAuthView];
            return;
        }
        
        [UIView animateWithDuration:animateDuration animations:^{
            self.contentLabel.x = 75;
        }];
        [self.contentLabel becomeFirstResponder];
        button.selected = YES;
    }else{
        [UIView animateWithDuration:animateDuration animations:^{
            self.contentLabel.x += self.contentLabel.width;
        }];
        button.selected = NO;
        [self.contentLabel resignFirstResponder];
        
        //有内容的时候就发送评论
        if (self.contentLabel.text.length >= 1) {
            [self sendReview];
        }
    }
    
}

/**
 *  发送评论
 */
-(void)sendReview{
    //1.设置请求参数
    EWSendReviewParam *param = [[EWSendReviewParam alloc] init];
    param.itemCode = [EWTDMVTool tdMV].itemCode;
    param.access_token = [EWTDAccountTool account].access_token;
    param.comment = self.contentLabel.text;
    
    //2.发送请求
    [EWTDService sendReviewWithParam:param success:^(EWSendReviewResult *responseObj) {
        if(responseObj.value){
            [MBProgressHUD showSuccess:@"发送评论成功"];
            self.contentLabel.text = @"";
        }else
            [MBProgressHUD showError:@"发送评论失败"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}

/**
 *  设置授权页面
 */
-(void)setupOAuthView{
    //1.设置背景按钮
    UIButton *backgroundButton = [[UIButton alloc] init];
    backgroundButton.frame = self.view.bounds;
    backgroundButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    backgroundButton.alpha = 0;
    
    //2.初始化用户头像设置界面
    EWTDOAuthView *oautdView = [[EWTDOAuthView alloc] init];
    oautdView.width = screenW * 0.8;
    oautdView.height = screenH * 0.8;
    oautdView.center = backgroundButton.center;
    oautdView.delegate = self;
    
    [backgroundButton addTarget:self action:@selector(removeButton) forControlEvents:UIControlEventTouchUpInside];
    
    //3.将用户头像设置界添加到背景按钮
    [backgroundButton addSubview:oautdView];
    self.backgroundButton = backgroundButton;
    
    [self.view addSubview:backgroundButton];
    
    //4.添加显示动画
    [UIView animateWithDuration:animateDuration animations:^{
        backgroundButton.alpha = 1.0;
    }];

}

-(void)removeButton{
    [self.backgroundButton removeFromSuperview];
}

#pragma mark - EWTDOAuthViewDelegate
/**
 *  回调
 */
-(void)OAuthViewReturn{
    //1.移除背景按钮
    [self removeButton];
    
    //2.继续执行点击按钮操作
    [self addButoon:self.addButton];
}
@end
