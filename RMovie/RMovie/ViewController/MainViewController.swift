//
//  MainViewController.swift
//  RMovie
//
//  Created by Hai on 1/13/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit
import GoAutoSlideView

class MainViewController: UIViewController {
    
    @IBOutlet weak var loaderImage: UIImageView!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var movies = [Movie]()
    
    var scrollVC : ScrollViewController!
    var tableViewTopMovie : TopMovieTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SearchLoading()
        self.SearchTop()
        self.Notification()
//        var test = [Int]()
//        UserDefaults.standard.setValue(test, forKey: "favoriteMovies")
    }
    
    func SearchLoading () {
        SearchManager.share.searchMainBanner { (results) in
            for movie in results {
                self.movies.append(movie)
            }
            print("count", self.movies.count)
            self.scrollVC = Bundle.main.loadNibNamed("ScrollViewController", owner: nil, options: nil)?.first as! ScrollViewController
            self.scrollVC.movies = self.movies
            self.scrollVC.setUp()
            self.view.addSubview(self.scrollVC)
            self.scrollVC.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.width * 1/1.78)
        }
    }
    func SearchTop () {
        var topTV = [Movie]()
        var topMovies = [Movie]()
        var topMovies2016 = [Movie]()
        SearchManager.share.searchTopTV { (topTVs) in
            SearchManager.share.searchTopMovie(urlPath: urlTopMovie, completion: { (topMovie) in
                SearchManager.share.searchTopMovie(urlPath: urlTopMovie2016, completion: { (topMovie2016) in
                    for movie in topMovie2016 {
                        topMovies2016.append(movie)
                    }
                    for movie in topMovie {
                        topMovies.append(movie)
                    }
                    for tv in topTVs {
                        topTV.append(tv)
                    }
                    self.tableViewTopMovie = Bundle.main.loadNibNamed("TopMovieTableView", owner: nil, options: nil)?.first as! TopMovieTableView
                    self.tableViewTopMovie.topMovie = topMovies
                    self.tableViewTopMovie.topMovie2016 = topMovies2016
                    self.tableViewTopMovie.topTv = topTV
                    self.tableViewTopMovie.setUP()
                    self.view.addSubview(self.tableViewTopMovie)
                    self.tableViewTopMovie.frame = CGRect(x: 0, y: self.view.frame.width * 1/1.65 , width: self.view.frame.width, height: self.view.frame.height - self.view.frame.width * 1/1.65)
                    self.loaderImage.isHidden = true
                    

                })
            })
        }
    }
    func Notification() {
        NotificationCenter.default.addObserver(self, selector: #selector(movieDetail), name: NSNotification.Name(rawValue: movieDetailFromMain), object: nil)
    }
    func movieDetail(_ notification : Notification) {
        let movie = notification.userInfo?["movie"] as! Movie
        let movieDetailViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        movieDetailViewController.movie = movie
        self.navigationController?.pushViewController(movieDetailViewController, animated: true)
    }

    
}
