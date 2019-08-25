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


class ViewController: UIViewController, SFSafariViewControllerDelegate {
    // var swifter: Swifter    // make as an shared instance
    
    // Use iOS account framework for handling twitter auth by defualt
    let useACAccount = false
    
    required init?(coder aDecoder: NSCoder) {
        // self.swifter = Swifter(consumerKey: "VQDFZmAR5pc0bWt1ja6ejK6Gs", consumerSecret: "45h2w0EbZmoYQGUb7PYT7KMekSR0wmfKuqhG1omPNxifKdv23y", oauthToken: "877897502808301568-kQ58dtIMpo4hQK21vTpe4qaxC6Gq95g", oauthTokenSecret: "pHln0haR7vzgs1GtC502VoiCKkI1YzCknaku4HDDyBL2G")
        super.init(coder: aDecoder)
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
            NetworkHelper.swifter.authorize(withCallback: url, presentingFrom: self, safariDelegate: self, success: { _, _ in
                os_log("Authorization succeeds", log: OSLog.default, type: .debug)
                self.fetchTwitterHomeStream()
            }, failure: failureHandler)
        }
    }
    
//    // Delegate method to be notified on dismissal
//    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
//        let failureHandler: (Error) -> Void = {error in
//            self.alert(title: "Fetch Error", message: error.localizedDescription)
//        }
//
//        os_log("SafariViewController closed")
//        controller.dismiss(animated: true, completion: nil)
//        self.swifter.getHomeTimeline(count: 20, success: {json in
//            // Create tweet table view controller
//            let tweetsViewController = self.storyboard!.instantiateViewController(withIdentifier: "TweetsViewController") as! TweetsViewController
//            // Read tweets as json array
//            guard let tweets = json.array else {
//                os_log("Fail to retrieve tweets", log: OSLog.default, type: .debug)
//                return
//            }
//            tweetsViewController.tweets = tweets
//            // Push the tweets veiw controller
//            self.navigationController?.pushViewController(tweetsViewController, animated: true)
//        }, failure: failureHandler)
//    }
    
    //TODO: move to appDelegate
    func fetchTwitterHomeStream() {
        let failureHandler: (Error) -> Void = {error in
            self.alert(title: "Fetch Error", message: error.localizedDescription)
        }
        NetworkHelper.swifter.getHomeTimeline(count: 20, success: {json in
            // Create tweet table view controller
            let tweetsViewController = self.storyboard!.instantiateViewController(withIdentifier: "TweetsViewController") as! TweetsViewController
            // Read tweets as json array
            guard let tweets = json.array else {
                os_log("Fail to retrieve tweets", log: OSLog.default, type: .debug)
                return
            }
            tweetsViewController.tweets = tweets
            // Push the tweets veiw controller
            self.navigationController?.pushViewController(tweetsViewController, animated: true)
        }, failure: failureHandler)
    }
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

