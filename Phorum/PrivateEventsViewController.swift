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

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let userId = Digits.sharedInstance().session().userID
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let createEventVC = segue.destination as? CreateEventViewController {
            createEventVC.delegate = self
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
