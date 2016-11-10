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
        "name"
    ]
    
    convenience override init() {
        self.init(name: "", creatorId: "")
    }
    
    init(name:String, creatorId:String) {
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
    
    
    override func getTableName() -> String {
        return "events"
    }
    
    override func createSelf() -> BaseModel {
        let eventModel = EventModel()
        return eventModel
    }
}
