//
//  SearchMainBanner.swift
//  RMovie
//
//  Created by Hai on 1/13/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

extension SearchManager {
    func searchMainBanner(completion: @escaping(_ movies : [Movie]) -> Void) {
        var movies = [Movie]()
        let url = "https://api.themoviedb.org/3/discover/movie?api_key=f37e7e147e496587dbbd3e506735b98d&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&vote_count.gte=1000&year=2016".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        Alamofire.request(url!).responseJSON { (reponse) in
            guard let value = reponse.result.value else {
                return
            }
            let json = JSON(value)
            guard let results = json["results"].array else {
                return
            }
            var i = 0
            for result in results {
                let movie = Movie()
                movie.media_type = movieMedia
                guard let name = result["original_title"].string else {
                    return
                }
                movie.name = name
                guard let release_date = result["release_date"].string else {
                    return
                }
                if release_date == "" {
                    let year = "unknow"
                    movie.year = year
                } else {
                    let range = release_date.startIndex..<release_date.index(release_date.startIndex, offsetBy: 4)
                    let year = release_date[range]
                    movie.year = year
                }
                guard let id = result["id"].int else {
                    return
                }
                movie.id = id
                guard let overview = result["overview"].string else {
                    return
                }
                movie.overview = overview
                guard let score = result["vote_average"].float else {
                    return
                }
                guard let genresResult = result["genre_ids"].array else {
                    return
                }
                var genres = [Int]()
                for genre in genresResult {
                    let gen = Int(genre.number!)
                    genres.append(gen)
                }
                movie.genre = genres
                movie.score = score
                guard let popularity = result["popularity"].float else {
                    return
                }
                movie.popularity = popularity
                let posterPath = result["poster_path"].string
                
                //Check if nil
                if (posterPath != nil) {
                    let poster = imageGetUrl + posterPath!
                    movie.poster = poster
                } else {
                    movie.poster = "https://s27.postimg.org/i2ms0o2xv/poster.jpg"
                }
                let backdropPath = result["backdrop_path"].string
                
                //Check if nil
                if (backdropPath != nil) {
                    let backdrop = imageGetUrl + backdropPath!
                    movie.backdrop = backdrop
                } else {
                    movie.backdrop = "https://s30.postimg.org/lyqeydan5/backdrop.jpg"
                }
                movies.append(movie)
                i += 1
                if i == 4 {
                    break
                }
            }
            completion(movies)
        }
    }
    func searchTopMovie(urlPath: String, completion: @escaping(_ movies : [Movie]) -> Void) {
        var movies = [Movie]()
        let url = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        Alamofire.request(url!).responseJSON { (reponse) in
            guard let value = reponse.result.value else {
                return
            }
            let json = JSON(value)
            guard let results = json["results"].array else {
                return
            }
            for result in results {
                let movie = Movie()
                movie.media_type = movieMedia
                guard let name = result["original_title"].string else {
                    return
                }
                movie.name = name
                guard let release_date = result["release_date"].string else {
                    return
                }
                if release_date == "" {
                    let year = "unknow"
                    movie.year = year
                } else {
                    let range = release_date.startIndex..<release_date.index(release_date.startIndex, offsetBy: 4)
                    let year = release_date[range]
                    movie.year = year
                }
                guard let id = result["id"].int else {
                    return
                }
                movie.id = id
                guard let overview = result["overview"].string else {
                    return
                }
                movie.overview = overview
                guard let score = result["vote_average"].float else {
                    return
                }
                guard let genresResult = result["genre_ids"].array else {
                    return
                }
                var genres = [Int]()
                for genre in genresResult {
                    let gen = Int(genre.number!)
                    genres.append(gen)
                }
                movie.genre = genres
                movie.score = score
                guard let popularity = result["popularity"].float else {
                    return
                }
                movie.popularity = popularity
                let posterPath = result["poster_path"].string
                
                //Check if nil
                if (posterPath != nil) {
                    let poster = imageGetUrl + posterPath!
                    movie.poster = poster
                } else {
                    movie.poster = "https://s27.postimg.org/i2ms0o2xv/poster.jpg"
                }
                let backdropPath = result["backdrop_path"].string
                
                //Check if nil
                if (backdropPath != nil) {
                    let backdrop = imageGetUrl + backdropPath!
                    movie.backdrop = backdrop
                } else {
                    movie.backdrop = "https://s30.postimg.org/lyqeydan5/backdrop.jpg"
                }
                movies.append(movie)
            }
            completion(movies)
        }
    }
    func searchTopTV(completion: @escaping(_ movies : [Movie]) -> Void) {
        var movies = [Movie]()
        let url = "https://api.themoviedb.org/3/discover/tv?api_key=f37e7e147e496587dbbd3e506735b98d&language=en-US&sort_by=popularity.desc&page=1&timezone=America/New_York&vote_average.gte=7.5&vote_count.gte=100&include_null_first_air_dates=false".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        Alamofire.request(url!).responseJSON { (reponse) in
            guard let value = reponse.result.value else {
                return
            }
            let json = JSON(value)
            guard let results = json["results"].array else {
                return
            }
            for result in results {
                let movie = Movie()
                movie.media_type = tv
                guard let name = result["name"].string else {
                    return
                }
                movie.name = name
                guard let release_date = result["first_air_date"].string else {
                    return
                }
                if release_date == "" {
                    let year = "unknow"
                    movie.year = year
                } else {
                    let range = release_date.startIndex..<release_date.index(release_date.startIndex, offsetBy: 4)
                    let year = release_date[range]
                    movie.year = year
                }
                guard let id = result["id"].int else {
                    return
                }
                movie.id = id
                guard let overview = result["overview"].string else {
                    return
                }
                movie.overview = overview
                guard let score = result["vote_average"].float else {
                    return
                }
                guard let genresResult = result["genre_ids"].array else {
                    return
                }
                var genres = [Int]()
                for genre in genresResult {
                    let gen = Int(genre.number!)
                    genres.append(gen)
                }
                movie.genre = genres
                movie.score = score
                guard let popularity = result["popularity"].float else {
                    return
                }
                movie.popularity = popularity
                let posterPath = result["poster_path"].string
                
                //Check if nil
                if (posterPath != nil) {
                    let poster = imageGetUrl + posterPath!
                    movie.poster = poster
                } else {
                    movie.poster = "https://s27.postimg.org/i2ms0o2xv/poster.jpg"
                }
                let backdropPath = result["backdrop_path"].string
                
                //Check if nil
                if (backdropPath != nil) {
                    let backdrop = imageGetUrl + backdropPath!
                    movie.backdrop = backdrop
                } else {
                    movie.backdrop = "https://s30.postimg.org/lyqeydan5/backdrop.jpg"
                }
                movies.append(movie)
            }
            completion(movies)
        }
    }


}
