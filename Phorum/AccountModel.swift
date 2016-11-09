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
    static let TABLE_NAME = "users"
    var displayName: String
    var userId: String
    
    init(displayName: String, userId: String) {
        self.displayName = displayName
        self.userId = userId
    }
    
    
    static func getFirebaseRef() -> FIRDatabaseReference {
        return FIRDatabase.database().reference(withPath: AccountModel.TABLE_NAME)
    }
    
    static func get(id:String, onComplete: @escaping (Any?) -> ()) -> () {
        ModelHelper.getResults(firebaseRef: AccountModel.getFirebaseRef(), id: id) { (accountData) -> Void in
            // Convert the object to an AccountModel
            if let account = accountData {
                let display = account["display"] as! String
                onComplete(AccountModel(displayName: display, userId: id))
            }
            else {
                onComplete(nil)
            }
        }
    }
    
    static func getAll(onComplete: @escaping (Any?) -> ()) -> () {
        
    }
    
    func save() {
        let newEle = EventModel.getFirebaseRef().child(self.userId)
        newEle.child("display").setValue(self.displayName)
    }
}
