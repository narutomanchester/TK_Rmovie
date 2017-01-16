//
//  MovieCell.swift
//  RMovie
//
//  Created by Hai on 1/2/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var movieScore: UILabel!
    @IBOutlet weak var circle: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUP()
        
    }
    func setUP () {
        self.circle.isHidden = false
        self.poster.clipsToBounds = true
        self.imageContainer.layer.shadowColor = UIColor.init(hexString: "8B063B")?.cgColor
        self.imageContainer.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.imageContainer.layer.shadowRadius = 8
        self.imageContainer.layer.shadowOpacity = 0.8
        self.imageContainer.layer.borderColor = UIColor.white.cgColor
        self.imageContainer.layer.borderWidth = 4
    }
    
    
}
