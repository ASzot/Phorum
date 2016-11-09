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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.userId = Digits.sharedInstance().session()?.userID
    }
    
    func fetchEvents() {
        
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
    }
    
    func onCancel(senderType: Any.Type) {
        self.dismiss(animated: true, completion: {});
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allPrivateEvents.count;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}
