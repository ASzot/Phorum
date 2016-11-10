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
    let keys = [
        "eventId",
        "userId"
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
            return self.getModelValue(key: "eventId") as! String
        }
        set(setVal) {
            self.setModelValue(key: "eventId", setValue: setVal)
        }
    }
    
    var userId:String {
        get {
            return self.getModelValue(key: "userId") as! String
        }
        set(setVal) {
            self.setModelValue(key: "userId", setValue: setVal)
        }
    }
    
    
    override func getTableName() -> String {
        return "subscribed_events"
    }
    
    override func createSelf() -> BaseModel {
        let subModel = SubscribedEvents()
        return subModel
    }
    
}
