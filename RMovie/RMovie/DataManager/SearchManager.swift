//
//  SearchManager.swift
//  RMovie
//
//  Created by Hai on 1/2/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchManager {
    
    static let share = SearchManager()
    
    func searchPeople(searchText: String, completion : @escaping(_ null : Bool, _ people: [Actor]) -> Void) {
        var actors = [Actor]()
        let url = (actorSearchUrl + searchText).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        Alamofire.request(url!).responseJSON { (reponse) in
            guard let value =  reponse.result.value else {
                return
            }
            let json = JSON(value)
            
            guard let results = json["results"].array else {
                return
            }
            for result in results {
                let actor = Actor()
                
                guard let id = result["id"].int else {
                    return
                }
                actor.id = id
                guard let name = result["name"].string else {
                    return
                }
                actor.name = name
                guard let popularity = result["popularity"].float else {
                    return
                }
                actor.popularity = popularity
                let posterPath = result["profile_path"].string
                if posterPath != nil {
                    let poster = imageGetUrl + posterPath!
                    actor.poster = poster
                } else {
                    actor.poster = "https://s28.postimg.org/k2a1kzlq5/people.jpg"
                }
                actors.append(actor)
            }
            if actors.count == 0 {
                completion(true, actors)
            } else {
                completion(false, actors)
            }
        }
    }
    
    func searchMovie(searchText : String,completion: @escaping(_ null: Bool, _ movies: [Movie]) -> Void) {
        var movies = [Movie]()
        let url = (movieSearchUrl + searchText).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
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
                let media = result["media_type"].string
                if media == person {
                    print("abe")
                }else {
                    // Check what kind (person, media, tv)
                    switch media {
                    case tv? :
                        movie.media_type = media
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
                    case movieMedia? :
                        movie.media_type = media
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
            }
            if movies.count == 0 {
                completion(true, movies)
            }else {
                completion(false, movies)
            }
        }
    }
    
    func searchTopRandomFilm(completion: @escaping(_ movies: [Movie]) -> Void) {
        var movies = [Movie]()
        for page in 1..<6 {
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
                        movie.poster = "https://s27.postimg.org/i2ms0o2xv/poster.jpg"
                    }
                    
                    
                    let backdropPath = result["backdrop_path"].string
                    if (backdropPath != nil) {
                        let backdrop = imageGetUrl + backdropPath!
                        movie.backdrop = backdrop
                    } else {
                        movie.backdrop = "https://s30.postimg.org/lyqeydan5/backdrop.jpg"
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
                completion(movies)
            }
            
        }
  
    }
    
}


