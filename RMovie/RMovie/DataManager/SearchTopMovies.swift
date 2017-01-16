//
//  SearchTopMovies.swift
//  RMovie
//
//  Created by mac on 1/9/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

extension SearchManager {
    
    func searchTopFilm(completion: @escaping(_ movies: [Movie]) -> Void) {
        var movies = [Movie]()
        for page in 1..<6 {
            var movies = [Movie]()
            let url = (topMovieSearchUrlBegin + String(page) + topMovieSearchUrlEnd).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            //print(url)
            Alamofire.request(url!).responseJSON { (response) in
                guard let value = response.result.value else {
                    return
                }
                let json = JSON(value)
                guard let results = json["results"].array else {
                    return
                }
                for result in results {
                    let movie = Movie()
                    //print(1)
                    guard let id = result["id"].int else {
                        return
                    }
                    movie.id = id
                    
                    guard let name = result["original_title"].string else {
                        return
                    }
                    movie.name = name
                    
                    
                    let posterPath = result["poster_path"].string
                    if (posterPath != nil) {
                        let poster = imageGetUrl + posterPath!
                        movie.poster = poster
                    } else {
                        movie.poster = "https://s-media-cache-ak0.pinimg.com/564x/3d/32/27/3d32271e87fc2ee5f44f1a0fe189c804.jpg"
                    }
                    
                    
                    let backdropPath = result["backdrop_path"].string
                    if (backdropPath != nil) {
                        let backdrop = imageGetUrl + backdropPath!
                        movie.backdrop = backdrop
                    } else {
                        movie.backdrop = "https://s-media-cache-ak0.pinimg.com/564x/3d/32/27/3d32271e87fc2ee5f44f1a0fe189c804.jpg"
                    }
                    
                    guard let popularity = result["popularity"].float else {
                        return
                    }
                    movie.popularity = popularity
                    //print(popularity)
                    
                    
                    guard let release_date = result["release_date"].string else {
                        return
                    }
                    //print("date")
                    if release_date == "" {
                        let year = "unknow"
                        movie.year = year
                    } else {
                        let range = release_date.startIndex..<release_date.index(release_date.startIndex, offsetBy: 4)
                        let year = release_date[range]
                        movie.year = year
                    }
                    
                    //print("date")
                    guard let score = result["vote_average"].float else {
                        return
                    }
                    movie.score = score
                    //print(score)
                    
                    guard let overview = result["overview"].string else {
                        return
                    }
                    movie.overview = overview
                    //print(overview)
                    
                    guard let genres = result["genre_ids"].array else {
                        return
                    }
                    var genresArr = [Int]()
                    for genre in genres {
                        genresArr.append(Int(genre.number!))
                    }
                    movie.genre = genresArr
                    
                    movie.media_type = movieMedia
                    //print(movieMedia)
                    movies.append(movie)
                    
                }
                //self.appendMoviesToTopMovies(movies: movies)
                completion(movies)
            }
            
        }
        
    }
//    func appendMoviesToTopMovies(movies : [Movie])  {
//        for movie in movies {
//            //print(movie.id)
//            self.topMovies.append(movie)
//        }
//        print(topMovies.count)
//    }

}
