//
//  MovieDetailViewController.swift
//  RMovie
//
//  Created by Hai on 1/5/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit
import BetterSegmentedControl
import SwiftHEXColors
import XCDYouTubeKit
import RAMAnimatedTabBarController
import NVActivityIndicatorView
import SCLAlertView
import XLActionController

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var segmentView: UIView!
    @IBOutlet weak var posterContainer: UIView!
    @IBOutlet weak var lineSegment: LineSegment!
    @IBOutlet var segmentBtn: [UIButton]!
    @IBOutlet var movieInfo: [UILabel]!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var backdropImage: UIImageView!
    
    @IBOutlet weak var favorBtn: UIButton!
    @IBOutlet weak var noResult: UILabel!
    var MoviesId : [Int] = []
    
    var movie : Movie!

    var trailerPlayer = XCDYouTubeVideoPlayerViewController()
    var animateTabbar : RAMAnimatedTabBarController!
    var oldPosition : CGRect!
    var currentView : UIView!
    var reviewNull = false
    
    var showImage = false
    
    var infoView : InfoMovieView!
    var reviewView : MovieReviewView!
    var similarView : SimilarMovieView!
    
    var isFavor : Bool!
    var indexOfMoviesfavor : Int = 0
   
    func showFavor(){
        let alertview = SCLAlertView()
        alertview.showSuccess("Success", subTitle: "Movie added to Favorite")
    }
    func showUnFavor(){
        
    
    }
    @IBAction func invokeFavorite(_ sender: Any) {
        isFavor = false
        indexOfMoviesfavor = 0
        if (UserDefaults.standard.array(forKey: "favoriteMovies") != nil) {
            MoviesId = UserDefaults.standard.array(forKey: "favoriteMovies") as! [Int]
            for id in MoviesId {
                if (id == movie.id){
                    isFavor = true
                    
                    let mess = movie.name + "(" + movie.year + ")"
                    let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: "", message: mess, preferredStyle: .actionSheet)
                    
                    let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                        print("Cancel")
                    }
                    actionSheetControllerIOS8.addAction(cancelActionButton)
                    
                    let deleteActionButton: UIAlertAction = UIAlertAction(title: "Remove from Favorite", style: .destructive)
                    { action -> Void in
                        self.MoviesId.remove(at: self.indexOfMoviesfavor)
                        
                        UserDefaults.standard.setValue(self.MoviesId, forKey: "favoriteMovies")
                        self.favorBtn.setImage(UIImage(named: "unlike.png"), for: .normal)
                    }
                    actionSheetControllerIOS8.addAction(deleteActionButton)
                    self.present(actionSheetControllerIOS8, animated: true, completion: nil)
                    
                    return
                }
                indexOfMoviesfavor += 1
            }
        }
        if (!isFavor){
            MoviesId.append(movie.id)
            showFavor()
            favorBtn.setImage(UIImage(named: "like.png"), for: .normal)
           // print(MoviesId[MoviesId.count-1])
            UserDefaults.standard.setValue(MoviesId, forKey: "favoriteMovies")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpFavorButton()
        self.setUP()
        self.Notification()
        self.infoSetup()
        self.reviewSetup()
        self.similarSetup()
        self.gestureImage()
        self.activityIndicator.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.Notification()
    }
    func setUpFavorButton()  {
        isFavor = false
        if (UserDefaults.standard.array(forKey: "favoriteMovies") != nil) {
            MoviesId = UserDefaults.standard.array(forKey: "favoriteMovies") as! [Int]
            for id in MoviesId {
                if (id == movie.id){
                    isFavor = true
                    favorBtn.setImage(UIImage(named: "like.png"), for: .normal)
                    return
                }
                indexOfMoviesfavor += 1
            }
        }
        if (!isFavor){
            favorBtn.setImage(UIImage(named: "unlike.png"), for: .normal)
        }

    }
    
    // MARK :- Show Poster
    func gestureImage() {
            let tapImage = UITapGestureRecognizer(target: self, action: #selector(animateImage))
            self.posterImage.addGestureRecognizer(tapImage)
    }
    
    func imageOffAnimation() {
        if showImage {
            self.animateTabbar.animationTabBarHidden(false)
            ImageAnimation.share.animateOff(imageView: self.posterImage, imageContainer: self.posterContainer, oldPosition: self.oldPosition, view: self.view,background : self.background)
            self.showImage = false
            self.view.gestureRecognizers?.removeAll()
        }
    }
    func animateImage() {
        if !showImage {
            self.animateTabbar.animationTabBarHidden(true)
            ImageAnimation.share.animateOn(imageView: self.posterImage, view: self.view, imageContainer: self.posterContainer, background : self.background)
            self.showImage = true
            let imageOff = UITapGestureRecognizer(target: self, action: #selector(imageOffAnimation))
            self.view.addGestureRecognizer(imageOff)
        }
    }

    // MARK:- Move to Detail Movie
    func Notification() {
        NotificationCenter.default.addObserver(self, selector: #selector(movieDetail), name: NSNotification.Name(rawValue: movieDetailFromSimilerNotification), object: nil)
    }
    func movieDetail(_ notification : Notification) {
        let movie = notification.userInfo?["movie"] as! Movie
        let movieDetailViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        movieDetailViewController.movie = movie
        NotificationCenter.default.removeObserver(self)
        self.navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
    
        // MARK :- Setup Info View - Similar View - Review View

    // Similar
    func similarSetup() {
        var movies = [Movie]()
        SearchManager.share.searhSimilarMovie(media_type: movie.media_type, id: movie.id) { (results) in
            for movie in results {
                movies.append(movie)
            }
            self.similarView.movies = movies
            self.view.addSubview(self.similarView)
        }
    }
    
    // Reviews
    func reviewSetup() {
        var reviews = [String]()
        SearchManager.share.searchReview(media_type: movie.media_type, id: movie.id) { (results) in
            if results.count == 0 {
                self.reviewNull = true
                self.reviewView.reviews = reviews
                self.view.addSubview(self.reviewView)
            } else {
            for review in results {
                print("review", review)
                reviews.append(review)
            }
                self.reviewView.reviews = reviews
                self.view.addSubview(self.reviewView)
                self.noResult.isHidden = true
                self.reviewNull = false
            }
        }
    }
    
    // Info
    func infoSetup() {
        var casts = [Actor]()
                SearchManager.share.searchMovieCast(mediaType: movie.media_type, id: movie.id) { (actors) in
            for actor in actors {
               casts.append(actor)
            }
            self.movie.casts = casts
            self.infoView.movie = self.movie
            self.infoView.setDecription()
            self.infoView.vc = self
            self.view.addSubview(self.infoView)
            self.activityIndicator.stopAnimating()
        }
    }

    // MARK :- Video
    @IBAction func invokePlayBtn(_ sender: UIButton) {
        SearchManager.share.searchTrailer(id: movie.id) { (youtubeId) in
            self.animateTabbar.animationTabBarHidden(true)
            self.trailerPlayer = XCDYouTubeVideoPlayerViewController(videoIdentifier: youtubeId)
            self.view.addSubview(self.trailerPlayer.view)
            NotificationCenter.default.addObserver(self, selector: #selector(self.hideTrailer), name: NSNotification.Name.MPMoviePlayerPlaybackDidFinish, object: self.trailerPlayer.moviePlayer)
        }
    }
    func hideTrailer() {
        self.animateTabbar.animationTabBarHidden(false)
        self.trailerPlayer.view.removeFromSuperview()
        trailerPlayer.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func swipeBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    }
