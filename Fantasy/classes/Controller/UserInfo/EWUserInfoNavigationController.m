//
//  EWUserInfoNavigationController.m
//  Fantasy
//
//  Created by wansy on 15/5/26.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWUserInfoNavigationController.h"

@interface EWUserInfoNavigationController ()

@end

@implementation EWUserInfoNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(void)initialize{
    UINavigationBar *appearance = [UINavigationBar appearance];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    //   textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    [appearance setTitleTextAttributes:textAttrs];
    
    [self setupBarButtonItem];
}

+(void)setupBarButtonItem{
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    //设置title背景色
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    //设置title的文字样式
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    //设置titile的阴影
    //  textAttrs[NSShadowAttributeName] = [NSValue valueWithUIOffset:UIOffsetZero];
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionary];
    
    highTextAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    highTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    //   highTextAttrs[NSShadowAttributeName] = [NSValue valueWithUIOffset:UIOffsetZero];
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    disableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    //   disableTextAttrs[NSShadowAttributeName] = [NSValue valueWithUIOffset:UIOffsetZero];
    [appearance setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}
@end
