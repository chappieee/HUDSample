import UIKit
import NVActivityIndicatorView
import Cartography

class NVActivityIndicatorViewController: UIViewController, NVActivityIndicatorViewable {
    
    var scrollView: UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollView = UIScrollView()
        self.view.addSubview(scrollView)
        constrain(scrollView) {
            $0.edges == $0.superview!.edges
        }
        
        let baseView = UIView(frame: self.view.bounds)
        baseView.backgroundColor = UIColor(red: CGFloat(237 / 255.0), green: CGFloat(85 / 255.0), blue: CGFloat(101 / 255.0), alpha: 1)
        scrollView.addSubview(baseView)
        
        let cols = 4
        let rows = 8
        let cellWidth = Int(self.view.frame.width / CGFloat(cols))
        let cellHeight = Int(self.view.frame.height / CGFloat(rows))
        
        (NVActivityIndicatorType.BallPulse.rawValue ... NVActivityIndicatorType.AudioEqualizer.rawValue).forEach {
            let x = ($0 - 1) % cols * cellWidth
            let y = ($0 - 1) / cols * cellHeight
            let frame = CGRect(x: x, y: y, width: cellWidth, height: cellHeight)
            let activityIndicatorView = NVActivityIndicatorView(frame: frame,
                type: NVActivityIndicatorType(rawValue: $0)!)
            let animationTypeLabel = UILabel(frame: frame)
            
            animationTypeLabel.text = String($0)
            animationTypeLabel.sizeToFit()
            animationTypeLabel.textColor = UIColor.whiteColor()
            animationTypeLabel.frame.origin.x += 5
            animationTypeLabel.frame.origin.y += CGFloat(cellHeight) - animationTypeLabel.frame.size.height
            
            activityIndicatorView.padding = 20
            if ($0 == NVActivityIndicatorType.Orbit.rawValue) {
                activityIndicatorView.padding = 0
            }
            baseView.addSubview(activityIndicatorView)
            baseView.addSubview(animationTypeLabel)
            activityIndicatorView.startAnimation()
            
            let button:UIButton = UIButton(frame: frame)
            button.tag = $0
            button.addTarget(self,
                action: #selector(buttonTapped(_:)),
                forControlEvents: UIControlEvents.TouchUpInside)
            baseView.addSubview(button)
        }
        
        scrollView.contentSize = self.view.bounds.size
        self.scrollView = scrollView
    }
    
    func buttonTapped(sender: UIButton) {
        let size = CGSize(width: 30, height:30)
        
        startActivityAnimating(size, message: "Loading...", type: NVActivityIndicatorType(rawValue: sender.tag)!)
        performSelector(#selector(delayedStopActivity),
                        withObject: nil,
                        afterDelay: 2.5)
    }
    
    func delayedStopActivity() {
        stopActivityAnimating()
    }
}
