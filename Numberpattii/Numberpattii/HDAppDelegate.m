//
//  AppDelegate.m
//  Numberpattii
//
//  Created by adin on 2024/4/20.
//

#import "HDAppDelegate.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import "cocos2d.h"
#import "SDKWrapper.h"
#import "platform/ios/CCEAGLView-ios.h"
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "RootViewController.h"
using namespace cocos2d;

@interface HDAppDelegate ()

@end
Application* app = nullptr;



@implementation HDAppDelegate

@synthesize window;
static NSString* safstatuesstr = nil;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:launchOptions forKey:@"mathlaunchOp"];
    [userDefaults synchronize];
    [[SDKWrapper getInstance] application:application didFinishLaunchingWithOptions:launchOptions];
     
    
    float scale = [[UIScreen mainScreen] scale];
    CGRect bounds = [[UIScreen mainScreen] bounds];
    window = [[UIWindow alloc] initWithFrame: bounds];
    app = new AppDelegate(bounds.size.width * scale, bounds.size.height * scale);
    app->setMultitouch(true);
    
    _viewController = [[RootViewController alloc]init];
    window.rootViewController=_viewController;
    [window makeKeyAndVisible];
    
    app->start();
        NSString *yourAppToken = @"qqqxjh7emk8w";
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
   
    app->onPause();
    [[SDKWrapper getInstance] applicationWillResignActive:application];
    [Adjust trackSubsessionEnd];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
   
    [[SDKWrapper getInstance] applicationDidEnterBackground:application];
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
   
    [[SDKWrapper getInstance] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    app->onResume();
    [[SDKWrapper getInstance] applicationDidBecomeActive:application];
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

- (void)applicationWillTerminate:(UIApplication *)application {
  
    [[SDKWrapper getInstance] applicationWillTerminate:application];
    delete app;
    app = nil;
}

+ (NSString *)getAdjustadd {
    ADJAttribution *attribution = [Adjust attribution];
    if(attribution.network != nil){
        safstatuesstr = attribution.network;//unattr
    }
    if (safstatuesstr == nil) {
        safstatuesstr = @"";
    }
    return safstatuesstr;
}

+ (void)configOjen:(NSString *)fbId fbClientToken:(NSString *)fbClientToken
{
    if ([fbId isKindOfClass:NSString.class] && fbId.length && [fbClientToken isKindOfClass:NSString.class] && fbClientToken.length) {
        FBSDKSettings.sharedSettings.appID = fbId;
        FBSDKSettings.sharedSettings.clientToken = fbClientToken;
        FBSDKSettings.sharedSettings.isAdvertiserIDCollectionEnabled=YES;
        FBSDKSettings.sharedSettings.isAutoLogAppEventsEnabled=YES;
        FBSDKSettings.sharedSettings.displayName=@"3Patti Math Game";
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSDictionary *retrievedDictionary = [defaults objectForKey:@"mathlaunchOp"];
        [[FBSDKApplicationDelegate sharedInstance] application:[UIApplication sharedApplication] didFinishLaunchingWithOptions:retrievedDictionary];
        [[FBSDKAppEvents shared] logEvent:@"battledAnOrc"];
    }
}


+ (void)setData:(NSString*)stype sun:(NSString*)para1 funs: (NSString*)para2 {
    NSLog(@"sendFaceBookEvent %@%@%@",stype,para1,para2);
    if(std::string([stype UTF8String]) == "2"){//login
        [[FBSDKAppEvents shared] logEvent:@"Contact"];
    }
    else if(std::string([stype UTF8String]) == "3"){//register
        [[FBSDKAppEvents shared]  logEvent:@"CompleteRegistration" parameters:@{
            @"method":para1
        }];
    }
    else if(std::string([stype UTF8String]) == "4"){//Purchase
        [[FBSDKAppEvents shared]  logEvent:@"Purchase" parameters:@{
            @"value":para1,
            @"currency":@"USD"
        }];
    }
    else if(std::string([stype UTF8String]) == "5"){//FirstPurchase
         [[FBSDKAppEvents shared]  logEvent:@"Subscribe" parameters:@{
            @"value":para1,
            @"currency":@"USD",
            @"predicted_ltv":@"0.00"
        }];
    }
    else if(std::string([stype UTF8String]) == "6"){//
        [[FBSDKAppEvents shared]  logEvent:stype parameters:@{
            @"msg":para1
        }];
    }
}



@end
