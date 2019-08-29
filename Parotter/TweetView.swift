//
//  TweetCell.swift
//  Parotter
//
//  Created by Fan Zhang on 8/21/19.
//  Copyright © 2019 Fan Zhang. All rights reserved.
//

import UIKit
import SwifteriOS
import os.log

struct Tweet {
    let userName: String
    let userID: String
    let content: String
}

class TweetView: UIView {
    // Outlet of the contentView
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userID: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    var tweet: Tweet! {
        didSet { // Observer to set all information on the cell to the information from the Tweet
            userName.text = tweet.userName
            userID.text = tweet.userID
            tweetContent.text = tweet.content
        }
    }

    // Initialize via storyboard
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    // Initialize via code
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("TweetView", owner: self, options: nil)    // load XIB
        contentView.translatesAutoresizingMaskIntoConstraints = false   // Allow to set the constraints
        addSubview(contentView) // Add contentView to TweetCellView
        // Constarnt contentView to the edges of the TweetCellView
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        // Allow tweetContent to display all lines of the tweet content
        tweetContent.numberOfLines = 0
    }
}

