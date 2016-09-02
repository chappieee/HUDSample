import UIKit
import JGProgressHUD

// https://github.com/JonasGessner/JGProgressHUD
final class JGViewController: UIViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "JGProgressHUD Samples"
        self.tableView?.rowHeight = 70
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(self.handleAddButton(_:)))
    }
    
    @IBOutlet weak var tableView: UITableView?
    
    private dynamic func handleAddButton(sender: AnyObject) {
        let controller = JGDetailViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension JGViewController: UITableViewDataSource, UITableViewDelegate {
    
    enum Sections: Int, EnumEnumerable {
        case JGProgressHUD
    }
    
    enum JGProgressHUDRows: Int, EnumEnumerable {
        case row1
        case row2
        case row3
        case row4
        case row5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let sections = Sections(rawValue: indexPath.section) else { fatalError() }
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.font = UIFont.systemFontOfSize(13)
        cell.textLabel?.numberOfLines = 2
        
        switch sections {
            
        case .JGProgressHUD:
            guard let rows = JGProgressHUDRows(rawValue: indexPath.row) else { fatalError() }
            switch rows {
            case .row1:
                cell.textLabel?.text = "Activity Indicator \n[Block OFF] [Dim OFF] [Style: Light]"
            case .row2:
                cell.textLabel?.text = "Activity Indicator \n[Block OFF] [Dim OFF] [Style: Dark]"
            case .row3:
                cell.textLabel?.text = "Activity Indicator \n[Block OFF] [Dim ON] [Style: Light]"
            case .row4:
                cell.textLabel?.text = "Activity Indicator \n[Block OFF] [Dim ON] [Style: ExtraLight]"
            case .row5:
                cell.textLabel?.text = "Activity Indicator \n[Block OFF] [Dim ON] [Style: Dark]"
            }
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = Sections(rawValue: section) else { fatalError() }
        
        switch sections {
        case .JGProgressHUD: return JGProgressHUDRows.count
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return Sections.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        guard let sections = Sections(rawValue: indexPath.section) else { fatalError() }
        
        switch sections {
            
        case .JGProgressHUD:
            
            guard let rows = JGProgressHUDRows(rawValue: indexPath.row) else { fatalError() }
            guard let navView = self.navigationController?.view else { fatalError() }
            
            switch rows {
            case .row1:
                let hud = JGProgressHUD(style: .Light)
                hud.textLabel.text = "Loading..."
                hud.showInView(navView)
                hud.interactionType = .BlockNoTouches
                hud.dismissAfterDelay(3)
                
            case .row2:
                let hud = JGProgressHUD(style: .Dark)
                hud.textLabel.text = "Loading..."
                hud.showInView(navView)
                hud.interactionType = .BlockNoTouches
                hud.dismissAfterDelay(3)
                
            case .row3:
                let hud = JGProgressHUD(style: .Light)
                hud.backgroundColor = UIColor(white: 0, alpha: 0.4)
                hud.textLabel.text = "Loading..."
                hud.showInView(navView)
                hud.interactionType = .BlockNoTouches
                hud.dismissAfterDelay(3)
                
            case .row4:
                let hud = JGProgressHUD(style: .ExtraLight)
                hud.backgroundColor = UIColor(white: 0, alpha: 0.4)
                hud.textLabel.text = "Loading..."
                hud.showInView(navView)
                hud.interactionType = .BlockNoTouches
                hud.dismissAfterDelay(3)
                
            case .row5:
                let hud = JGProgressHUD(style: .Dark)
                hud.backgroundColor = UIColor(white: 0, alpha: 0.4)
                hud.textLabel.text = "Loading..."
                hud.showInView(navView)
                hud.interactionType = .BlockNoTouches
                hud.dismissAfterDelay(3)
            }
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch Sections(rawValue: section) {
        case .JGProgressHUD?: return "JGProgressHUD"
        default:              return nil
        }
    }
}
