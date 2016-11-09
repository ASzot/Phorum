//
//  SubscribedEvents.swift
//  Phorum
//
//  Created by Andrew Szot on 11/8/16.
//  Copyright © 2016 Scope. All rights reserved.
//

import Foundation
import Firebase


class SubscribedEvents:BaseModel {
    static let TABLE_NAME = "subscribedevents"
    var userId: String
    var eventId: String
    var subscriptionId: String
    
    convenience init(eventId: String, userId: String) {
        self.init(eventId: eventId, userId: userId, subscriptionId: "")
    }
    
    init (eventId: String, userId: String, subscriptionId: String) {
        self.eventId = eventId
        self.userId = userId
        self.subscriptionId = subscriptionId
    }
    
    static func getFirebaseRef() -> FIRDatabaseReference {
        return FIRDatabase.database().reference(withPath: SubscribedEvents.TABLE_NAME)
    }
    
    static func get(id:String, onComplete: @escaping (Any?) -> ()) -> () {
        ModelHelper.getResults(firebaseRef: EventModel.getFirebaseRef(), id: id) { (subData) -> Void in
            // Convert the object to an AccountModel
            if let sub = subData {
                let userId = sub["user_id"] as! String
                let eventId = sub["event_id"] as! String
                onComplete(SubscribedEvents(eventId: eventId, userId: userId, subscriptionId: id))
            }
            else {
                onComplete(nil)
            }
        }
    }
    
    static func getAll(onComplete: @escaping (Any?) -> ()) -> () {
        
    }
    
    func save() {
        let newEle = self.subscriptionId == "" ? SubscribedEvents.getFirebaseRef().childByAutoId() : SubscribedEvents.getFirebaseRef().child(self.subscriptionId)
        newEle.child("user_id").setValue(self.userId)
        newEle.child("event_id").setValue(self.eventId)
    }
    
}
