//
//  DefaultResponder.swift
//  Phorum
//
//  Created by Andrew Szot on 11/8/16.
//  Copyright © 2016 Scope. All rights reserved.

import Foundation

protocol DefaultResponder {
    func onDone(senderType: Any.Type, data: Any?)
    func onCancel(senderType: Any.Type)
}
