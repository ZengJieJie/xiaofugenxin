//
//  AppDelegate.m
//  HomeRummygames
//
//  Created by adin on 2024/6/13.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        // 创建根视图控制器
    ViewController *rootViewController = [[ViewController alloc] init];
        
        // 设置根视图控制器
        self.window.rootViewController = rootViewController;
        
        // 显示窗口
        [self.window makeKeyAndVisible];
    return YES;
}


@end
