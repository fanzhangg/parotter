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

