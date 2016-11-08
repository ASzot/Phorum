//
//  AccountModel.swift
//  Phorum
//
//  Created by Andrew Szot on 11/8/16.
//  Copyright © 2016 Scope. All rights reserved.
//

import Foundation
import Firebase

class AccountModel {
    var displayName: String
    
    init(displayName: String) {
        self.displayName = displayName
    }
    
    func store(firebaseEle:FIRDatabaseReference) {
        firebaseEle.child("display").setValue(self.displayName)
    }
}
