//
//  BaseModel.swift
//  Phorum
//
//  Created by Andrew Szot on 11/8/16.
//  Copyright © 2016 Scope. All rights reserved.
//

import Foundation
import Firebase

protocol BaseModel {
    
    func save() -> ()
    
    static func get(id:String, onComplete: @escaping (Any?) -> ()) -> ()
    
    static func getAll(onComplete: @escaping (Any?) -> ()) -> ()
}

class ModelHelper {
    static func getResults(firebaseRef: FIRDatabaseReference, id: String, onComplete: @escaping (NSDictionary?) -> ()) {
        firebaseRef.child(id).observe(.value, with: { snapshot in
            if let event = snapshot.value as! NSDictionary? {
                onComplete(event)
            }
            else {
                onComplete(nil)
            }
        })
    }
}
