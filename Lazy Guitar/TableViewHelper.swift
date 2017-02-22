//
//  TableViewHelper.swift
//  Lazy Guitar
//
//  Created by Daniel Song on 2/21/17.
//  Copyright © 2017 Daniel Song. All rights reserved.
//

import Foundation
import UIKit

class TableViewHelper {
    class func emptyMessage(message:String, viewController:UITableViewController) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: viewController.view.bounds.size.width, height: viewController.view.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        viewController.tableView.backgroundView = messageLabel
        viewController.tableView.separatorStyle = .none
    }
    
    class func isDataEmpty(data: [Any]) -> Bool {
        if data.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    
}
