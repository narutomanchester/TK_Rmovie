//
//  RandomMovieViewController.swift
//  RMovie
//
//  Created by mac on 1/8/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit
import SCLAlertView
import NVActivityIndicatorView

class RandomMovieViewController: UIViewController {

    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var checkInternet = InternetStatus.share.checkInternet()
    var topMovies = [Movie]()
    
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    @IBOutlet weak var lblSwipingDown: UILabel!
    @IBOutlet weak var lblNameMovies: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    var movie = Movie()
    //preMovies will manage a pre Movie that you random before
    var preMovies = [Movie]()
    var preIndexMovies : Int = -1
    var isPreMoviesFirst = true
    
    let recognizer = UITapGestureRecognizer()
    var moviesID = [Int]()
    
    //push new movie to stack
    func push(a : Movie) {
        preMovies.append(a)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setting for label Name Movies
        lblNameMovies.isHidden = true
        lblNameMovies.sizeToFit()
        
        
        self.posterImage.isUserInteractionEnabled = false
        self.posterImage.isHidden = true
        self.activityIndicator.startAnimating()
        
        
        
        
    }
    
    func loadMovies(){
        SearchManager.share.searchTopRandomFilm { (movies) in
            for movie in movies{
                self.topMovies.append(movie)
                print(self.topMovies.count)
            }
            /* slove situation that some movies in topMovies Array are repeat .
             Why loop ? Because api that i use to down info movies just provie only 20 movies per page.
             So i must use 5 for loop to get 100 top movies. Moreover, 1 loop include completion(movies)
             (movies is array
             
             */
            
        }
        self.progressRepeaterMovies()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        loadMovies()
        //setting for swipping down
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.randomTopMovies))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
        
        //setting for swipping up
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.backToPreMovies))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeUp)
        
        // tapping in poster Image -> go to info of this movies
        recognizer.addTarget(self, action: #selector(RandomMovieViewController.handleTap))
        self.posterImage.addGestureRecognizer(recognizer)
     
       // UserDefaults.standard.set(topMovies, forKey: "topMovies")
        //UserDefaults.standard.setValue(199, forKey: "favoriteMovies")
        //print(self.moviesID.count)

    }

    func handleTap() {
        checkInternet = InternetStatus.share.checkInternet()
        if (!checkInternet) {
            InternetStatus.share.showAlert()
            return
        }
        
        let movieDetailViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        movieDetailViewController.movie = movie
        
        self.navigationController?.pushViewController(movieDetailViewController, animated: true)

    }
    
    func setupForMoviesUI() {
        let url = URL(string: movie.poster)
        let image = UIImage(named: "logo Rmovie.png")
        self.posterImage.sd_setImage(with: url, placeholderImage: image)
        self.posterImage.layer.borderColor = UIColor.white.cgColor
        self.posterImage.layer.borderWidth = 2
        lblNameMovies.isHidden = false
        lblNameMovies.text = movie.name
    }
    
    func backToPreMovies()  {
        if (preIndexMovies < 0) {
            return
        }
        UIView.transition(with: self.posterImage, duration: 0.2, options: .transitionFlipFromBottom, animations: {
            self.posterImage.center.y =  2 * self.posterImage.frame.height
        }) { (complete) in
        }
        if (isPreMoviesFirst){
            isPreMoviesFirst = false
            preIndexMovies -= 1
        }
        if (preIndexMovies < 0) {
            return
        }
        movie = preMovies[preIndexMovies]
        preIndexMovies -= 1
        setupForMoviesUI()
    }
    

    
    func randomTopMovies(){
        UIView.transition(with: self.posterImage, duration: 0.2, options: .transitionFlipFromTop, animations: {
            self.posterImage.center.y = 0 -  self.posterImage.frame.height
        }) { (complete) in
        }
       // print(2)
        self.lblSwipingDown.isHidden = true
        self.posterImage.isUserInteractionEnabled = true
        
        checkInternet = InternetStatus.share.checkInternet()
        if (!checkInternet) {
            InternetStatus.share.showAlert()
            return
        }
        if (!isPreMoviesFirst) {
            preIndexMovies += 1
        }
        if (preIndexMovies < 0) {
            preIndexMovies = 0
        }
        if (preIndexMovies + 1 < preMovies.count){
            preIndexMovies += 1
            movie = preMovies[preIndexMovies]
            
        } else {
            let rad = Int(arc4random_uniform(UInt32(topMovies.count))) // random A Top movies
            self.push(a: topMovies[rad]) // push a movie at index a to Pre Movies Array
            self.preIndexMovies = preMovies.count - 1
            isPreMoviesFirst = true

            movie = topMovies[rad]
            topMovies.remove(at: rad)
        }
        self.setupForMoviesUI()
    }

    func progressRepeaterMovies()  {
        var checkFilmSelected = Array(repeating: false, count: 100000000)
        var count = 0
        print(self.topMovies.count)
        for movie in topMovies {
            if (checkFilmSelected[movie.id]) {
                topMovies.remove(at: count)
            } else {
                count += 1
                moviesID.append(movie.id)
                checkFilmSelected[movie.id] = true
            }
        }
       print(self.topMovies.count)
        self.activityIndicator.stopAnimating()
        self.posterImage.isHidden = false
    }
}
