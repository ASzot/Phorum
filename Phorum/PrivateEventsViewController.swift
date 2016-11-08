//
//  PrivateEventsViewController.swift
//  Phorum
//
//  Created by Andrew Szot on 11/8/16.
//  Copyright © 2016 Scope. All rights reserved.
//

import UIKit

class PrivateEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet weak var displayTableView: UITableView!
    var allPrivateEvents: [EventModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
