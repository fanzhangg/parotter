//
//  TweetCell.swift
//  Parotter
//
//  Created by Fan Zhang on 8/21/19.
//  Copyright © 2019 Fan Zhang. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        textLabel?.numberOfLines = 0
        textLabel?.font = .boldSystemFont(ofSize: 15)
        detailTextLabel?.textColor = .black
        detailTextLabel?.font = .systemFont(ofSize: 15)
        detailTextLabel?.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
