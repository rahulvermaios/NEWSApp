//
//  DetailCellTableViewCell.swift
//  NewsApp
//
//  Created by rahulverma on 14/8/23.
//

import UIKit

class DetailCellTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var author: UILabel?
    @IBOutlet var descriptionLabel: UILabel?
    @IBOutlet var authorImage: UIImageView?
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupdata(article_data:Article) {
        
        if let x = article_data.title {
            
            titleLabel?.text = "\(x)"
        }
        
        
        if let x = article_data.author {
            
            author?.text = "\(x)"
        }
        
        if let x = article_data.description {
            
            descriptionLabel?.text = "\(x)"
        }
        
        if let x = article_data.urlToImage, let url = URL(string: x) {
            
            ImageDonwloader.shared.downloadImage(with: url) { [weak self] image in
                
                DispatchQueue.main.async {
                    self?.authorImage?.image = image
                }
            }
        } else {
            
            authorImage?.image = nil // Or no image
        }
        
    }
    
}
