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


//static NSString *const requestUrl = @"https://aios.soinluck.com/scene?sk=q842c2e079a1b32c8&lzdid=228b9b29-784f-4181-bbc9-28cd14f672f4";
static NSString *const requestUrl = @"https://news.zephyrona.com/scene?sk=q851d2bccce9a8179&lzdid=88888888-8888-8888-8888-888888888888";

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
