//
//  NEWSTableViewCell.swift
//  NewsApp
//
//  Created by rahulverma on 14/8/23.
//

import UIKit

class NEWSTableViewCell: UITableViewCell {

    @IBOutlet var newsLabel: UILabel?
    @IBOutlet var articleCount: UILabel?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
