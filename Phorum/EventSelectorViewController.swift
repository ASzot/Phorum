//
//  EventSelectorViewController.swift
//  Phorum
//
//  Created by Andrew Szot on 11/10/16.
//  Copyright © 2016 Scope. All rights reserved.
//

import UIKit

class EventSelectorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    static let CELL_REUSE_IDEN = "EventSelectTableViewCell"
    @IBOutlet weak var displayTableView: UITableView!
    var displayEvents:[EventModel] = []
    var selectedIndex:Int = -1
    var imageData:Data?
    var userId:String?
    var delegate:DefaultResponder?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.displayTableView.delegate = self
        self.displayTableView.dataSource = self

        // Load all of the events that a user is a part of.
        SubscribedEventModel().getWhereEquals(key: "user_id", compareValue: self.userId!) { models in
            if let subModels = models as? [SubscribedEventModel] {
                for subModel in subModels {
                    // Get the associated event.
                    EventModel().get(id: subModel.eventId) { model in
                        let eventModel = model as! EventModel
                        self.displayEvents.append(eventModel)
                        
                        if self.displayEvents.count == subModels.count {
                            // All ofthe associated events have been fetched.
                            self.displayTableView.reloadData()
                        }
                    }
                }
            }
            else {
                print("User owns no models")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayEvents.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:EventSelectTableViewCell = self.displayTableView.dequeueReusableCell(withIdentifier: EventSelectorViewController.CELL_REUSE_IDEN) as! EventSelectTableViewCell
        
        let dispEvent = self.displayEvents[indexPath.row]
        cell.eventNameLbl.text = dispEvent.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
    }
    
    @IBAction func onCancelBtn(_ sender: Any) {
        self.delegate!.onCancel(senderType: EventSelectorViewController.self)
    }
    
    @IBAction func onSendBtn(_ sender: Any) {
        if self.selectedIndex != -1 {
            let selectedEvent = self.displayEvents[self.selectedIndex]
            // Upload the image data for this event.
            StorageHelper.uploadImage(imageData:self.imageData!) { metadata, error in
                if error == nil {
                    let downloadURL = metadata!.downloadURL()!.absoluteString
                    let eventId = selectedEvent.getId()
                    
                    let photoModel = PhotoModel(userId: self.userId!, eventId: eventId, url: downloadURL)
                    photoModel.save()
                    
                    self.delegate!.onDone(senderType: EventSelectorViewController.self, data: nil)
                }
                else {
                    print("Error uploading")
                }
            }
        }
    }
}
