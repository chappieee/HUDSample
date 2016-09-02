import UIKit
import SVProgressHUD
import GCDKit

// https://github.com/SVProgressHUD/SVProgressHUD
// SVProgressHUD は内部でカウンタを保持していて、 show や showWithStatus でインジケーターを表示すると1増える。
// popActivity を呼び出すとカウンタが 1 減る。 そして、カウンタが 0 になるとインジケーターが閉じられる。
// dismiss が現在表示しているインジケーターを問答無用で閉じてしまう。
final class SVViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "SVProgressHUD Samples"
        self.tableView?.rowHeight = 70
    }
    
    private func doSomeWork() {
        sleep(3)
    }
    
    @IBOutlet weak var tableView: UITableView?
    
}

extension SVViewController: UITableViewDataSource, UITableViewDelegate {
    
    enum Sections: Int, EnumEnumerable, CustomStringConvertible {
        case userInteractionEnabled
        case userInteractionDisabled
        
        var description: String {
            switch self {
            case .userInteractionEnabled:  return "user Interaction Enabled  (マスク無)"
            case .userInteractionDisabled: return "user Interaction Disabled (マスク有)"
            }
        }
    }
    
    enum Section1Rows: Int, EnumEnumerable, CustomStringConvertible {
        case row1
        case row2
        case row3
        case row4
        case row5
        case row6
        case row7
        case row8
        case row9
        case row10
        
        var description: String {
            switch self {
            case .row1:  return "アニメーション - Flat   \nスタイル - Light \nテキスト - なし"
            case .row2:  return "アニメーション - Native \nスタイル - Light \nテキスト - なし"
            case .row3:  return "アニメーション - Flat   \nスタイル - Dark  \nテキスト - なし"
            case .row4:  return "アニメーション - Native \nスタイル - Dark  \nテキスト - なし"
            case .row5:  return "アニメーション - Flat   \nスタイル - Light \nテキスト - あり"
            case .row6:  return "アニメーション - Flat   \nスタイル - Dark  \nテキスト - あり"
            case .row7:  return "Success Mark \nスタイル - Light"
            case .row8:  return "Success Mark \nスタイル - Dark"
            case .row9:  return "Error Mark \nスタイル - Light"
            case .row10: return "Error Mark \nスタイル - Dark"
            }
        }
    }
    
    enum Section2Rows: Int, EnumEnumerable, CustomStringConvertible {
        case row1
        case row2
        
        var description: String {
            switch self {
            case .row1: return "マスク - クリア   \nアニメーション - Flat"
            case .row2: return "マスク - ブラック \nアニメーション - Flat"
            }
        }
    }
    
    private func dismiss() {
        GCDQueue.Main.after(3) {
            //SVProgressHUD.dismiss()
            SVProgressHUD.popActivity()
        }
    }
    
    // セクション1 - マスクなし ======================================================
    
    private func executeSection1Row1() {
        // マスクなし
        // アニメーション - Flat(Default)
        // スタイル - Light(Default)
        SVProgressHUD.show()
        self.dismiss()
    }
    private func executeSection1Row2() {
        // マスクなし
        // アニメーション - Native(UIActivityIndicatorView)
        // スタイル - Light(Default)
        SVProgressHUD.setDefaultAnimationType(.Native)
        SVProgressHUD.show()
        self.dismiss()
    }
    private func executeSection1Row3() {
        // マスクなし
        // アニメーション - Flat(Default)
        // スタイル - Dark
        SVProgressHUD.setDefaultStyle(.Dark)
        SVProgressHUD.show()
        self.dismiss()
    }
    private func executeSection1Row4() {
        // マスクなし
        // アニメーション - Native(UIActivityIndicatorView)
        // スタイル - Light(Default)
        SVProgressHUD.setDefaultAnimationType(.Native)
        SVProgressHUD.setDefaultStyle(.Dark)
        SVProgressHUD.show()
        self.dismiss()
    }
    private func executeSection1Row5() {
        // マスクなし
        // アニメーション - Flat(Default)
        // スタイル - Dark
        // テキストあり
//        SVProgressHUD.setDefaultAnimationType(.Native)
//        SVProgressHUD.setDefaultStyle(.Dark)
        
        SVProgressHUD.showWithStatus("loading...")
        self.dismiss()
    }
    private func executeSection1Row6() {
        // マスクなし
        // アニメーション - Flat(Default)
        // スタイル - Dark
        // テキストあり
        SVProgressHUD.setDefaultStyle(.Dark)
        SVProgressHUD.showWithStatus("loading...")
        self.dismiss()
    }
    private func executeSection1Row7() {
        // マスクなし
        // スタイル - Light(Default)
        // Success Mark
        // テキストあり
        SVProgressHUD.showSuccessWithStatus("成功！") // テキスト無しだとバランスが悪い
        self.dismiss()
    }
    private func executeSection1Row8() {
        // マスクなし
        // スタイル - Dark
        // Success Mark
        // テキストあり
        SVProgressHUD.setDefaultStyle(.Dark)
        SVProgressHUD.showSuccessWithStatus("保存しました")
        self.dismiss()
    }
    private func executeSection1Row9() {
        // マスクなし
        // スタイル - Light(Default)
        // Error Mark
        // テキストあり
        SVProgressHUD.showErrorWithStatus("エラーが発生しました")
        self.dismiss()
    }
    private func executeSection1Row10() {
        // マスクなし
        // スタイル - Dark
        // Error Mark
        // テキストあり
        SVProgressHUD.setDefaultStyle(.Dark)
        SVProgressHUD.showErrorWithStatus("エラーが発生しました")
        self.dismiss()
    }
    
    
    // セクション2 - マスクあり ======================================================
    
    private func executeSection2Row1() {
        // マスク - クリア
        // アニメーション - Flat(Default)
        SVProgressHUD.setDefaultMaskType(.Clear)
        self.executeSection1Row1()
    }
    
    private func executeSection2Row2() {
        // マスク - ブラック
        // アニメーション - Flat(Default)
        SVProgressHUD.setDefaultMaskType(.Black)
        self.executeSection1Row1()
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let sections = Sections(rawValue: indexPath.section) else { fatalError() }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.font = UIFont.systemFontOfSize(14)
        cell.textLabel?.numberOfLines = 3
        
        switch sections {
            
        case .userInteractionEnabled:
            guard let rows = Section1Rows(rawValue: indexPath.row) else { fatalError() }
           cell.textLabel?.text = rows.description
            
        case .userInteractionDisabled:
            guard let rows = Section2Rows(rawValue: indexPath.row) else { fatalError() }
            cell.textLabel?.text = rows.description
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = Sections(rawValue: section) else { fatalError() }
        
        switch sections {
        case .userInteractionEnabled:  return Section1Rows.count
        case .userInteractionDisabled: return Section2Rows.count
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return Sections.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        guard let sections = Sections(rawValue: indexPath.section) else { fatalError() }
        
        print("SVProgressHUD.isVisible: \(SVProgressHUD.isVisible())")
        
        // Defaults
        SVProgressHUD.setDefaultStyle(.Light)
        SVProgressHUD.setDefaultAnimationType(.Flat)
        SVProgressHUD.setDefaultMaskType(.None)
        
        switch sections {
            
        case .userInteractionEnabled:
            guard let rows = Section1Rows(rawValue: indexPath.row) else { fatalError() }
            
            switch rows {
            case .row1:  self.executeSection1Row1()
            case .row2:  self.executeSection1Row2()
            case .row3:  self.executeSection1Row3()
            case .row4:  self.executeSection1Row4()
            case .row5:  self.executeSection1Row5()
            case .row6:  self.executeSection1Row6()
            case .row7:  self.executeSection1Row7()
            case .row8:  self.executeSection1Row8()
            case .row9:  self.executeSection1Row9()
            case .row10: self.executeSection1Row10()
            }
            
        case .userInteractionDisabled:
            guard let rows = Section2Rows(rawValue: indexPath.row) else { fatalError() }
            
            switch rows {
            case .row1: self.executeSection2Row1()
            case .row2: self.executeSection2Row2()
            }
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        guard let sections = Sections(rawValue: section) else { fatalError() }
        return sections.description
    }
}
