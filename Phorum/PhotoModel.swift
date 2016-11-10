//
//  PhotoModel.swift
//  Phorum
//
//  Created by Andrew Szot on 11/10/16.
//  Copyright © 2016 Scope. All rights reserved.
//

import Foundation

class PhotoModel:BaseModel {
    let keys = [
        "url",
        "user_id",
        "event_id"
    ]
    
    convenience override init() {
        self.init(userId: "", eventId: "", url: "")
    }
    
    init(userId:String, eventId:String, url:String) {
        super.init()
        self.clearModelValues(forKeys:self.keys)
        self.url = url
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
    
    var url:String {
        get {
            return self.getModelValue(key: "url") as! String
        }
        set(setVal) {
            self.setModelValue(key: "url", setValue: setVal)
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
        return "photos"
    }
    
    override func createSelf() -> BaseModel {
        let subModel = PhotoModel()
        return subModel
    }
}
