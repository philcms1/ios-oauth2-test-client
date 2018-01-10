//
//  ProviderTableViewCell.swift
//  OAuth 2.0 Test Client
//
//  Created by Thorin on 2018-01-08.
//  Copyright © 2018 SOA Architects Inc. All rights reserved.
//

import UIKit

class ProviderTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var domainLabel: UILabel!
    @IBOutlet var providerLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
