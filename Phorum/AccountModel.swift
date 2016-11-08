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
    
    func save() {
        let newEle = AccountModel.get(id: userId)
        newEle.child("display").setValue(self.displayName)
    }
    
    static func get(id:String) -> FIRDatabaseReference {
        return AccountModel.getFirebaseRef().child(id)
    }
    
    static func getAll() {
        let ref = AccountModel.getFirebaseRef()
        ref.observe(.value, with: { snapshot in
            print(snapshot.value)
        })
    }
}
