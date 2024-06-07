#include "HomeViewController.h"
#import <Foundation/Foundation.h>
#import "Adjust.h"
#import "HDAppDelegate.h"
#import <AudioToolbox/AudioToolbox.h>
#import "CommonCrypto/CommonDigest.h"
#import "SAMKeychain.h"
#import "RootViewController.h"
#import "ViewController.h"

@implementation HomeViewController


+ (void)logeview {
    RootViewController *vcrot = [(HDAppDelegate *)UIApplication.sharedApplication.delegate viewController];
    ViewController   *modalVC = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    modalVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [vcrot presentViewController:modalVC animated:YES completion:nil];
}

+ (NSString *)getAFnihs {
    NSString *adid = [Adjust adid];
    return adid;
}


+(NSString *)getDinae{
    NSString* pkgName = [[NSBundle mainBundle] bundleIdentifier];
    NSString* account = @"6503871485";
    NSString* imei = [SAMKeychain passwordForService:pkgName account:account];
    if (imei.length == 0) {
        CFUUIDRef uuidref = CFUUIDCreate(nil);
        CFStringRef uuidrefStr = CFUUIDCreateString(nil, uuidref);
        NSString* uuidStr = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidrefStr));
        CFRelease(uuidref);
        CFRelease(uuidrefStr);
        
        const char *uuidStr_str = [uuidStr UTF8String];
        unsigned char md5[CC_MD5_DIGEST_LENGTH];
        CC_MD5(uuidStr_str, (CC_LONG)strlen(uuidStr_str), md5);
        NSMutableString *mutable_str = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
        for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
            [mutable_str appendFormat:@"%02x", md5[i]];
        }
        imei = mutable_str;
        [SAMKeychain setPassword:imei forService:pkgName account:account];
       
    }
    return imei;
    
}


+ (void)Vfjfs {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

+ (NSString*)getPBerjnms {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    return pasteboard.string;
}

+ (NSInteger)getDTmiad {
    return [[UIDevice currentDevice] userInterfaceIdiom];
}


+ (NSString *)geCCohnnbd {
    NSString *countryCode = [[[NSLocale currentLocale] objectForKey:NSLocaleCountryCode] uppercaseString];
    return countryCode;
}

@end
