import UIKit
import FBSDKCoreKit
import Adjust
@main
class AppDelegate: UIResponder, UIApplicationDelegate, AdjustDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let userDefaults = UserDefaults.standard
                userDefaults.set(launchOptions, forKey: "mylaunchOptions")
                userDefaults.synchronize()
       
        initConfig()
        
        // window
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .systemBackground
        self.window?.rootViewController = UINavigationController(rootViewController: SmashingCardController())
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    private func initConfig() {
        let appToken = "b8lukjjfk7pc"
        let environment = ADJEnvironmentProduction
        let adjustConfig = ADJConfig(appToken: appToken, environment: environment)
        
        adjustConfig?.logLevel = ADJLogLevelVerbose
        
        adjustConfig?.delegate = self
        
        Adjust.appDidLaunch(adjustConfig!)
        
    }
   
    
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable : Any]) {
        
    }
    
    func onConversionDataFail(_ error: any Error) {
        
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        ApplicationDelegate.shared.application(app, open: url, options: options)
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
     
        AppEvents.shared.activateApp()
        Adjust .trackSubsessionStart()
        
    }
    func applicationWillResignActive(_ application: UIApplication) {
        Adjust .trackSubsessionEnd()
    }
    
    
    
   

}

