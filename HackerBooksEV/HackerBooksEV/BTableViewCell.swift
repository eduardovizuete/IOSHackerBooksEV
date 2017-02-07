//
//  BTableViewCell.swift
//  HackerBooksEV
//
//  Created by usuario on 2/6/17.
//  Copyright © 2017 evizcloud. All rights reserved.
//

import UIKit

class BTableViewCell: UITableViewCell {

    @IBOutlet weak var titleCell: UILabel!
    
    @IBOutlet weak var authorsCell: UILabel!
    
    @IBOutlet weak var tagsCell: UILabel!
    
    @IBOutlet weak var imageCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
