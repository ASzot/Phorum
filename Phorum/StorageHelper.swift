//
//  StorageHelper.swift
//  Phorum
//
//  Created by Andrew Szot on 11/10/16.
//  Copyright © 2016 Scope. All rights reserved.
//

import Foundation
import Firebase

class StorageHelper {
    static let IMAGE_PATH = "images"
    
    static func getStorageRef() -> FIRStorageReference {
        return FIRStorage.storage().reference()
    }
    
    static func uploadImage(imageData:Data, onUploaded: @escaping (FIRStorageMetadata?, Error?) -> ()) -> () {
        let imagesRef = StorageHelper.getStorageRef().child(StorageHelper.IMAGE_PATH)
        
        let _ = imagesRef.put(imageData, metadata:nil) { metadata, error in
            onUploaded(metadata, error)
        }
    }
}
