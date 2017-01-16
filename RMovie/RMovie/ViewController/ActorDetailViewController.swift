//
//  ActorDetailViewController.swift
//  RMovie
//
//  Created by Admin on 1/8/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit

class ActorDetailViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var aImage: UIImageView!
    @IBOutlet weak var aName: UILabel!
    @IBOutlet weak var aBirthday: UILabel!
    @IBOutlet weak var aPlaceOfBirth: UILabel!
    @IBOutlet weak var aPopularity: UILabel!
    @IBOutlet weak var aBiography: UITextView!
    
    //    @IBOutlet weak var movieCollectionView: ReferenceMovieCollection!
    
    @IBOutlet weak var movieContainerView: UIView!
    
    var actor : Actor!
    var animationState = 0
    var imageFrameSmall : CGRect!
    var imageFrameBig : CGRect!
    override func viewDidLoad() {
        
        self.setUI()
        super.viewDidLoad()
        let url = URL(string: actor.poster)
        self.aImage.sd_setImage(with: url)
        SearchManager.share.searchActorDetailInfo(id: actor.id) { (name, placeOfBirth, birthday, biography, popularity) in
            self.aName.text = name
            self.aPlaceOfBirth.text = placeOfBirth
            self.aBirthday.text = birthday
            self.aBiography.text = "\n" + biography
            self.aPopularity.text = String(popularity)
            
            self.imageFrameSmall = self.aImage.frame
            self.imageFrameBig = self.view.frame
            self.aImage.frame = self.aImage.frame
        }
        
        
        SearchManager.share.searchActorDetailMovie(id: actor.id) { (movies) in
            let movieCollectionView = Bundle.main.loadNibNamed("ReferenceMovieCollection", owner: self, options: nil)?.first as? ReferenceMovieCollection
            movieCollectionView?.vc = self
            movieCollectionView?.frame = self.movieContainerView.bounds
            movieCollectionView?.movies = movies
            movieCollectionView?.setUP()
            self.movieContainerView.addSubview(movieCollectionView!)
            
            //            self.movieCollectionView = Bundle.main.loadNibNamed("MovieCollection", owner: self, options: nil)?.first as? ReferenceMovieCollection
            //            self.movieCollectionView?.movies = movies
            //            self.view.addSubview(self.movieCollectionView!)
        }
        // Do any additional setup after loading the view.
    }
    
    func setUI() {
        self.title = "Actor Screen"
        self.aBiography.isEditable = false
        self.aImage.layer.masksToBounds = true
        self.aImage.layer.borderWidth = 1
        self.aImage.layer.borderColor = UIColor.white.cgColor
    }
    
    
       @IBAction func swipeBack(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
