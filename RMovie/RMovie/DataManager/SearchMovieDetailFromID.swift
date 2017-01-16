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
    
// main Search : ham nay duoc su dung de lay thong tin chi tiet cua phim voi id va the loai la tv hoac movieMedia
    func searchMovieDetail(media_type : String, id: Int,completion: @escaping(_ movie : Movie) -> Void){
        switch media_type {
        case "tv":
            searchMovieDetailFromTvId(id: id, completion: { (movie) in
                completion(movie)
            })
            break
            
        case "movieMedia":
            searchMovieDetailFromMovieMediaId(id: id, completion: { (movie) in
                completion(movie)
            })
        default:
            break
        }
    
    }
    
func searchMovieDetailFromMovieMediaId(id: Int,completion: @escaping(_ movie : Movie) -> Void){
    
    let url = "https://api.themoviedb.org/3/movie/\(id)?api_key=f37e7e147e496587dbbd3e506735b98d&language=en-US"
    
    let movie = Movie()
    movie.id = id
    Alamofire.request(url).responseJSON { (reponse) in
        guard let value = reponse.result.value else {
            return
        }
        
        var year : String!
        let json = JSON(value)
        
        guard let name = json["original_title"].string else {
            return
        }
        movie.name = name
        guard let release_date = json["release_date"].string else {
            return
        }
        if release_date == "" {
            year = "unknow"
        } else {
            let range = release_date.startIndex..<release_date.index(release_date.startIndex, offsetBy: 4)
            year = release_date[range]
        }
        movie.year =  year
        guard let overview = json["overview"].string else {
            return
        }
        movie.overview = overview
        print("overview", movie.overview)
        guard let score = json["vote_average"].float else {
            return
        }
        guard let genresResult = json["genres"].array else {
            return
        }
        var genres = [Int]()
        for genre in genresResult {
            guard let genreId = genre["id"].int else {
                return
            }
            genres.append(genreId)
        }
        movie.genre = genres
        print("genre", movie.genre)
        movie.score = score
        print("score", score)
        guard let popularity = json["popularity"].float else {
            return
        }
        movie.popularity = popularity
        let posterPath = json["poster_path"].string
        
        //Check if nil
        if (posterPath != nil) {
            let poster = imageGetUrl + posterPath!
            movie.poster = poster
        } else {
            movie.poster = "https://s-media-cache-ak0.pinimg.com/564x/3d/32/27/3d32271e87fc2ee5f44f1a0fe189c804.jpg"
        }
        let backdropPath = json["backdrop_path"].string
        
        //Check if nil
        if (backdropPath != nil) {
            let backdrop = imageGetUrl + backdropPath!
            movie.backdrop = backdrop
        } else {
            movie.backdrop = "https://s-media-cache-ak0.pinimg.com/564x/3d/32/27/3d32271e87fc2ee5f44f1a0fe189c804.jpg"
        }
        
        movie.media_type = "movieMedia"
        completion(movie)
        }
    }
    
    
    func searchMovieDetailFromTvId(id: Int,completion: @escaping(_ movie : Movie) -> Void){
        
        let url = "https://api.themoviedb.org/3/tv/\(id)?api_key=f37e7e147e496587dbbd3e506735b98d&language=en-US"
        
        let movie = Movie()
        movie.id = id
        Alamofire.request(url).responseJSON { (reponse) in
            guard let value = reponse.result.value else {
                return
            }
            
            var year : String!
            let json = JSON(value)
            
            guard let name = json["name"].string else {
                return
            }
            movie.name = name
            guard let release_date = json["first_air_date"].string else {
                return
            }
            if release_date == "" {
                year = "unknow"
            } else {
                let range = release_date.startIndex..<release_date.index(release_date.startIndex, offsetBy: 4)
                year = release_date[range]
            }
            movie.year =  year
            guard let overview = json["overview"].string else {
                return
            }
            movie.overview = overview
            print("overview", movie.overview)
            guard let score = json["vote_average"].float else {
                return
            }
            guard let genresResult = json["genres"].array else {
                return
            }
            var genres = [Int]()
            for genre in genresResult {
                guard let genreId = genre["id"].int else {
                    return
                }
                genres.append(genreId)
            }
            movie.genre = genres
            print("genre", movie.genre)
            movie.score = score
            print("score", score)
            guard let popularity = json["popularity"].float else {
                return
            }
            movie.popularity = popularity
            let posterPath = json["poster_path"].string
            
            //Check if nil
            if (posterPath != nil) {
                let poster = imageGetUrl + posterPath!
                movie.poster = poster
            } else {
                movie.poster = "https://s-media-cache-ak0.pinimg.com/564x/3d/32/27/3d32271e87fc2ee5f44f1a0fe189c804.jpg"
            }
            let backdropPath = json["backdrop_path"].string
            
            //Check if nil
            if (backdropPath != nil) {
                let backdrop = imageGetUrl + backdropPath!
                movie.backdrop = backdrop
            } else {
                movie.backdrop = "https://s-media-cache-ak0.pinimg.com/564x/3d/32/27/3d32271e87fc2ee5f44f1a0fe189c804.jpg"
            }
            
            movie.media_type = "tv"
            completion(movie)
        }
    }

    
    
}
