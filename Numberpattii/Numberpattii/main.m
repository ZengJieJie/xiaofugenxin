//
//  main.m
//  Numberpattii
//
//  Created by adin on 2024/4/20.
//

#import <UIKit/UIKit.h>
#import "HDAppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName=NSStringFromClass([HDAppDelegate class]);
    }
    
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
