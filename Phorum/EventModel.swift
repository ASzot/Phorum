//
//  EventModel.swift
//  Phorum
//
//  Created by Andrew Szot on 11/8/16.
//  Copyright © 2016 Scope. All rights reserved.
//

import Foundation
import Firebase

class EventModel:BaseModel {
    static let TABLE_NAME = "events"
    var eventName: String
    var eventId: String
    var creatorId: String
    
    convenience init(eventName: String, creatorId: String) {
        self.init(eventName: eventName, creatorId: creatorId, eventId: "")
    }
    
    init (eventName: String, creatorId: String, eventId: String) {
        self.eventName = eventName
        self.eventId = eventId
        self.creatorId = creatorId
    }
    
    static func getFirebaseRef() -> FIRDatabaseReference {
        return FIRDatabase.database().reference(withPath: EventModel.TABLE_NAME)
    }
    
    static func get(id:String, onComplete: @escaping (Any?) -> ()) -> () {
        ModelHelper.getResults(firebaseRef: EventModel.getFirebaseRef(), id: id) { (eventData) -> Void in
            // Convert the object to an AccountModel
            if let event = eventData {
                let name = event["name"] as! String
                let creatorId = event["creator_id"] as! String
                onComplete(EventModel(eventName: name, creatorId: creatorId, eventId: id))
            }
            else {
                onComplete(nil)
            }
        }
    }
    
    static func getAll(onComplete: @escaping (Any?) -> ()) -> () {
        
    }
    
    func save() {
        let newEle = self.eventId == "" ? EventModel.getFirebaseRef().childByAutoId() : EventModel.getFirebaseRef().child(self.eventId)
        newEle.child("name").setValue(self.eventName)
        newEle.child("creator_id").setValue(self.creatorId)
    }
}
