//
//  AppDelegate.m
//  Numberpattii
//
//  Created by adin on 2024/4/20.
//

#import "AppDelegate.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import "ViewController.h"
#import "Adjust.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[FBSDKSettings sharedSettings] setIsAdvertiserIDCollectionEnabled:YES];
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    // 创建窗口
       self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
       
       // 创建根视图控制器
       ViewController *rootViewController = [[ViewController alloc] init];
       
       // 设置根视图控制器
       self.window.rootViewController = rootViewController;
       
       // 显示窗口
       [self.window makeKeyAndVisible];
       
  
    NSString *yourAppToken = @"z6g1eorzp05c";
    NSString *environment = ADJEnvironmentProduction;
    ADJConfig *adjustConfig = [ADJConfig configWithAppToken:yourAppToken environment:environment allowSuppressLogLevel:YES];
    [adjustConfig setDelegate:self];
    [Adjust appDidLaunch:adjustConfig];
    
    [[FBSDKAppEvents shared] logEvent:@"battledAnOrc"];
    
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
            options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey, id>*)options{
    [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url options:options];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[FBSDKAppEvents shared] activateApp];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.5f*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (@available(iOS 14, *)) {
            if (ATTrackingManager.trackingAuthorizationStatus == ATTrackingManagerAuthorizationStatusNotDetermined) {
                [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus s) {}];
            }
        }
    });
}


@end
