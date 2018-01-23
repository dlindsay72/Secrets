//
//  Note.swift
//  Secrets
//
//  Created by Dan Lindsay on 2018-01-23.
//  Copyright © 2018 Dan Lindsay. All rights reserved.
//

import UIKit

class Note {
    
    public private(set) var message: String
    public var lockStatus: LockStatus
    
    init(message: String, lockStatus: LockStatus) {
        self.message = message
        self.lockStatus = lockStatus
    }
}
