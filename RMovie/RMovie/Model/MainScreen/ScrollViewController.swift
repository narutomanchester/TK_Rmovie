//
//  ScrollViewController.swift
//  RMovie
//
//  Created by Hai on 1/14/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit
import GoAutoSlideView


class ScrollViewController: GoAutoSlideView, GoAutoSlideViewDelegate, GoAutoSlideViewDataSource {
    var movies : [Movie]!
    override func awakeFromNib() {
        
    }
    func setUp ()  {
        self.slideDataSource = self
        self.slideDelegate = self
        self.slideDuration = 5
        print(movies.count)
        self.reloadData()


    }
    
    func goAutoSlideView(_ goAutoSlideView: GoAutoSlideView, viewAtPage page: Int) -> UIView {
        let viewBanner = Bundle.main.loadNibNamed("ScrollView", owner: nil, options: nil)?.first as! ScrollView
        viewBanner.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        let url = URL(string: movies[page].backdrop)
        print(movies[page].backdrop)
        viewBanner.imageMovie.sd_setImage(with: url!)
        return viewBanner
    }
    func goAutoSlideView(_ goAutoSlideView: GoAutoSlideView, didTapViewPage page: Int) {
        let movie = ["movie": movies[page]]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: movieDetailFromMain), object: nil, userInfo: movie)
    }
    func numberOfPages(in goAutoSlideView: GoAutoSlideView) -> Int {
        return 4
    }
}
