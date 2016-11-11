//
//  ViewController.swift
//  Phorum
//
//  Created by Andrew Szot on 11/7/16.
//  Copyright © 2016 Scope. All rights reserved.
//

import UIKit
import DigitsKit
import Firebase

class LoginViewController: UIViewController {
    static let SHOW_MAIN_SEGUE_ID = "ModalShowMain"
    static let SHOW_CREATE_ACCOUNT_SEGUE_ID = "ModalShowCreateAccount"
    
    var loggedInUserId = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let digits = Digits.sharedInstance()
        if let session = digits.session() {
            print("The user id is " + session.userID)
            // The session already exists. The user is logged in.
            checkUserExists(userId: session.userID)
        }
        else {
            let authButton = DGTAuthenticateButton(authenticationCompletion: { (session, error) in
                if (session != nil) {
                    // The user is now logged in.
                    self.checkUserExists(userId: session!.userID)
                }
                else {
                    NSLog("Authentication error: %@", error!.localizedDescription)
                }
            })
            authButton!.center = self.view.center
            self.view.addSubview(authButton!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == LoginViewController.SHOW_CREATE_ACCOUNT_SEGUE_ID {
            if let createAccountVC = segue.destination as? CreateAccountViewController {
                createAccountVC.userId = self.loggedInUserId
            }
        }
    }
    
    func checkUserExists(userId: String) {
        AccountModel().get(id: userId) { (userAccount) -> Void in
            if userAccount == nil {
                // Navigate to the account creation view.
                self.loggedInUserId = userId
                self.performSegue(withIdentifier: LoginViewController.SHOW_CREATE_ACCOUNT_SEGUE_ID, sender: nil)
            }
            else {
                // Navigate to the main view.
                print("Going to main")
                self.performSegue(withIdentifier: LoginViewController.SHOW_MAIN_SEGUE_ID, sender: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

