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
        navigationItem.hidesBackButton = true
        if NetworkHelper.swifter.client.credential != nil {
            os_log("Authorization has been completed", log: OSLog.default, type: .debug)
            self.fetchTwitterHomeStream()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
                self.fetchTwitterHomeStream()
                NetworkHelper.accessToken = accessToken
                os_log("Access token saved in NetworkHelper", log: OSLog.default, type: .debug)
            }, failure: failureHandler)
        }
    }
    
    /// Save 20 tweets to NetworkHelper.tweets and push HomeBarViewController
    func fetchTwitterHomeStream() {
        let failureHandler: (Error) -> Void = {error in
            self.alert(title: "Fetch Error", message: error.localizedDescription)
        }
        NetworkHelper.swifter.getHomeTimeline(count: 20, success: {json in
            // Read tweets as json array
            os_log("Fetching tweets...", log: OSLog.default, type: .debug)
            guard let tweets = json.array else {
                os_log("Fail to retrieve tweets", log: OSLog.default, type: .debug)
                return
            }
            NetworkHelper.tweets = tweets
            
            let homeBarController = self.storyboard!.instantiateViewController(withIdentifier: "HomeBarController") as! HomeBarController   // Create an instance of HomeBarController
            self.navigationController?.pushViewController(homeBarController, animated: true)   // Push HomeBarController
        }, failure: failureHandler)
    }
    
    
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

