//
//  EWLoginViewController.m
//  Fantasy
//
//  Created by wansy on 15/5/25.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWLoginViewController.h"
#import "EWAccountTool.h"
#import "EWAccount.h"
#import "MBProgressHUD+MJ.h"
#import "EWMiniPlayingTool.h"

@interface EWLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UILabel *errorInfo;

- (IBAction)login:(id)sender;
- (IBAction)exit:(id)sender;

@end

@implementation EWLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.userName becomeFirstResponder];
}

/**
 *  取消第一响应者
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.userName resignFirstResponder];
    [self.passWord resignFirstResponder];
    
}

/**
 *  登录
 */
- (IBAction)login:(id)sender {
    
    if(self.userName.text.length <1){
        self.errorInfo.text = @"用户名不能为空";
        return;
    }
    if (self.passWord.text.length < 1) {
        self.errorInfo.text = @"密码不能为空";
        return;
    }
    
    //1.验证登录信息是否正确
    NSString *result = [EWAccountTool checkAccountWithUserName:self.userName.text andPassWord:self.passWord.text];
    if ([result isEqualToString:SUCCESS]) {
        //2.当登录成功时发送消息通知
        [[NSNotificationCenter defaultCenter] postNotificationName:EWUserInfoDidChangeNotification object:nil];
        
        [MBProgressHUD showSuccess:@"登录成功"];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        self.errorInfo.text = result;
        return;
    }
    [EWMiniPlayingTool showMiniPlaying];
}
/**
 *  退出
 */
- (IBAction)exit:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [EWMiniPlayingTool showMiniPlaying];
}

@end
