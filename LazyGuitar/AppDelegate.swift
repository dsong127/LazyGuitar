import UIKit
import DropDown

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UIApplication.shared.statusBarStyle = .lightContent
    
        DropDown.startListeningToKeyboard()
        
        // Initialize Storage Controller - This should only be done once.
        
        let initialVC = window?.rootViewController as! UINavigationController
        let mainVC = initialVC.viewControllers.first as! MainViewController
        
        mainVC.stateController = StateController(storageController: StorageController())
        
        return true
    }
}
