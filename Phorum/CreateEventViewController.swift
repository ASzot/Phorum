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
    var userId: String? = ""
    @IBOutlet weak var eventNameTxtField: UITextField!
    @IBOutlet weak var errorMsgLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assert(self.userId != "", "User id was not set")
        
        self.hideKeyboardWhenTappedAround()
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
            // Create the event and set the user as the owner of it.
            let createEvent = EventModel(name: eventName, creatorId: self.userId!)
            // Save the event. 
            createEvent.save()
            
            // Also subscribe the user to this event.
            let subEvent = SubscribedEventModel(eventId: createEvent.getId(), userId: self.userId!)
            subEvent.save()
            
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
