//
//  ViewController.m
//  WebviewSampleiOS
//
//  Created by Martin on 2024/7/30.
//

#import "ViewController.h"
#import "H5WebviewController.h"
#import <WebKit/WebKit.h>


@interface ViewController ()


@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}
- (IBAction)showWebview:(id)sender {
    H5WebviewController *webviewController = [[H5WebviewController alloc] init];
    webviewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:webviewController animated:YES completion:nil];
}

@end
