//
//  ViewController.swift
//  Parotter
//
//  Created by Fan Zhang on 8/21/19.
//  Copyright © 2019 Fan Zhang. All rights reserved.
//

import UIKit
import SwifteriOS
import SafariServices
import os.log


class AuthViewController: UIViewController, SFSafariViewControllerDelegate {
    // Use iOS account framework for handling twitter auth by defualt
    let useACAccount = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.viewWillAppear(true)
        initAccessToken()
    }
    
    /// Load access token, if there is an access token init Swifter with the token and secret token and push the HomeView
    func initAccessToken() {
        if let accessToken = loadAccessToken() {
            NetworkHelper.swifter = Swifter(consumerKey: "VQDFZmAR5pc0bWt1ja6ejK6Gs", consumerSecret: "45h2w0EbZmoYQGUb7PYT7KMekSR0wmfKuqhG1omPNxifKdv23y", oauthToken: accessToken.key, oauthTokenSecret: accessToken.secret)
            NetworkHelper.accessToken = accessToken
            self.fetchTwitterHomeStream()
        } else {
            os_log("Access token has not yet been stored, start user authroization", log: OSLog.default, type: .debug)
        }
    }
    
    @IBAction func didTouchUpInsideLoginButton(_ sender: Any) {
        let failureHandler: (Error) -> Void = {error in
            self.alert(title: "Error", message: error.localizedDescription)
            os_log("Fail to login", log: OSLog.default, type: .debug)
        }

        if useACAccount {
            // prompt user for perssiom to the twitter account
        } else {
            let url = URL(string: "parotter://success")!
            NetworkHelper.swifter.authorize(withCallback: url, presentingFrom: self, safariDelegate: self, success: { accessToken, _ in
                os_log("Authorization succeeds", log: OSLog.default, type: .debug)
                self.saveAccessToken(token: accessToken)
                self.fetchTwitterHomeStream()
            }, failure: failureHandler)
        }
    }
    
    /// Get the home timeline of the user, and present the tweets view
    func fetchTwitterHomeStream() {
        let failureHandler: (Error) -> Void = {error in
            self.alert(title: "Error", message: error.localizedDescription)
        }
        NetworkHelper.swifter.getHomeTimeline(count: 20, success: {json in
            // Read tweets as json array
            os_log("Fetching tweets...", log: OSLog.default, type: .debug)
            guard let tweets = json.array else {
                os_log("Fail to retrieve tweets", log: OSLog.default, type: .debug)
                return
            }
            
            NetworkHelper.tweets = tweets
            
            os_log("Presenting homeBarController...", log: OSLog.default, type: .debug)
            let homeBarController = self.storyboard!.instantiateViewController(withIdentifier: "HomeBarController") as! HomeBarController   // Create an instance of HomeBarController
            // self.navigationController?.pushViewController(homeBarController, animated: true)   // Push HomeBarController
            self.present(homeBarController, animated: true)
        }, failure: failureHandler)
    }
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @available(iOS 9.0, *)
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    /// Save access token to the archive url
    private func saveAccessToken(token: Credential.OAuthAccessToken?) {
        guard let accessToken = token else {
            os_log("Does not have a valid access token to save", log: OSLog.default, type: .debug)
            return
        }
        
        let savedToken = AccessToken(token: accessToken.key, secret: accessToken.secret, screenName: accessToken.screenName!, userID: accessToken.userID!)
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: savedToken!, requiringSecureCoding: false)
            try data.write(to: AccessToken.ArchiveURL.absoluteURL)
            os_log("Access token saved", log: OSLog.default, type: .debug)
            NetworkHelper.accessToken = savedToken
        } catch {
            os_log("Unable to save access token", log: OSLog.default, type: .error)
        }
    }
    
    /// Load access token from the archive url
    private func loadAccessToken() -> AccessToken? {
        do {
            let data = try Data(contentsOf: AccessToken.ArchiveURL.absoluteURL)
            guard let token = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? AccessToken else {
                os_log("Unable to convert the data to AccessToken", log: OSLog.default, type: .error)
                return nil
            }
            os_log("Load the access token", log: OSLog.default, type: .debug)
            return token
        } catch {
            os_log("Unable to load the access token", log: OSLog.default, type: .error)
            return nil
        }
    }
}

