import UIKit
import SideMenuController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        SideMenuController.preferences.drawing.menuButtonImage = UIImage(named: "menu")
        SideMenuController.preferences.drawing.sidePanelPosition = .UnderCenterPanelLeft
        SideMenuController.preferences.drawing.sidePanelWidth = 250
        SideMenuController.preferences.drawing.centerPanelShadow = true
        SideMenuController.preferences.animating.statusBarBehaviour = .HorizontalPan
        SideMenuController.preferences.animating.transitionAnimator = FadeAnimator.self
        
        
//        let controller = UIStoryboard(name: "MBViewController", bundle: nil).instantiateInitialViewController()!
//        let controller = UIStoryboard(name: "SVViewController", bundle: nil).instantiateInitialViewController()!
//        let controller = UIStoryboard(name: "JGViewController", bundle: nil).instantiateInitialViewController()!
//        let controller = UIStoryboard(name: "PKViewController", bundle: nil).instantiateInitialViewController()!
//        self.window?.rootViewController = UINavigationController(rootViewController: controller)
        
        
        let controller = UIStoryboard(name: String(CachingSideMenuController), bundle: nil).instantiateInitialViewController()!
        self.window?.rootViewController = controller
        
        return true
    }

}

