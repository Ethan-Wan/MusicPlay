//
//  EWSinaOAuthView.m
//  Fantasy
//
//  Created by wansy on 15/6/2.
//  Copyright (c) 2015年 wansy. All rights reserved.
//

#import "EWSinaOAuthView.h"
#import "EWSinaAccount.h"
#import "EWSinaAccountTool.h"
#import "EWUserService.h"
#import "MJExtension.h"
#import "EWMainViewController.h"

@interface EWSinaOAuthView()<UIWebViewDelegate>

@property (nonatomic,weak) UIWebView *webView;

@end
@implementation EWSinaOAuthView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //创建一个网页视图
        NSString *str = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",EWClientId,EWRedirectUri];
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
    NSString *str = [NSString stringWithFormat:@"%@?code=",EWRedirectUri];
    NSRange rang = [url rangeOfString:(str)];
    //rang.location＝0代表在字符串中找到制定字符串
    //rang.location = NSNotFound 则表示没找到
    //获得code
    if(rang.location != NSNotFound){
        int from = (int)(rang.length + rang.location);
        NSString *code = [url substringFromIndex:from];
        [self getAccessTokenWithCode:code];
    }
    
    return YES;
}
/**
 *  得到access_token
 */
-(void)getAccessTokenWithCode:(NSString *)code {
    
    //设置响应头,这样会把json序列化器里面的json类型给覆盖，所以去源代码里面改比较好
    //mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    
    EWSinaAccountParam *param = [[EWSinaAccountParam alloc] init];
    param.client_id = EWClientId;
    param.client_secret = EWClientSecret;
    param.grant_type = EWGrantType;
    param.code = code;
    param.redirect_uri = EWRedirectUri;
    
    [EWUserService getAccessTokenWithParam:param success:^(EWSinaAccountResult *account) {
        //保存账号
        [EWSinaAccountTool save:[EWSinaAccount accountWithDict:account.keyValues]];
        
        //回调
        if ([self.delegate respondsToSelector:@selector(OAuthViewReturn)]) {
            [self removeFromSuperview];
            [self.delegate OAuthViewReturn];
        }
    
    } failure:^(NSError *error) {
        nil;
    }];
}
@end
