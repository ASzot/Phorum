//
//  HideKeyboardHelper.swift
//  Phorum
//
//  Created by Andrew Szot on 11/8/16.
//  Copyright © 2016 Scope. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
