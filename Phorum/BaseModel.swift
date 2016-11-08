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
    func save()
    
    static func get(id:String) -> FIRDatabaseReference
    
    static func getAll()
}
