//
//  Utility.swift
//  Phorum
//
//  Created by Andrew Szot on 11/10/16.
//  Copyright © 2016 Scope. All rights reserved.
//

import Foundation

class UtilityHelper {
    static let EVENT_CODE_LENGTH = 4
    static let EVENT_CODE_VALUES = [
        "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
        "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
        "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"
    ]
    
    static func generateEventCode() -> String {
        var eventCode:String = ""
        for _ in 1...UtilityHelper.EVENT_CODE_LENGTH {
            let randomIndex = Int(arc4random_uniform(UInt32(UtilityHelper.EVENT_CODE_VALUES.count)))
            eventCode += UtilityHelper.EVENT_CODE_VALUES[randomIndex]
        }
        
        print("Event code is")
        print(eventCode)
        
        return eventCode
    }
}
