//
//  CellTableViewCell.swift
//  AppcentNewsFeed
//
//  Created by Bukefalos on 26.10.2021.
//

import UIKit
import SDWebImage
class CellTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var newsSouce: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    
    @IBOutlet weak var newsSourceLabel: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(for viewm: ArticleViewModel) {
        
        
        self.newsTitleLabel.numberOfLines = 2
//        self.newsTitleLabel.adjustsFontSizeToFitWidth = true
//        self.newsTitleLabel.lineBreakMode = .byWordWrapping
        let titleUp = viewm.title.uppercased()
        self.newsTitleLabel.text =  titleUp
        let des = viewm.description.lowercased()
        self.newsDescriptionLabel.text = des
        self.newsSourceLabel.text = viewm.source
        
        newsImageView.sd_setImage(with: URL(string: viewm.urlToImage), placeholderImage: UIImage(named: "no_photo.svg"))
        
       }

}
