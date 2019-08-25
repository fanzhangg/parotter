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
        self.title = "Timeline" //TODO: replace to user name
        
        // Set the style of the table view
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        tableView.contentInset = UIEdgeInsets(top: self.topLayoutGuide.length, left: 0, bottom: 0, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: self.topLayoutGuide.length, left: 0, bottom: 0, right: 0)
        // register a table view to create new table cells
        tableView.register(TweetCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    // set up the cells of the tweets
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = "\(tweets[indexPath.row]["user"]["name"].string!) @\(tweets[indexPath.row]["user"]["screen_name"].string!)"
        cell.detailTextLabel?.text = tweets[indexPath.row]["text"].string
        // cell.detailTextLabel?.text = "By \(tweets[indexPath.row]["user"]["name"].string!), @\(tweets[indexPath.row]["user"]["screen_name"].string!)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Fatal error: Unexpectedly found nil while unwrapping an Optional value
        let screenName = tweets[indexPath.row]["user"]["screen_name"].string!
        let id = tweets[indexPath.row]["id_str"].string!
        let url = URL(string: "https://twitter.com/\(screenName)/status/\(id)")!
        let safariView = SFSafariViewController(url: url)
        self.present(safariView, animated: true, completion: nil)
    }
}
