//
//  BaseModel.swift
//  Phorum
//
//  Created by Andrew Szot on 11/8/16.
//  Copyright © 2016 Scope. All rights reserved.
//

import Foundation
import Firebase

class BaseModel {
    var modelData:[String: Any] = ["id":""]
    
    
    func getTableName() -> String {
        fatalError("This method is abstract, it must be overriden.")
    }
    
    func createSelf() -> BaseModel {
        fatalError("This method is abstract, it must be overriden.")
    }
    
    
    func getModelValues() -> ([String: Any]) {
        return self.modelData
    }
    
    func setModelValues(setValues: [String: Any]) -> () {
        for (key, value) in setValues {
            self.modelData[key] = value
        }
    }
    
    func setModelNSValues(setValues:NSDictionary) -> () {
        for (key, value) in setValues {
            self.modelData[key as! String] = value
        }
    }
    
    func clearModelValues(forKeys:[String]) -> () {
        for key in forKeys {
            self.modelData[key] = ""
        }
    }
    
    func getModelValue(key: String) -> Any {
        return self.modelData[key]!
    }
    
    func setModelValue(key: String, setValue: Any) {
        self.modelData[key] = setValue
    }
    
    func getId() -> String {
        return self.modelData["id"] as! String
    }
    
    func setId(id:String) -> () {
        self.modelData["id"] = id
    }
    
    func save() -> () {
        var newEle:FIRDatabaseReference
        let modelId = getId()
        
        if modelId == "" {
            newEle = self.getFirebaseRef().childByAutoId()
            self.setId(id:newEle.key)
        }
        else {
            newEle = self.getFirebaseRef().child(modelId)
        }
        
        for (key, value) in self.getModelValues() {
            newEle.child(key).setValue(value)
        }
    }
    
    func getFirebaseRef() -> FIRDatabaseReference {
        return FIRDatabase.database().reference(withPath: getTableName())
    }
    
    func get(id:String, onComplete: @escaping (BaseModel?) -> ()) -> () {
        // Query firebase.
        let ref = self.getFirebaseRef()
        ref.child(id).observe(.value, with: { snapshot in
            if let snapshotData = snapshot.value as? NSDictionary {
                // Set all of the data.
                let retValue = self.createSelf()
                retValue.setModelNSValues(setValues: snapshotData)
                retValue.setId(id:snapshot.key)
                
                onComplete(retValue)
            }
            else {
                // No such values exists.
                onComplete(nil)
            }
        })
    }
    
    func getWhereEquals(key:String, compareValue:String, onComplete: @escaping ([BaseModel]?) -> ()) {
        let ref = self.getFirebaseRef()
        
        ref.queryOrdered(byChild: key).queryEqual(toValue:compareValue).observe(.value, with: { snapshot in
            if let readSnapshot = snapshot.value as? NSDictionary {
                // Convert to the model objects.
                
                var retModels:[BaseModel] = []
                for (id, modelData) in readSnapshot {
                    let foundModel = self.createSelf()
                    foundModel.setModelValues(setValues: (modelData as! [String: Any]))
                    foundModel.setId(id: (id as! String))
                    retModels.append(foundModel)
                }
                
                onComplete(retModels)
            }
            else {
                onComplete(nil)
            }
        })
    }
}
