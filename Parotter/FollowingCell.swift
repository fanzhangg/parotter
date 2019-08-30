//
//  FollowingCell.swift
//  Parotter
//
//  Created by Fan Zhang on 8/30/19.
//  Copyright © 2019 Fan Zhang. All rights reserved.
//

import UIKit

class FollowingCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        textLabel?.numberOfLines = 1
        textLabel?.font = .boldSystemFont(ofSize: 15)

        detailTextLabel?.textColor = .black
        detailTextLabel?.font = .systemFont(ofSize: 15)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
