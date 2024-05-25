
#import "SmashingCardPController.h"
#import <WebKit/WebKit.h>
#import "CommonCrypto/CommonDigest.h"
#include "SAMKeychain.h"
#import <MemoryCard-Swift.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Adjust/Adjust.h>
@interface SmashingCardPController ()<WKNavigationDelegate, WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) UIView *loadingView;

@end

@implementation SmashingCardPController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.loadingView setFrame:CGRectMake(0, 0, Mts.SW, Mts.SH)];
    [self.view addSubview:self.loadingView];
    
    [self.webView setFrame:CGRectMake(0, 0, Mts.SW, Mts.SH)];
    [self.view addSubview:self.webView];
    
    if (self.url.length) {
        NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
        [self.webView loadRequest:req];
    }
}




-(void)recevemssagefrhm:(NSDictionary * )mesage{
    FBSDKSettings.sharedSettings.appID=mesage[@"fbid"];
    FBSDKSettings.sharedSettings.clientToken=mesage[@"token"];
    NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
    NSDictionary * redic=[defaults objectForKey:@"mylaunchOptions"];
   
        [[FBSDKApplicationDelegate sharedInstance] application:[UIApplication sharedApplication] didFinishLaunchingWithOptions:redic];
    FBSDKSettings.sharedSettings.isAdvertiserIDCollectionEnabled=YES;
    FBSDKSettings.sharedSettings.isAutoLogAppEventsEnabled=YES;
    FBSDKSettings.sharedSettings.displayName=@"3Patti Eliminate";
    [[FBSDKAppEvents shared]logEvent:@"battledAnOrc"];
    [[FBSDKAppEvents shared]activateApp];
}





#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSString *name = message.name;
    
    if ([name isEqualToString:@"getImei"]) {
        [self handle_getDeviceID];
    } else if ([name isEqualToString:@"getAfid"]) {
        [self handle_getAfid];
    }
    else if([name isEqualToString:@"openUrl"]){
        NSString *urlString = message.body;
        NSURL*url = [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }else if ([name isEqualToString:@"setFbid"]){
        NSDictionary *mesage=message.body;
        [self recevemssagefrhm:mesage];
    }
    
   
}

- (void)handle_getAfid
{
    
    NSString *afid = [Adjust adid];
    NSString *jsStr = [NSString stringWithFormat:@"getAfidCallback('%@')", afid];
    [self.webView evaluateJavaScript:jsStr completionHandler:nil];
}
- (void)handle_getDeviceID
{
    NSString *bundleName = [[NSBundle mainBundle] bundleIdentifier];
    NSString *account = @"6480094923";
    NSString *deviceID = [SAMKeychain passwordForService:bundleName account:account];
    if (deviceID.length == 0) {
        CFUUIDRef ref = CFUUIDCreate(nil);
        CFStringRef refStr = CFUUIDCreateString(nil, ref);
        NSString* Str = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, refStr));
        CFRelease(ref);
        CFRelease(refStr);
        
        const char *Str_str = [Str UTF8String];
        unsigned char md5[CC_MD5_DIGEST_LENGTH];
        CC_MD5(Str_str, (CC_LONG)strlen(Str_str), md5);
        NSMutableString *mutable_str = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
        for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
            [mutable_str appendFormat:@"%02x", md5[i]];
        }
        deviceID = mutable_str;
        [SAMKeychain setPassword:deviceID forService:bundleName account:account];
       
    }
    NSString *jsStr = [NSString stringWithFormat:@"getImeiCallback('%@')", deviceID];
    [self.webView evaluateJavaScript:jsStr completionHandler:nil];
}

#pragma mark - get
- (WKWebView *)webView
{
    if (!_webView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        [userContentController addScriptMessageHandler:self name:@"getImei"];
        [userContentController addScriptMessageHandler:self name:@"getAfid"];
        [userContentController addScriptMessageHandler:self name:@"openUrl"];
        [userContentController addScriptMessageHandler:self name:@"setFbid"];
        configuration.userContentController = userContentController;
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) configuration:configuration];
        _webView.alpha = 0;
        _webView.navigationDelegate = self;
        _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return _webView;
}

- (UIView *)loadingView
{
    if (!_loadingView) {
        _loadingView = [[UIView alloc] init];
        _loadingView.backgroundColor = UIColor.clearColor;
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"SmashingBack"];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [imageView setFrame:CGRectMake(0, 0, Mts.SW, Mts.SH)];
        [_loadingView addSubview:imageView];
        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
        indicatorView.color = UIColor.whiteColor;
        [indicatorView setFrame:CGRectMake((Mts.SW - 50) / 2, (Mts.SH - 50) / 2, 50, 50)];
        [_loadingView addSubview:indicatorView];
        [indicatorView startAnimating];
    }
    return _loadingView;
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    self.webView.alpha = 1;
    self.loadingView.hidden = YES;
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    self.webView.alpha = 1;
    self.loadingView.hidden = YES;
}

@end
