//
//  MovieCell.swift
//  RMovie
//
//  Created by Admin on 1/8/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var poster: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUP()
        
    }
    func setUP () {
        self.poster.layer.shadowColor = UIColor.init(hexString: "8B063B")?.cgColor
        self.poster.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.poster.layer.shadowRadius = 8
        self.poster.layer.shadowOpacity = 0.8
        self.poster.layer.borderColor = UIColor.white.cgColor
        self.poster.layer.borderWidth = 4
    }
    
    
}
