//
//  SimilarMovieCell.swift
//  RMovie
//
//  Created by Hai on 1/8/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit

class SimilarMovieCell: UICollectionViewCell {

    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var posterContainer: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .none
        self.posterContainer.layer.borderColor = UIColor.white.cgColor
        self.posterContainer.layer.borderWidth = 3
    }

}
