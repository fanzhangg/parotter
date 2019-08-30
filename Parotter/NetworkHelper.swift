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
    static var swifter = Swifter(consumerKey: "VQDFZmAR5pc0bWt1ja6ejK6Gs", consumerSecret: "45h2w0EbZmoYQGUb7PYT7KMekSR0wmfKuqhG1omPNxifKdv23y")
    static var tweets: [JSON] = []
    static var accessToken: AccessToken?
}
