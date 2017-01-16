//
//  FavoriteTableViewCell.swift
//  RMovie
//
//  Created by mac on 1/15/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .none
        self.movieImage.layer.borderColor = UIColor.white.cgColor
        self.movieImage.layer.borderWidth = 1
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        
//
//        // Configure the view for the selected state
//    }
    
    
}
