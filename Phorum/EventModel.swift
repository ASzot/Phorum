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
    
    static func get(id:String) -> FIRDatabaseReference {
        return EventModel.getFirebaseRef().child(id)
    }
    
    static func getAll() {
        
    }
    
    func save() {
        let newEle = EventModel.get(id: self.eventId)
        newEle.child("name").setValue(self.eventName)
    }
}
