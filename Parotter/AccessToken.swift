//
//  AccessToken.swift
//  Parotter
//
//  Created by Fan Zhang on 8/29/19.
//  Copyright © 2019 Fan Zhang. All rights reserved.
//

import UIKit
import os.log

/// A helper class to permenantly store access token
class AccessToken: NSObject, NSCoding {
    var key: String
    var secret: String
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("token")
    
    // MARK: types
    struct PropertyKey {
        static let key = "token"
        static let secret = "secret"
    }
    
    // MARK: Initialization
    init?(token: String, secret: String) {
        // Must not be empty
        guard !token.isEmpty else {
            os_log("Token is empty", log: OSLog.default, type: .debug)
            return nil
        }
        guard !secret.isEmpty else {
            os_log("Secret is empty", log: OSLog.default, type: .debug)
            return nil
        }
        
        self.key = token
        self.secret = secret
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(key, forKey: PropertyKey.key)
        aCoder.encode(secret, forKey: PropertyKey.secret)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let token = aDecoder.decodeObject(forKey: PropertyKey.key) as? String else {
            os_log("Unable to decode the token", log: OSLog.default, type: .debug)
            return nil
        }
        guard let secret = aDecoder.decodeObject(forKey: PropertyKey.secret) as? String else {
            os_log("Unable to decode the secret token", log: OSLog.default, type: .debug)
            return nil
        }
        self.init(token: token, secret: secret)
    }
}
