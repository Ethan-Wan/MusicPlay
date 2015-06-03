//
//  EWRegisterViewController.m
//  Fantasy
//
//  Created by wansy on 15/5/25.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWRegisterViewController.h"
#import "EWAccountTool.h"
#import "EWAccount.h"
#import "MBProgressHUD+MJ.h"

@interface EWRegisterViewController ()
- (IBAction)exit:(id)sender;
- (IBAction)registered:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *errorInfo;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UITextField *checkPassWord;
@end

@implementation EWRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
 *  取消第一响应者
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.userName resignFirstResponder];
    [self.passWord resignFirstResponder];
    [self.checkPassWord resignFirstResponder];
    
}

/**
 *  退出
 */
- (IBAction)exit:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  注册
 */
- (IBAction)registered:(id)sender {
    
    //1.判断账号信息符合标准
    if(self.userName.text.length < 1){
        self.errorInfo.text = @"用户名不能为空";
        return;
    }
    if (self.passWord.text.length <1) {
        self.errorInfo.text = @"密码不能为空";
        return;
    }
    if(![self.passWord.text isEqualToString:self.checkPassWord.text]){
        self.errorInfo.text = @"两次密码输入不一致";
        return;
    }
    
    //2.取得相关参数
    EWAccount *account = [[EWAccount alloc] init];
    account.userName = self.userName.text;
    account.passWord = self.passWord.text;
    
    //3.添加用户信息
    NSString *result = [EWAccountTool addAccount:account];
    if (![result isEqualToString:SUCCESS]) {
        self.errorInfo.text = result;
        return;
    }
    
    [MBProgressHUD showSuccess:@"注册成功"];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
