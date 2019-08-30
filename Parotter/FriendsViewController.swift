//
//  FriendsViewController.swift
//  Parotter
//
//  Created by Fan Zhang on 8/27/19.
//  Copyright © 2019 Fan Zhang. All rights reserved.
//

import UIKit
import SwifteriOS
import os.log
import SafariServices

class FriendsViewController: UITableViewController {
    var followings: [JSON] = []
    let reuseIdentifier: String = "FollowingCell"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Initialize tab bar item
        tabBarItem = UITabBarItem(title: "Friends", image: UIImage(named: "icon-friend"), tag: 1)
        self.title = "Friend"
        self.getFollowings()
    }
    
    func getFollowings() {
        NetworkHelper.swifter.getUserFollowing(for: .screenName(NetworkHelper.accessToken!.screenName), success: {
            json, prev, next in
            if json == nil {
                fatalError("Get no followings")
            }
            self.followings = json.array!
            os_log("Followings fetched", log: OSLog.default, type: .debug)
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 10
        tableView.contentInset = UIEdgeInsets(top: self.topLayoutGuide.length, left: 0, bottom: 0, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: self.topLayoutGuide.length, left: 0, bottom: 0, right: 0)
        tableView.register(FollowingCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.followings.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = self.followings[indexPath.row]["name"].string
        cell.detailTextLabel?.text = self.followings[indexPath.row]["description"].string
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard #available(iOS 9.0, *) else { return }
        let screenName = self.followings[indexPath.row]["screen_name"].string!
        let url = URL(string: "https://twitter.com/\(screenName)")!
        let safariView = SFSafariViewController(url: url)
        self.present(safariView, animated: true, completion: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
