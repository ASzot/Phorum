//
//  SubscribedEvents.swift
//  Phorum
//
//  Created by Andrew Szot on 11/8/16.
//  Copyright © 2016 Scope. All rights reserved.
//

import Foundation
import Firebase


class SubscribedEventModel:BaseModel {
    let keys = [
        "event_id",
        "user_id"
    ]
    
    convenience override init() {
        self.init(eventId: "", userId: "")
    }
    
    init(eventId:String, userId:String) {
        super.init()
        self.clearModelValues(forKeys:self.keys)
        self.eventId = eventId
        self.userId = userId
    }
    
    var eventId:String {
        get {
            return self.getModelValue(key: "event_id") as! String
        }
        set(setVal) {
            self.setModelValue(key: "event_id", setValue: setVal)
        }
    }
    
    var userId:String {
        get {
            return self.getModelValue(key: "user_id") as! String
        }
        set(setVal) {
            self.setModelValue(key: "user_id", setValue: setVal)
        }
    }
    
    
    override func getTableName() -> String {
        return "subscribed_events"
    }
    
    override func createSelf() -> BaseModel {
        let subModel = SubscribedEventModel()
        return subModel
    }
    
}
