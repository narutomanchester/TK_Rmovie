//
//  SearchDetail.swift
//  RMovie
//
//  Created by Hai on 1/5/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

extension SearchManager {
    
    func searchTrailer(id: Int, completion: @escaping(_ trailerYoutubeId : String) -> Void) {
        var youtubeID = String()
        let url = ("https://api.themoviedb.org/3/movie/\(id)/videos?api_key=f37e7e147e496587dbbd3e506735b98d&language=en-US").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        Alamofire.request(url!).responseJSON { (reponse) in
            guard let value = reponse.result.value else {
                return
            }
            let json = JSON(value)
            
            guard let results = json["results"].array else {
                return
            }
            switch results.count {
            case 0:
                youtubeID = "vVTtvWi11Q8"
            case 1:
                guard let id = results[0]["key"].string else {
                    return
                }
                youtubeID = id
            default:
                guard let id = results[1]["key"].string else {
                    return
                }
                youtubeID = id
            }
            completion(youtubeID)
        }
    }
    
    func searchMovieCast(mediaType : String,id: Int,completion: @escaping(_ actors : [Actor]) -> Void) {
        var url = String()
        var actors = [Actor]()
        if (mediaType == movieMedia || mediaType == movieMedia2) {
        url = ("https://api.themoviedb.org/3/movie/\(id)/credits?api_key=f37e7e147e496587dbbd3e506735b98d").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        } else {
            url = ("https://api.themoviedb.org/3/tv/\(id)/credits?api_key=f37e7e147e496587dbbd3e506735b98d").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        }
        print("url cast",url)
        Alamofire.request(url).responseJSON { (reponse) in
            guard let value = reponse.result.value else {
                return
            }
            let json = JSON(value)
            
            guard let casts = json["cast"].array else {
                return
            }
            var i = 0
            for cast in casts {
                let actor = Actor()
                    guard let id = cast["id"].int else {
                        return
                    }
                    print("id cast", id)
                    actor.id = id
                    guard let name = cast["name"].string else {
                        return
                    }
                    actor.name = name
                    let posterPath = cast["profile_path"].string
                    
                    print("cast poster", posterPath)
                    
                    //Check if nil
                    if (posterPath != nil) {
                        let poster = imageGetUrl + posterPath!
                        actor.poster = poster
                    } else {
                        actor.poster = "https://s28.postimg.org/k2a1kzlq5/people.jpg"
                    }
                    actors.append(actor)
                    i += 1
                if i == 9 {
                    break
                }
            }
            completion(actors)
        }
    }
}
