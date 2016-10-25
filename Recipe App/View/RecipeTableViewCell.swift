//
//  RecipeTableViewCell.swift
//  Recipe App
//
//  Created by Kokpheng on 10/21/16.
//  Copyright © 2016 Kokpheng. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet var thumbnailImageView: UIImageView!
    
    @IBOutlet var dateTimeLabel: UILabel!
    
    @IBOutlet var nameLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
