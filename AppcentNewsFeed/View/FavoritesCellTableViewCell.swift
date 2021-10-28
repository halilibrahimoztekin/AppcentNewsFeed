//
//  FavoritesCellTableViewCell.swift
//  AppcentNewsFeed
//
//  Created by Bukefalos on 28.10.2021.
//

import UIKit

class FavoritesCellTableViewCell: UITableViewCell {

   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var imageViewFav: UIImageView!
    
    @IBOutlet weak var sourceFav: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabelFav: UILabel!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
