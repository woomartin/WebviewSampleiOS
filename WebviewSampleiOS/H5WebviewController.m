//
//  H5WebviewController.m
//  WebviewSampleiOS
//
//  Created by Martin on 2024/7/30.
//

#import "H5WebviewController.h"
#import <WebKit/WebKit.h>


@interface H5WebviewController () <WKNavigationDelegate, WKScriptMessageHandler>
@property (weak, nonatomic) IBOutlet UIView *webContentView;
@property (weak, nonatomic) WKWebView *webView;

@end


//static NSString *const requestUrl = @"http://xch.xiaochanhu.cn/";
//static NSString *const requestUrl = @"https://www.apple.com/";
static NSString *const requestUrl = @"https://aios.soinluck.com/scene?sk=228b9b29-784f-4181-bbc9-28cd14f672f4&lzdid=0000-12212-122112-212121";

@implementation H5WebviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *controller = [[WKUserContentController alloc] init];

    configuration.userContentController = controller;
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.webContentView.frame configuration:configuration];
    self.webView = webView;
    self.webView.navigationDelegate = self;
    self.webView.allowsBackForwardNavigationGestures = YES;
    [self.webContentView addSubview:self.webView];
    
    NSURL *url = [[NSURL alloc] initWithString: requestUrl];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url
                                                  cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 30];
    [self.webView loadRequest:request];

}

#pragma mark - WKWebView WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
}


#pragma mark - WKWebView WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSURL *url = [navigationAction.request URL];
    if (![url.scheme isEqual:@"http"] && ![url.scheme isEqual:@"https"]) {
        if ([[UIDevice currentDevice].systemVersion floatValue] <= 10.0) {
            [[UIApplication sharedApplication] openURL:url];
        } else {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
}

@end
