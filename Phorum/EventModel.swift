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
    
    init(eventName: String, eventId: String) {
        self.eventName = eventName
        self.eventId = eventId
    }
    
    static func getFirebaseRef() -> FIRDatabaseReference {
        return FIRDatabase.database().reference(withPath: EventModel.TABLE_NAME)
    }
    
    static func get(id:String, onComplete: @escaping (Any?) -> ()) -> () {
        ModelHelper.getResults(firebaseRef: EventModel.getFirebaseRef(), id: id) { (eventData) -> Void in
            // Convert the object to an AccountModel
            if let event = eventData {
                let name = event["name"] as! String
                onComplete(EventModel(eventName: name, eventId: id))
            }
            else {
                onComplete(nil)
            }
        }
    }
    
    static func getAll(onComplete: @escaping (Any?) -> ()) -> () {
        
    }
    
    func save() {
        let newEle = EventModel.getFirebaseRef().child(eventId)
        newEle.child("name").setValue(self.eventName)
    }
}
