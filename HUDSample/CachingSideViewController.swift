import UIKit
import SideMenuController

class CachingSideViewController: UIViewController {

//    let dataSource: [UIViewController.Type] = [
//        PKViewController.self,
//        MBViewController.self,
//        SVViewController.self,
//        JGViewController.self,
//        NVActivityIndicatorViewController.self
//    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.sideMenuController?.delegate = self
    }
    
    @IBOutlet weak var tableView: UITableView?
    
}

extension CachingSideViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataSource.controllers.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
//        cell?.textLabel?.text = "Switch to: " + (dataSource[indexPath.row] as! CacheableViewController.Type).cacheIdentifier
        cell.textLabel?.text = String(DataSource.controllers[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let controllerType = dataSource[indexPath.row] as! CacheableViewController.Type
        let controllerType = DataSource.controllers[indexPath.row]
        
//        if let controller = sideMenuController?.viewController(forCacheIdentifier: controllerType.cacheIdentifier) {
        if let controller = self.sideMenuController?.viewController(forCacheIdentifier: String(controllerType)) {
            self.sideMenuController?.embed(centerViewController: controller)
        } else {
//            sideMenuController?.embed(centerViewController: UINavigationController(rootViewController: controllerType.init()), cacheIdentifier: controllerType.cacheIdentifier)
            
            if controllerType == NVActivityIndicatorViewController.self {
                let controller = NVActivityIndicatorViewController()
                self.sideMenuController?.embed(centerViewController: UINavigationController(rootViewController: controller), cacheIdentifier: String(controllerType))
            } else {
                let controller = UIStoryboard(name: String(controllerType), bundle: nil).instantiateInitialViewController()!
                self.sideMenuController?.embed(centerViewController: UINavigationController(rootViewController: controller), cacheIdentifier: String(controllerType))
            }
        }
    }
}

extension CachingSideViewController: SideMenuControllerDelegate {
    
    func sideMenuControllerDidHide(sideMenuController: SideMenuController) {
        print(#function)
    }
    
    func sideMenuControllerDidReveal(sideMenuController: SideMenuController) {
        print(#function)
    }
}