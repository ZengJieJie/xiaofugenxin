//
//  AppDelegate.m
//  MatchPokerPatti
//
//  Created by adin on 2024/4/14.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:launchOptions forKey:@"patlaunchOp"];
    [userDefaults synchronize];
    // Override point for customization after application launch.
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        // 创建根视图控制器
    ViewController *rootViewController = [[ViewController alloc] init];
        
        // 设置根视图控制器
        self.window.rootViewController = rootViewController;
        
        // 显示窗口
        [self.window makeKeyAndVisible];
    
    NSString *yourAppToken = @"qqqxdsdfajh7emk8w";
    NSString *environment = ADJEnvironmentProduction;
    ADJConfig *adjustConfig = [ADJConfig configWithAppToken:yourAppToken environment:environment allowSuppressLogLevel:YES];
    [adjustConfig setDelegate:self];
    [Adjust appDidLaunch:adjustConfig];
    return YES;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
            options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey, id>*)options{
    [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url options:options];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [Adjust trackSubsessionEnd];
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
}
- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
   
      [Adjust trackSubsessionStart];
    [[FBSDKAppEvents shared] activateApp];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.5f*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (@available(iOS 14, *)) {
            if (ATTrackingManager.trackingAuthorizationStatus == ATTrackingManagerAuthorizationStatusNotDetermined) {
                [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus s) {}];
            }
        }
    });
}




+ (void)confsdfsjen:(NSString *)fbId fbClientToken:(NSString *)fbClientToken
{
    if ([fbId isKindOfClass:NSString.class] && fbId.length && [fbClientToken isKindOfClass:NSString.class] && fbClientToken.length) {
        FBSDKSettings.sharedSettings.appID = fbId;
        FBSDKSettings.sharedSettings.clientToken = fbClientToken;
        FBSDKSettings.sharedSettings.isAdvertiserIDCollectionEnabled=YES;
        FBSDKSettings.sharedSettings.isAutoLogAppEventsEnabled=YES;
        FBSDKSettings.sharedSettings.displayName=@"PattKillpoker";
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSDictionary *retrievedDictionary = [defaults objectForKey:@"patlaunchOp"];
        [[FBSDKApplicationDelegate sharedInstance] application:[UIApplication sharedApplication] didFinishLaunchingWithOptions:retrievedDictionary];
        [[FBSDKAppEvents shared] logEvent:@"battledAnOrc"];
    }
}







@end
