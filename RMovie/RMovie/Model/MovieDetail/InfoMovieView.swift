//
//  InfoMovieView.swift
//  RMovie
//
//  Created by Hai on 1/5/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit

class InfoMovieView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var genreColletion: UICollectionView!
    @IBOutlet weak var castCollection: UICollectionView!
    @IBOutlet weak var desciptionText: UITextView!
    
    var movie : Movie!
    
    weak var vc : UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    func setup() {
        
        // Set Delegate adn DataSource
        
        self.genreColletion.delegate = self
        self.genreColletion.dataSource = self
        self.castCollection.delegate = self
        self.castCollection.dataSource = self
        
        // Register Cell
        
        let castNib = UINib(nibName: "CastViewCell", bundle: nil)
        self.castCollection.register(castNib, forCellWithReuseIdentifier: "CastViewCell")
        let genreNib = UINib(nibName: "GenreCollectionViewCell", bundle: nil)
        self.genreColletion.register(genreNib, forCellWithReuseIdentifier: "GenreCollectionViewCell")
        
        // Configure Layout
        
        let layout = self.genreColletion.collectionViewLayout as! UICollectionViewFlowLayout
        layout.estimatedItemSize = CGSize(width: self.genreColletion.frame.width/5, height: self.genreColletion.frame.height/2.5)
        let castLayout = self.castCollection.collectionViewLayout as! UICollectionViewFlowLayout
        castLayout.itemSize = CGSize(width: self.castCollection.frame.height/2 , height: self.castCollection.frame.height/2 )
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        // UI Setup
        self.genreColletion.backgroundColor = .none
        self.castCollection.backgroundColor = .none
    }
    
    func setDecription() {
        self.desciptionText.text = self.movie.overview
    }
    
    // DataSource Method
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == genreColletion {
            return movie.genre.count
        }
        return self.movie.casts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == genreColletion {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCollectionViewCell", for: indexPath) as! GenreCollectionViewCell
        let genreName = Movie.shared.convertGenre(genre: movie.genre[indexPath.row])
        cell.genresName.text = genreName
            return cell
        }
        
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastViewCell", for: indexPath) as! CastViewCell
        let posterUrl = URL(string: movie.casts[indexPath.row].poster)
            cell.imageActor.sd_setImage(with: posterUrl)
            cell.castName.text = movie.casts[indexPath.row].name
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == castCollection {
            print("did sellect item ")
            let actorVC = self.vc?.storyboard?.instantiateViewController(withIdentifier: "ActorDetailViewController") as! ActorDetailViewController
            actorVC.actor =  movie.casts[indexPath.row]
            self.vc?.navigationController?.pushViewController(actorVC, animated: true)
        }
    }
}
