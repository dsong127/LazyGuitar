import Foundation
import UIKit

class TableViewHelper {
    class func emptyMessage(message: String, viewController: UIViewController, tableView: UITableView) {
        
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: viewController.view.bounds.size.width, height: viewController.view.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        tableView.backgroundView = messageLabel
        tableView.separatorStyle = .none
    }
    
    class func isDataEmpty(data: [Any]) -> Bool {
        if data.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    
}
