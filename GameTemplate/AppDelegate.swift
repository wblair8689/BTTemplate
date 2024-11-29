import UIKit
import os.log

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        os_log("AppDelegate: Application launching")
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let gameViewController = PongViewController()
        window?.rootViewController = gameViewController
        window?.makeKeyAndVisible()
        
        os_log("AppDelegate: Window setup complete")
        return true
    }
}
