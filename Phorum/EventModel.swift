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
    let keys = [
        "creator_id",
        "name",
        "event_id",
        "event_code"
    ]
    
    convenience override init() {
        self.init(name: "", creatorId: "", eventCode:"")
    }
    
    convenience init(name:String, creatorId:String) {
        let genCode = UtilityHelper.generateEventCode()
        self.init(name: name, creatorId: creatorId, eventCode: genCode)
    }
    
    init(name:String, creatorId:String, eventCode:String) {
        super.init()
        self.clearModelValues(forKeys:self.keys)
        self.name = name
        self.creatorId = creatorId
    }
    
    var name:String {
        get {
            return self.getModelValue(key: "name") as! String
        }
        set(setVal) {
            self.setModelValue(key: "name", setValue: setVal)
        }
    }
    
    var creatorId:String {
        get {
            return self.getModelValue(key: "creator_id") as! String
        }
        set(setVal) {
            self.setModelValue(key: "creator_id", setValue: setVal)
        }
    }
    
    var genCode:String {
        get {
            return self.getModelValue(key: "event_code") as! String
        }
    }
    
    
    override func getTableName() -> String {
        return "events"
    }
    
    override func createSelf() -> BaseModel {
        let eventModel = EventModel()
        return eventModel
    }
}
