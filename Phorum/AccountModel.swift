//
//  AccountModel.swift
//  Phorum
//
//  Created by Andrew Szot on 11/8/16.
//  Copyright © 2016 Scope. All rights reserved.
//

import Foundation
import Firebase

class AccountModel:BaseModel {
    let keys = [
        "display"
    ]
    
    convenience override init() {
        self.init(id: "", display: "")
    }
    
    init(id:String, display:String) {
        super.init()
        self.clearModelValues(forKeys:self.keys)
        self.displayName = display
        self.id = id
    }
    
    var id:String {
        get {
            return self.getModelValue(key: "id") as! String
        }
        set(setVal) {
            self.setModelValue(key: "id", setValue: setVal)
        }
    }
    
    var displayName:String {
        get {
            return self.getModelValue(key: "display") as! String
        }
        set(setVal) {
            self.setModelValue(key: "display", setValue: setVal)
        }
    }
    
    
    override func getTableName() -> String {
        return "users"
    }
    
    override func createSelf() -> BaseModel {
        let accountModel = AccountModel()
        return accountModel
    }
}
