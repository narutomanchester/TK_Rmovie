//
//  SimilarMovieView.swift
//  RMovie
//
//  Created by Hai on 1/8/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit

class SimilarMovieView: UIView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var similarCollection: UICollectionView!
    
    var movies : [Movie]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.similarCollection.delegate = self
        self.similarCollection.dataSource = self
        self.similarCollection.backgroundColor = .none
        let nib = UINib(nibName: "SimilarMovieCell", bundle: nil)
        self.similarCollection.register(nib, forCellWithReuseIdentifier: "SimilarMovieCell")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarMovieCell", for: indexPath) as! SimilarMovieCell
        
        //cell.nameLabel.text = movies[indexPath.row].name!
        let url = URL(string: movies[indexPath.row].poster)
        //print("url", cell.nameLabel.text)
        cell.imagePoster.sd_setImage(with: url)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.similarCollection.frame.height * 220/350, height: self.similarCollection.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = ["movie": movies[indexPath.row]]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: movieDetailFromSimilerNotification), object: nil, userInfo: movie)
        
    }
}
