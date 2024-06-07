//
//  AppDelegate.h
//  Numberpattii
//
//  Created by adin on 2024/4/20.
//

#import <UIKit/UIKit.h>
#import "Adjust.h"
@class RootViewController;
@interface HDAppDelegate : UIResponder <UIApplicationDelegate,AdjustDelegate>


@property(nonatomic, readonly) RootViewController* viewController;
@end

