import UIKit
import MBProgressHUD
import GCDKit

// https://github.com/jdg/MBProgressHUD
class MBViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "MBProgressHUD Samples"
        self.tableView?.rowHeight = 70
    }

    private func doSomeWork() {
        sleep(3)
    }
    
    @IBOutlet weak var tableView: UITableView?
    
}

extension MBViewController: UITableViewDataSource, UITableViewDelegate {
    
    enum Sections: Int, EnumEnumerable {
        case MBProgressHUD
    }
    
    enum MBProgressHUDRows: Int, EnumEnumerable, CustomStringConvertible {
        case row1
        case row2
        case row3
        case row4
        case row5
        
        var description: String {
            switch self {
            case .row1: return "Indeterminate mode"
            case .row2: return "With label"
            case .row3: return "Dim background"
            case .row4: return "Custom view"
            case .row5: return "Text only"
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let sections = Sections(rawValue: indexPath.section) else { fatalError() }
        guard let rows = MBProgressHUDRows(rawValue: indexPath.row) else { fatalError() }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        switch sections {
        case .MBProgressHUD:
            cell.textLabel?.text = rows.description
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = Sections(rawValue: section) else { fatalError() }
        
        switch sections {
        case .MBProgressHUD: return MBProgressHUDRows.count
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return Sections.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        guard let sections = Sections(rawValue: indexPath.section) else { fatalError() }
        guard let rows = MBProgressHUDRows(rawValue: indexPath.row) else { fatalError() }
        
        switch sections {
            
        case .MBProgressHUD:
            switch rows {
            case .row1: self.executeRow1()
            case .row2: self.executeRow2()
            case .row3: self.executeRow3()
            case .row4: self.executeRow4()
            case .row5: self.executeRow5()
            }
            
            
//                let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
//                hud.backgroundView.style = .SolidColor
//                hud.backgroundView.color = UIColor(white: 0, alpha: 0.1)
//                GCDQueue.Main.async { [weak self] in
//                    self?.doSomeWork()
//                    hud.hideAnimated(true)
//                }
//                
//            case .row3:
//                let hud = MBProgressHUD.showHUDAddedTo(navView, animated: true)
//                hud.mode = .CustomView
//                let image = UIImage(named: "Checkmark")?.imageWithRenderingMode(.AlwaysTemplate)
//                hud.customView = UIImageView(image: image)
//                hud.square = true
//                hud.label.text = "Done"
//                hud.hideAnimated(true, afterDelay: 3)
//                
//            case .row4:
//                let hud = MBProgressHUD.showHUDAddedTo(navView, animated: true)
//                hud.mode = .Text
//                hud.label.text = "Hello!"
//                // Move to bottm center.
//                //hud.offset = CGPoint(x: 0, y: MBProgressMaxOffset)
//                hud.hideAnimated(true, afterDelay: 3)
//            }
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch Sections(rawValue: section) {
        case .MBProgressHUD?: return "MBProgressHUD"
        default:              return nil
        }
    }
    
    // Method
    
    private func executeRow1() {
        guard let navView = self.navigationController?.view else { return }
        
        // クラスメソッド
        MBProgressHUD.showHUDAddedTo(navView, animated: true)
        GCDQueue.Main.async { [weak self] in
            self?.doSomeWork()
            MBProgressHUD.hideHUDForView(navView, animated: true)
        }
    }
    
    private func executeRow2() {
        guard let navView = self.navigationController?.view else { return }
        
        // インスタンスメソッド
        let hud = MBProgressHUD.showHUDAddedTo(navView, animated: true)
        hud.label.text = "Loading..."
        GCDQueue.Main.async { [weak self] in
            self?.doSomeWork()
            hud.hideAnimated(true)
        }
    }
    
    private func executeRow3() {
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.backgroundView.style = .SolidColor
        hud.backgroundView.color = UIColor(white: 0, alpha: 0.1)
        GCDQueue.Main.async { [weak self] in
            self?.doSomeWork()
            hud.hideAnimated(true)
        }
    }
    
    private func executeRow4() {
        guard let navView = self.navigationController?.view else { return }
        
        let hud = MBProgressHUD.showHUDAddedTo(navView, animated: true)
        hud.mode = .CustomView
        let image = UIImage(named: "Checkmark")?.imageWithRenderingMode(.AlwaysTemplate)
        hud.customView = UIImageView(image: image)
        hud.square = true
        hud.label.text = "Done"
        hud.hideAnimated(true, afterDelay: 3)
    }
    
    private func executeRow5() {
        guard let navView = self.navigationController?.view else { return }
        
        let hud = MBProgressHUD.showHUDAddedTo(navView, animated: true)
        hud.mode = .Text
        hud.label.text = "Hello!"
        // Move to bottm center.
        //hud.offset = CGPoint(x: 0, y: MBProgressMaxOffset)
        hud.hideAnimated(true, afterDelay: 3)
    }
}

protocol EnumEnumerable {
    associatedtype Case = Self
}

extension EnumEnumerable where Case: Hashable {
    private static var generator: AnyGenerator<Case> {
        var n = 0
        return AnyGenerator {
            defer { n += 1 }
            let next = withUnsafePointer(&n) { UnsafePointer<Case>($0).memory }
            return next.hashValue == n ? next : nil
        }
    }
    
    @warn_unused_result
    static func enumerate() -> EnumerateSequence<AnySequence<Case>> {
        return AnySequence(generator).enumerate()
    }
    
    static var cases: [Case] {
        return Array(generator)
    }
    
    static var count: Int {
        return cases.count
    }
}
