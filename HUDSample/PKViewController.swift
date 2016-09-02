import UIKit
import PKHUD

// https://github.com/pkluz/PKHUD
final class PKViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "PKHUD Samples"
        self.tableView?.rowHeight = 70
    }
 
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func showError() {
        HUD.flash(.LabeledError(title: "エラー", subtitle: "エラーが発生しました。\n時間をおいて再度アクセスしてください。"), delay: 2.0)
    }
    
    @IBOutlet weak var tableView: UITableView?
}

extension PKViewController: UITableViewDataSource, UITableViewDelegate {
    
    enum Sections: Int, EnumEnumerable {
        case PKHUD
    }
    
    enum PKHUDRows: Int, EnumEnumerable {
        case row1
        case row2
        case row3
        case row4
        case row5
        case row6
        case row7
        case row8
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let sections = Sections(rawValue: indexPath.section) else { fatalError() }
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.font = UIFont.systemFontOfSize(12)
        cell.textLabel?.numberOfLines = 2
        
        switch sections {
            
        case .PKHUD:
            guard let rows = PKHUDRows(rawValue: indexPath.row) else { fatalError() }
            switch rows {
            case .row1:
                cell.textLabel?.text = "[Dim無][ブロック無][SystemActivity]"
            case .row2:
                cell.textLabel?.text = "[Dim無][ブロック無][プログレス]"
            case .row3:
                cell.textLabel?.text = "[Dim無][ブロック無][プログレス + サブテキスト]"
            case .row4:
                cell.textLabel?.text = "[Dim有][ブロック無][プログレス-> 成功]"
            case .row5:
                cell.textLabel?.text = "[Dim無][ブロック無][成功 + サブテキスト]"
            case .row6:
                cell.textLabel?.text = "[Dim無][ブロック無][エラー + テキスト + サブテキスト]"
            case .row7:
                cell.textLabel?.text = "[Dim無][ブロック無][テキスト]"
            case .row8:
                cell.textLabel?.text = "[Dim無][ブロック無][画像ローテート + テキスト]"
            }
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = Sections(rawValue: section) else { fatalError() }
        
        switch sections {
        case .PKHUD: return PKHUDRows.count
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return Sections.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        guard let sections = Sections(rawValue: indexPath.section) else { fatalError() }
        
        print("HUD.isVisible: \(HUD.isVisible)")
        
        // defaults
        HUD.dimsBackground = true
        HUD.allowsInteraction = false
        
        switch sections {
            
        case .PKHUD:
            
            guard let rows = PKHUDRows(rawValue: indexPath.row) else { fatalError() }
            
            switch rows {
                
            case .row1:
                HUD.dimsBackground = false
                HUD.allowsInteraction = true
                HUD.flash(.SystemActivity, delay: 2.0)

            case .row2:
                HUD.dimsBackground = false
                HUD.allowsInteraction = true
                HUD.show(.Progress)
                
                delay(3.0) {
                    HUD.hide()
                }
                
            case .row3:
                HUD.dimsBackground = false
                HUD.allowsInteraction = true
                HUD.show(.LabeledProgress(title: "取得中", subtitle: "取得中"))
                
                delay(3.0) {
                    HUD.hide()
                }
                
            case .row4:
                HUD.dimsBackground = true
                HUD.allowsInteraction = true
                HUD.show(.Progress)
                
                delay(3.0) {
                    HUD.flash(.Success, delay: 1.0) // 表示後、1秒後に消える
                }
                
            case .row5:
                HUD.dimsBackground = false
                HUD.allowsInteraction = true
                
                do {
                    //HUD.flash(.Success, delay: 2.0)
                    HUD.flash(.LabeledSuccess(title: "", subtitle: "保存しました"), delay: 2.0)
                }

//                do {
//                    // 上と同じ
//                    HUD.show(.LabeledSuccess(title: "", subtitle: "保存しました"))
//                    HUD.hide(afterDelay: 2.0)
//                }
                
            case .row6:
                HUD.dimsBackground = false
                HUD.allowsInteraction = true
                self.showError()
                
            case .row7:
                HUD.dimsBackground = false
                HUD.allowsInteraction = true
   
                HUD.flash(.Label("Hello World!"), delay: 2.0) { _ in
                    print("completion!")
                }
                
            case .row8:
                HUD.dimsBackground = false
                HUD.allowsInteraction = true
                HUD.show(.LabeledRotatingImage(image: UIImage(named: "Checkmark")!, title: "取得中", subtitle: nil))
                
                delay(3.0) {
                    HUD.hide()
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch Sections(rawValue: section) {
        case .PKHUD?: return "PKHUD"
        default:      return nil
        }
    }
}
