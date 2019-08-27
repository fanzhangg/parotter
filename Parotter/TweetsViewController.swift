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

class TweetsViewController: UITableViewController {
    var tweets : [JSON] = []
    let reuseIdentifier: String = "reuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Timeline" // Set the title to timeline
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
    
    /// Set up the cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell // Dequeue using the "tweetCell" and cast to TweetCell
        let tweetDic = tweets[indexPath.row]    // Set current song to tweet of tweets at indexPath.row
        let currTweet = Tweet(userName: tweetDic["user"]["name"].string!, userID: "@\(tweetDic["user"]["screen_name"].string!)", content: tweetDic["text"].string!)
        cell.tweetView.tweet = currTweet    // Set up tweet in cell
        return cell
    }
}
