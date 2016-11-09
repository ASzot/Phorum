//
//  CreateEventViewController.swift
//  Phorum
//
//  Created by Andrew Szot on 11/8/16.
//  Copyright © 2016 Scope. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController {
    var delegate:DefaultResponder? = nil
    @IBOutlet weak var eventNameTxtField: UITextField!
    @IBOutlet weak var errorMsgLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setErrorMsg(errorTxt: "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onCreateEventBtn(_ sender: Any) {
        let eventName = eventNameTxtField.text!
        let validateInputResult = validateInput(eventName: eventName)
        
        if validateInputResult == "Valid" {
            let createEvent = EventModel(eventName: eventName)
            // Save the event. 
            createEvent.save()
            
            // No need to pass any data back as the event is already saved.
            self.delegate?.onDone(senderType: CreateEventViewController.self, data: nil)
        }
        else {
            self.setErrorMsg(errorTxt: validateInputResult)
        }
    }
    
    @IBAction func onCancelBtn(_ sender: Any) {
        self.delegate?.onCancel(senderType: CreateEventViewController.self)
    }
    
    func setErrorMsg(errorTxt: String) {
        errorMsgLbl.text = errorTxt
    }
    
    func validateInput(eventName: String) -> String {
        if eventName == "" {
            return "Missing event name"
        }
        
        return "Valid"
    }
}