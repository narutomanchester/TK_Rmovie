//
//  MovieCollection.swift
//  RMovie
//
//  Created by Hai on 1/2/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit
import SDWebImage


class MovieCollection: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var layout: LNICoverFlowLayout!
    
    var movies : [Movie]!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = .none
        let nib = UINib(nibName: "SearchCell", bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: "SearchCell")
    }
    
    func setUP ()  {
        self.layout.itemSize = CGSize(width: self.frame.width * 3/4 * 3/4, height: self.frame.width * 1.125 * 3/4)
        self.layout.coverDensity = 0.15
        self.layout.minCoverOpacity = 0.2
        self.layout.minCoverScale = 0.5
        self.reloadData()
        
    }
    
    // DataSoure Method

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as! SearchCell
        cell.labelName.text = movies[indexPath.row].name
        let url = URL(string: movies[indexPath.row].poster)
        cell.poster.sd_setImage(with: url)
        cell.movieScore.text = "\(movies[indexPath.row].score!)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = ["movie": movies[indexPath.row]]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: movieDetailNotification), object: nil, userInfo: movie)
    }
    

}
