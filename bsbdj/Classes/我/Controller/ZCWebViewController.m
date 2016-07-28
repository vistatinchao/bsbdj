//
//  ZCWebViewController.m
//  bsbdj
//
//  Created by mac on 16/7/25.
//  Copyright © 2016年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ZCWebViewController.h"

@interface ZCWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardItem;
@property (nonatomic,strong)NJKWebViewProgress *progress;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@end

@implementation ZCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.progress = [[NJKWebViewProgress alloc]init];
    self.webView.delegate = self.progress;
    __weak typeof(self) weakSelf = self;
    self.progress.progressBlock = ^(float progress)
    {
        weakSelf.progressView.progress = progress;
        weakSelf.progressView.hidden = (progress==1.0);
    };
    self.progress.webViewProxyDelegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}
- (IBAction)goBack:(id)sender {
    [self.webView goBack];
}


- (IBAction)goForwardItem:(id)sender {
    [self.webView goForward];
}

- (IBAction)refresh:(id)sender {
    [self.webView reload];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.goBackItem.enabled = webView.canGoBack;
    self.goForwardItem.enabled = webView.canGoForward;
}
@end
