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
    var screenName: String
    var userID: String
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("token")
    
    // MARK: types
    struct PropertyKey {
        static let key = "token"
        static let secret = "secret"
        static let screenName = "screenName"
        static let userID = "userID"
    }
    
    // MARK: Initialization
    init?(token: String, secret: String, screenName: String, userID: String) {
        // Must not be empty
        guard !token.isEmpty else {
            os_log("Token is empty", log: OSLog.default, type: .error)
            return nil
        }
        guard !secret.isEmpty else {
            os_log("Secret is empty", log: OSLog.default, type: .error)
            return nil
        }
        guard !screenName.isEmpty else {
            os_log("Screen Name is empty", log: OSLog.default, type: .error)
            return nil
        }
        guard !userID.isEmpty else {
            os_log("User ID is empty", log: OSLog.default, type: .error)
            return nil
        }
        
        self.key = token
        self.secret = secret
        self.screenName = screenName
        self.userID = userID
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(key, forKey: PropertyKey.key)
        aCoder.encode(secret, forKey: PropertyKey.secret)
        aCoder.encode(screenName, forKey: PropertyKey.screenName)
        aCoder.encode(userID, forKey: PropertyKey.userID)
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
        guard let screenName = aDecoder.decodeObject(forKey: PropertyKey.screenName) as? String else {
            os_log("Unable to decode the screen name", log: OSLog.default, type: .debug)
            return nil
        }
        guard let userID = aDecoder.decodeObject(forKey: PropertyKey.userID) as? String else {
            os_log("Unable to decode the user ID", log: OSLog.default, type: .debug)
            return nil
        }
        self.init(token: token, secret: secret, screenName: screenName, userID: userID)
    }
}
