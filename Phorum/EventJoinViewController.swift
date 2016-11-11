//
//  EventJoinViewController.swift
//  Phorum
//
//  Created by Andrew Szot on 11/11/16.
//  Copyright © 2016 Scope. All rights reserved.
//

import UIKit

class EventJoinViewController: UIViewController {
    @IBOutlet weak var eventCodeTxtBox: UITextField!
    @IBOutlet weak var errorMsgLbl: UILabel!
    var delegate:DefaultResponder?
    var userId: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.errorMsgLbl.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onJoinBtn(_ sender: Any) {
        // Get what event the user entered a code for.
        let enteredId = eventCodeTxtBox.text!
        EventModel().getWhereEquals(key: "event_id", compareValue: enteredId) { (models) in
            if let eventModels = models as? [EventModel] {
                if eventModels.count > 1 {
                    print("Event ID clash")
                }
                else {
                    let eventModel = eventModels.first!
                    // Subscribe the user to this event.
                    let subModel = SubscribedEventModel(eventId: eventModel.getId(), userId: self.userId!)
                    subModel.save()
                    
                    DispatchQueue.main.async() { () -> Void in
                        self.delegate?.onDone(senderType: EventJoinViewController.self, data: nil)
                    }
                }
            }
            else {
                DispatchQueue.main.async() { () -> Void in
                    self.errorMsgLbl.text = "Invalid code"
                }
            }
        }
    }
    @IBAction func onCancelBtn(_ sender: Any) {
        delegate?.onCancel(senderType: EventJoinViewController.self)
    }
}
