//
//  ReferenceMovieCollection.swift
//  RMovie
//
//  Created by Admin on 1/8/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit
import SDWebImage


class ReferenceMovieCollection: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var movies : [Movie]!
    
    weak var vc : UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = .none
        let nib = UINib(nibName: "MovieCell", bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: "MovieCell")
       
    }
    func setUP () {
        let castLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
        castLayout.itemSize = CGSize(width: self.frame.height * 1/3 , height: self.frame.height/2 )
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let url = URL(string: movies[indexPath.row].poster)
        cell.poster.sd_setImage(with: url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        SearchManager.share.searchMovieDetail(media_type: movies[indexPath.row].media_type, id: movies[indexPath.row].id) { (movieSearched) in
            let movieVC = self.vc?.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
            movieVC.movie =  movieSearched
            self.vc?.navigationController?.pushViewController(movieVC, animated: true)

        }
        
    }
  }
