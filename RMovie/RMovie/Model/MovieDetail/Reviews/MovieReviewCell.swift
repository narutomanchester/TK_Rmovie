//
//  MovieReviewCell.swift
//  RMovie
//
//  Created by Hai on 1/8/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit

class MovieReviewCell: UITableViewCell {

    @IBOutlet weak var reviewContent: UILabel!
    
    @IBOutlet weak var background: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .none
        self.layer.cornerRadius = 10
        self.reviewContent.backgroundColor = .none
        self.background.layer.cornerRadius = 10
        
     
    }

}
