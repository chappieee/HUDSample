import UIKit
import SideMenuController

class CachingSideMenuController: SideMenuController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.performSegueWithIdentifier("cachingEmbedSide", sender: nil)
        
        let firstController = DataSource.controllers[0]
        let controller = UIStoryboard(name: String(firstController), bundle: nil).instantiateInitialViewController()!
        
        self.embed(centerViewController: UINavigationController(rootViewController:controller), cacheIdentifier: String(firstController))
    }
}