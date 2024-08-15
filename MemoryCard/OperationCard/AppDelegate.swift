import UIKit
import Adjust
import AppTrackingTransparency

@main
class AppDelegate: UIResponder, UIApplicationDelegate, AdjustDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let token = "rz80bwazigao"
        let environment = ADJEnvironmentProduction
        let myAdjustConfig = ADJConfig(
               appToken: token,
               environment: environment)
        myAdjustConfig?.delegate = self
        myAdjustConfig?.logLevel = ADJLogLevelVerbose
        Adjust.appDidLaunch(myAdjustConfig)
        
        // window
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .systemBackground
        self.window?.rootViewController = OperationCardController()
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        Adjust.trackSubsessionStart()
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.4) {
            if #available(iOS 14, *) {
                ATTrackingManager.requestTrackingAuthorization { status in
                }
            }
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        Adjust.trackSubsessionEnd()
    }

    /// AdjustDelegate
    /// - Parameter eventSuccessResponseData:
    func adjustEventTrackingSucceeded(_ eventSuccessResponseData: ADJEventSuccess?) {
        print("adjustEventTrackingSucceeded")
    }
    
    func adjustEventTrackingFailed(_ eventFailureResponseData: ADJEventFailure?) {
        print("adjustEventTrackingFailed")
    }
    
    func adjustAttributionChanged(_ attribution: ADJAttribution?) {
        print("adid\(attribution?.adid ?? "")")
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .ShowADSNotification, object: nil, userInfo: nil)
        }
    }

}

