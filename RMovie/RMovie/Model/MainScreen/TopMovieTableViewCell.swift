//
//  TopMovieTableViewCell.swift
//  RMovie
//
//  Created by Hai on 1/14/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit

class TopMovieTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var labelName: UILabel!
    
    var  movies : [Movie]!

    @IBOutlet weak var collectionViewTopMovie: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        let nib = UINib(nibName: "TopCollectionViewCell", bundle: nil)
        self.collectionViewTopMovie.register(nib, forCellWithReuseIdentifier: "TopCollectionViewCell")
    }
    func setUP () {
        self.collectionViewTopMovie.backgroundColor = .none
        self.backgroundColor = .none
        let layout = self.collectionViewTopMovie.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: self.frame.height * 0.37, height: self.frame.height * 2/3)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        self.collectionViewTopMovie.delegate = self
        self.collectionViewTopMovie.dataSource = self
        //print(self.movies.count)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopCollectionViewCell", for: indexPath) as! TopCollectionViewCell
        cell.name.text = self.movies[indexPath.row].name
        let url = URL(string: self.movies[indexPath.row].poster)
        cell.posterImage.sd_setImage(with: url)
        cell.setUp()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = ["movie": movies[indexPath.row]]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: movieDetailFromMain), object: nil, userInfo: movie)
    }
    
    
}
