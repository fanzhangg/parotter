//
//  NetworkHelper.swift
//  Parotter
//
//  Created by Fan Zhang on 8/23/19.
//  Copyright © 2019 Fan Zhang. All rights reserved.
//

import Foundation
import SwifteriOS

class NetworkHelper {
    static var swifter = Swifter(consumerKey: "VQDFZmAR5pc0bWt1ja6ejK6Gs", consumerSecret: "45h2w0EbZmoYQGUb7PYT7KMekSR0wmfKuqhG1omPNxifKdv23y", oauthToken: "877897502808301568-kQ58dtIMpo4hQK21vTpe4qaxC6Gq95g", oauthTokenSecret: "pHln0haR7vzgs1GtC502VoiCKkI1YzCknaku4HDDyBL2G")
    static var tweets: [JSON] = []
    static var accessToken: Credential.OAuthAccessToken? = nil
}
