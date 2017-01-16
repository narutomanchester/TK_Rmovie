//
//  SearchActorDetail.swift
//  RMovie
//
//  Created by Admin on 1/8/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

// (Trung)
import UIKit
import Alamofire
import SwiftyJSON

extension SearchManager {
    
    //MARK: Search actor information
    func searchActorDetailInfo(id: Int,completion: @escaping(_ name : String, _ placeOfBirth : String, _ birthday : String, _ biography : String, _ popularity : Float) -> Void) {
        let url = "https://api.themoviedb.org/3/person/\(id)?api_key=f37e7e147e496587dbbd3e506735b98d&language=en-US"
        
        print("url actor detail",url)
        Alamofire.request(url).responseJSON { (reponse) in
            guard let value = reponse.result.value else {
                return
            }
            let json = JSON(value)
            
            guard let name = json["name"].string else {
                return
            }
            guard let placeOfBirth = json["place_of_birth"].string else {
                return
            }
            guard let birthday = json["birthday"].string else {
                return
            }
            guard let biography = json["biography"].string else {
                return
            }
            guard let popularity = json["popularity"].float else {
                return
            }
            completion(name, placeOfBirth, birthday, biography, popularity)
        }
    }
    
    
    //MARK: SearchActorlistMovie
    
    func searchActorDetailMovie(id: Int,completion: @escaping(_ movies : [Movie]) -> Void) {
        
        searchActorDetailMovie1(id: id) { (movies1) in
            var movies = [Movie]()
            for i in 0..<movies1.count {
                movies.append(movies1[i])
            }
            let url = "https://api.themoviedb.org/3/person/\(id)/movie_credits?api_key=f37e7e147e496587dbbd3e506735b98d&language=en-US"
            
            //        var i = 0
            Alamofire.request(url).responseJSON { (reponse) in
                guard let value = reponse.result.value else {
                    return
                }
                let json = JSON(value)
                
                guard let casts = json["cast"].array else {
                    return
                }
                
                for cast in casts {
                    let movie = Movie()
                    guard let movieID = cast["id"].int else {
                        return
                    }
                    let posterPath = cast["poster_path"].string
                    if (posterPath != nil) {
                        let poster = imageGetUrl + posterPath!
                        movie.poster = poster
                    } else {
                        movie.poster = "https://s-media-cache-ak0.pinimg.com/564x/3d/32/27/3d32271e87fc2ee5f44f1a0fe189c804.jpg"
                    }
                    
                    
                    movie.id = movieID
                    movie.media_type = "movieMedia"
                    movies.append(movie)
                    print("+ 1 Movie (moviemedia) with id = \(movieID)")
                    //                i += 1
                }
                completion(movies)
                
            }
            
        }

    }
    func searchActorDetailMovie1(id: Int,completion: @escaping(_ movies : [Movie]) -> Void) {

        var movies = [Movie]()
        let url2 = "https://api.themoviedb.org/3/person/\(id)/tv_credits?api_key=f37e7e147e496587dbbd3e506735b98d&language=en-US"
        
        Alamofire.request(url2).responseJSON { (reponse) in
            guard let value = reponse.result.value else {
                return
            }
            let json = JSON(value)
            
            guard let casts = json["cast"].array else {
                return
            }
            
            for cast in casts {
                let movie = Movie()
                guard let movieID = cast["id"].int else {
                    return
                }
                let posterPath = cast["poster_path"].string
                //Check if nil
                if (posterPath != nil) {
                    let poster = imageGetUrl + posterPath!
                    movie.poster = poster
                } else {
                    movie.poster = "https://s-media-cache-ak0.pinimg.com/564x/3d/32/27/3d32271e87fc2ee5f44f1a0fe189c804.jpg"
                }
                
                movie.id = movieID
                movie.media_type = "tv"
                movies.append(movie)
                print("+ 1 Movie (tv) with id = \(movieID)")
                //                i += 1
            }
            completion(movies)
        }

        
    }
}
