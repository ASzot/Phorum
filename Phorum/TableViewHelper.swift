//
//  TableViewHelper.swift
//  Phorum
//
//  Created by Andrew Szot on 1/9/17.
//  Copyright © 2017 Scope. All rights reserved.
//

import Foundation
import UIKit

class TableViewHelper {
    class func setEmtpyMessage(message:String, tableView:UITableView, vc: UIViewController) {
        let messageLabel = UILabel(frame: CGRect(x:0,y:0,width:vc.view.bounds.size.width, height:vc.view.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        tableView.backgroundView = messageLabel
        tableView.separatorStyle = .none
    }
}
