//
//  CreateAccountViewController.swift
//  Phorum
//
//  Created by Andrew Szot on 11/8/16.
//  Copyright © 2016 Scope. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var displayNameTxtField: UITextField!
    static let SHOW_MAIN_SEGUE = "CreateAccountModalShowMain"
    var userId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        self.displayNameTxtField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func onCreate(_ sender: Any) {
        let displayName = displayNameTxtField.text!
        assert(self.userId != "", "User id was not set")
        
        let createdAccount = AccountModel(id: self.userId, display: displayName)
        createdAccount.save()
        
        self.performSegue(withIdentifier: CreateAccountViewController.SHOW_MAIN_SEGUE, sender: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
