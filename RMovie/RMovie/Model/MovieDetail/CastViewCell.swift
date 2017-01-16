//
//  CastViewCell.swift
//  RMovie
//
//  Created by Hai on 1/6/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit

class CastViewCell: UICollectionViewCell {
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var imageActor: UIImageView!
    @IBOutlet weak var castName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageActor.clipsToBounds = true
        self.castName.backgroundColor = UIColor(patternImage: UIImage(named: "Background.png")!)
    }

}
