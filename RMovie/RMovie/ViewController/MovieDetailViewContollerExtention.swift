//
//  MovieTodayViewController.swift
//  RMovie
//
//  Created by Hai on 1/2/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit
import SwiftHEXColors
import XCDYouTubeKit
import RAMAnimatedTabBarController
import NVActivityIndicatorView


extension MovieDetailViewController {
    // MARK :- Setup UI
    func setUP() {
        self.similarView = Bundle.main.loadNibNamed("SimilarMovieView", owner: nil, options: nil)?.first as! SimilarMovieView
        let height = self.view.frame.height * 220/568
        let y = self.view.frame.height - height * 21/20 - 50
        self.similarView.frame = CGRect(x: self.viewContainer.frame.origin.x, y: y, width: self.view.frame.width - 32, height: height)
        
        self.reviewView = Bundle.main.loadNibNamed("MovieReviewView", owner: nil, options: nil)?.first as! MovieReviewView
        self.reviewView.frame = CGRect(x: self.viewContainer.frame.origin.x, y: y, width: self.view.frame.width - 32, height: height)
        
        self.infoView =  Bundle.main.loadNibNamed("InfoMovieView", owner: nil, options: nil)?.first as! InfoMovieView
        self.infoView.frame = CGRect(x: self.viewContainer.frame.origin.x, y: y, width: self.view.frame.width - 32, height: height)
        
        self.reviewView.isHidden = true
        self.similarView.isHidden = true
        
        self.noResult.isHidden = true
        
        self.oldPosition = self.posterContainer.frame
        
        self.animateTabbar = self.tabBarController as! RAMAnimatedTabBarController!
        
        self.posterContainer.layer.shadowColor = UIColor.white.cgColor
        self.posterContainer.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.posterContainer.layer.shadowRadius = 3
        self.posterContainer.layer.shadowOpacity = 0.5
        let posterUrl = URL(string: (movie?.poster)!)
        self.posterImage.sd_setImage(with: posterUrl)
        self.posterImage.clipsToBounds = true
        self.posterImage.layer.borderWidth = 2
        self.posterImage.layer.borderColor = UIColor.white.cgColor
        
        
        let backdropUrl = URL(string: (movie?.backdrop)!)
        self.backdropImage.sd_setImage(with: backdropUrl)
        self.movieName.text = (movie.name)!
        self.movieInfo[0].text = movie?.year!
        self.movieInfo[1].text = "\((movie.score)!)"
        self.movieInfo[2].text = "\((movie.popularity)!)"
    }
    
    // MARK :- Segment Controll
    @IBAction func segmentControll(_ sender: UIButton) {
        switch sender {
        case segmentBtn[0]:
            self.noResult.isHidden = true
            self.infoView.isHidden = false
            self.reviewView.isHidden = true
            self.similarView.isHidden = true
            //self.currentView = self.infoView
            sender.setTitleColor(.white, for: .normal)
            self.lineSegment.animationLine(button: sender)
            segmentBtn[1].setTitleColor(UIColor.init(hexString: "929292"), for: .normal)
            segmentBtn[2].setTitleColor(UIColor.init(hexString: "929292"), for: .normal)
        case segmentBtn[1]:
            if reviewNull {
                self.noResult.isHidden = false
            }
            self.reviewView.isHidden = false
            self.infoView.isHidden = true
            self.similarView.isHidden = true
            //self.currentView = self.reviewView
            sender.setTitleColor(.white, for: .normal)
            self.lineSegment.animationLine(button: sender)
            segmentBtn[0].setTitleColor(UIColor.init(hexString: "929292"), for: .normal)
            segmentBtn[2].setTitleColor(UIColor.init(hexString: "929292"), for: .normal)
        case segmentBtn[2]:
            self.noResult.isHidden = true
            self.reviewView.isHidden = true
            self.infoView.isHidden = true
            self.similarView.isHidden = false
            sender.setTitleColor(.white, for: .normal)
            self.lineSegment.animationLine(button: sender)
            segmentBtn[0].setTitleColor(UIColor.init(hexString: "929292"), for: .normal)
            segmentBtn[1].setTitleColor(UIColor.init(hexString: "929292"), for: .normal)
        default:
            break
        }
    }

}
