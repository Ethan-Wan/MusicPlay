//
//  EWTDOAuthView.m
//  Fantasy
//
//  Created by wansy on 15/6/2.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWTDOAuthView.h"
#import "EWTDService.h"
#import "MBProgressHUD+MJ.h"
#import "EWTDAccountTool.h"

@interface EWTDOAuthView()<UIWebViewDelegate>
@property (nonatomic,weak) UIWebView *webView;
@end

@implementation EWTDOAuthView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        //创建一个网页视图
        NSString *str = [NSString stringWithFormat:@"https://api.tudou.com/oauth2/authorize?client_id=%@&redirect_uri=%@",EWAppKey,EWTDRedirectUri];
        NSURL *url = [NSURL URLWithString:str];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        UIWebView *webView = [[UIWebView alloc] init];
        webView.delegate = self;
        [webView loadRequest:request];
        [self addSubview:webView];
        self.webView = webView;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.webView.frame = self.bounds;
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //    NSLog(@"%@",request.URL.absoluteString);
    
    //在webView加载的时候，取得加载的url
    NSString *url = request.URL.absoluteString;
    NSString *str = [NSString stringWithFormat:@"%@&code=",EWTDRedirectUri];
    NSRange rang = [url rangeOfString:(str)];
    
    //rang.location＝0代表在字符串中找到制定字符串
    //rang.location = NSNotFound 则表示没找到
    //获得code
    if(rang.location != NSNotFound){
        int from = (int)(rang.length + rang.location);
        NSString *codeAndState = [url substringFromIndex:from];
        //截取code这段
        NSString *code = [[codeAndState componentsSeparatedByString:@"&"] firstObject];
        [self getAccessTokenWithCode:code];
    }
    
    return YES;
}

/**
 *  得到access_token
 */
-(void)getAccessTokenWithCode:(NSString *)code {
    
    //1.设置请求参数
    EWTDAccountParam *param = [[EWTDAccountParam alloc] init];
    param.client_id = EWAppKey;
    param.client_secret = EWAppSecret;
    param.code = code;
    
    //2.发送请求
    [EWTDService getAccessTokenWithParam:param success:^(EWTDAccountResult *account) {
        //保存账号
        [EWTDAccountTool save:account];
        
        //回调
        if ([self.delegate respondsToSelector:@selector(OAuthViewReturn)]) {
            [self.delegate OAuthViewReturn];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"授权失败"];
    }];
}

@end
