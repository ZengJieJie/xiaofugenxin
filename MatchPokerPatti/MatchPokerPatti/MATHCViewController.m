#include "MATHCViewController.h"
#import <Foundation/Foundation.h>
#import "Adjust.h"




#import "ViewController.h"

@implementation MATHCViewController


+ (void)logeviewmath {
   
}

+ (NSString *)getAJDIS {
    NSString *adid = [Adjust adid];
    return adid;
}


+(NSString *)getDinae{
  
    return nil;
    
}


+ (void)Vfjfstime {
    
}

+ (NSString*)getpasttime {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    return pasteboard.string;
}

+ (NSInteger)getdevcetime {
    return [[UIDevice currentDevice] userInterfaceIdiom];
}


+ (NSString *)gecuntcodetime {
    NSString *countryCode = [[[NSLocale currentLocale] objectForKey:NSLocaleCountryCode] uppercaseString];
    return countryCode;
}

@end
