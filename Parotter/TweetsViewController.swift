//
//  TweetViewController.swift
//  Parotter
//
//  Created by Fan Zhang on 8/21/19.
//  Copyright © 2019 Fan Zhang. All rights reserved.
//

import Foundation
import UIKit
import SwifteriOS
import SafariServices
import os.log

class TweetsViewController: UITableViewController {
    // lazy stored property: init when it is accessed / the view controller is initialized
    lazy var tweets : [JSON] = NetworkHelper.tweets
    let reuseIdentifier: String = "reuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Initialize tab bar item
        tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "icon-home"), tag: 0)
        tabBarItem.badgeValue = "6"
        self.title = "Home"
        self.navigationItem.title = "Home"
    }
    
    /// Set number of rows equal to the count of tweets
    /// return: number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    /// Set the height of each row
    //TODO: Change to a dynamic height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    /// Set the value of elements in tweetView
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell // Dequeue using the "tweetCell" and cast to TweetCell
        let tweetDic = tweets[indexPath.row]    // Set current song to tweet of tweets at indexPath.row
        
        let screenName = tweetDic["user"]["screen_name"].string!
        let content = tweetDic["text"].string!
        let userName = tweetDic["user"]["name"].string!
        
        // Update the cell content
        let currTweet = Tweet(userName: userName, userID: "@\(screenName)", content: content)
        cell.tweetView.tweet = currTweet    // Set up tweet in cell
        
        return cell
    }
    
    /// Open the tweet detail in a Safari View after touching the cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard #available(iOS 9.0, *) else { return }
        let screenName = tweets[indexPath.row]["user"]["screen_name"].string!
        let id = tweets[indexPath.row]["id_str"].string!
        let url = URL(string: "https://twitter.com/\(screenName)/status/\(id)")!
        let safariView = SFSafariViewController(url: url)
        self.present(safariView, animated: true, completion: nil)
    }
}
