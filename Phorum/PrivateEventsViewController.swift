//
//  PrivateEventsViewController.swift
//  Phorum
//
//  Created by Andrew Szot on 11/8/16.
//  Copyright © 2016 Scope. All rights reserved.
//

import UIKit
import DigitsKit

class PrivateEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DefaultResponder  {
    @IBOutlet weak var displayTableView: UITableView!
    var allPrivateEvents: [EventModel] = []
    var userId: String? = ""
    static let CELL_REUSE_IDEN = "EventTableViewCellIden"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "EventTableViewCell", bundle: nil)
        self.displayTableView.dataSource = self
        self.displayTableView.delegate = self
        self.displayTableView.register(nib, forCellReuseIdentifier: PrivateEventsViewController.CELL_REUSE_IDEN)
        self.displayTableView.rowHeight = 80

        self.userId = Digits.sharedInstance().session()?.userID
        
        self.fetchEvents()
    }
    
    func fetchEvents() {
        // Get all of the events the user is subscribed to.
        SubscribedEventModel().getWhereEquals(key: "user_id", compareValue: self.userId!) { (foundModels) in
            if let subbedEvents = foundModels as? [SubscribedEventModel] {
                self.allPrivateEvents = []
                
                for subbedEvent in subbedEvents {
                    let eventId = subbedEvent.eventId
                    
                    // Retrieve the associated event.
                    EventModel().get(id: eventId) { (event) in
                        if let eventModel = event as? EventModel {
                            self.allPrivateEvents.append(eventModel)
                            
                            // Are all of the events loaded? 
                            if self.allPrivateEvents.count == subbedEvents.count {
                                // Reload the table.
                                self.displayTableView.reloadData()
                            }
                        }
                        else {
                            
                        }
                    }
                }
            }
            else {
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let createEventVC = segue.destination as? CreateEventViewController {
            createEventVC.delegate = self
            createEventVC.userId = self.userId
        }
    }
    
    func onDone(senderType: Any.Type, data: Any?) {
        self.dismiss(animated: true, completion: {});
        
        // Update events.
        self.fetchEvents()
    }
    
    func onCancel(senderType: Any.Type) {
        self.dismiss(animated: true, completion: {});
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allPrivateEvents.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:EventTableViewCell = self.displayTableView.dequeueReusableCell(withIdentifier: PrivateEventsViewController.CELL_REUSE_IDEN) as! EventTableViewCell
        
        let privateEvent = self.allPrivateEvents[indexPath.row]
        
        cell.eventNameLbl.text = privateEvent.name
        
        return cell
    }

}
