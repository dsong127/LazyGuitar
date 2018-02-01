import UIKit
import DropDown

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
          
        DropDown.startListeningToKeyboard()
        
        let initialVC = window?.rootViewController as! UINavigationController
        let mainVC = initialVC.viewControllers.first as! MainViewController
        
        mainVC.stateController = StateController(storageController: StorageController())
        
        return true
    }
}
