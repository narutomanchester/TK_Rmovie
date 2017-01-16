//
//  SearchSimilarMovie.swift
//  RMovie
//
//  Created by Hai on 1/8/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

extension SearchManager {
    
    func searhSimilarMovie(media_type: String, id : Int, completion: @escaping(_ movies : [Movie]) -> Void) {
        var movies = [Movie]()
        var url = String()
        
        if media_type == movieMedia {
            url = ("https://api.themoviedb.org/3/movie/\(id)/similar?api_key=f37e7e147e496587dbbd3e506735b98d&language=en-US&page=1").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        } else {
            url = ("https://api.themoviedb.org/3/tv/\(id)/similar?api_key=f37e7e147e496587dbbd3e506735b98d&language=en-US&page=1").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        }
        Alamofire.request(url).responseJSON { (reponse) in
            guard let value = reponse.result.value else {
                return
            }
            let json = JSON(value)
            guard let results = json["results"].array else {
                return
            }
            for result in results {
                let movie = Movie()
                    switch media_type {
                    case tv :
                        movie.media_type = media_type
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
                    case movieMedia :
                        movie.media_type = media_type

                        guard let name = result["original_title"].string else {
                            return
                        }
                        movie.name = name
                        print("similar name", movie.name)
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
                    default:
                        break
                    }
                    guard let id = result["id"].int else {
                        break
                    }
                    movie.id = id
                    guard let overview = result["overview"].string else {
                        return
                    }
                    movie.overview = overview
                    print("overview", movie.overview)
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
                    print("genre", movie.genre)
                    movie.score = score
                    print("score", score)
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
                    var casts = [Actor]()
                    movies.append(movie)
                }
                completion(movies)
            }
        
        }

        

    }
