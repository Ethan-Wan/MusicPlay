//
//  EWNickNameViewController.m
//  Fantasy
//
//  Created by wansy on 15/5/26.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWNickNameViewController.h"
#import "EWAccount.h"
#import "EWAccountTool.h"
#import "MBProgressHUD+MJ.h"

@interface EWNickNameViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nickName;

@end

@implementation EWNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.编辑导航栏信息
    self.navigationItem.title = @"编辑昵称";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    
    //2.设置label为第一响应者
    [self.nickName becomeFirstResponder];
    self.nickName.text = [EWAccountTool account].nickName;

}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [self.nickName resignFirstResponder];
}

/**
 *  保存用户昵称修改
 */
-(void) save{
    if (self.nickName.text.length < 1) {
        [MBProgressHUD showError:@"昵称不能为空"];
        return;
    }
    //修改用户数据
    EWAccount *account = [EWAccountTool account];
    account.nickName = self.nickName.text;
    
    [MBProgressHUD showSuccess:@"保存成功"];
    [EWAccountTool modifyAccount:account];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:EWNickNameDidChangeNotification object:nil];
    
}

@end
