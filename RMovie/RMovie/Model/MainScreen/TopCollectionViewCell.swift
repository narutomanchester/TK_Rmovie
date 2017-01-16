//
//  TopCollectionViewCell.swift
//  RMovie
//
//  Created by Hai on 1/14/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit

class TopCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterImage: UIImageView!

    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUp () {
        self.posterImage.layer.borderColor = UIColor.white.cgColor
        self.posterImage.layer.borderWidth = 2
    }

}
