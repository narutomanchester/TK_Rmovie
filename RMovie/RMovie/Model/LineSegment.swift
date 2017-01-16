//
//  LineSegment.swift
//  RMovie
//
//  Created by Hai on 1/3/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit

class LineSegment: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func animationLine(button : UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.center.x = button.center.x
        }
    }
}
